//
//  MoviesControllerViewController.m
//  MoviesProject
//
//  Created by Eyal Avissar on 25/09/2021.
//  Copyright © 2021 Eyal Avissar. All rights reserved.
//

#import "MoviesController.h"
#import "MovieCell.h"
#import "MovieDetailController.h"

@interface MoviesController ()

{
    MoviesModel *myMoviesModel;
    NSMutableArray *movies;
    NSMutableArray *searchedMovies;
    Boolean isSearchSuccess;
}

@end

@implementation MoviesController

//MARK:- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moviesTable.delegate = self;
    self.moviesTable.dataSource = self;
    [self.moviesTable registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:[MovieCell reuseIdentifier]];
    
    self.searchBar.delegate = self;
    
    myMoviesModel = [[MoviesModel alloc] init];
    
    [myMoviesModel getAllMovies:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.moviesTable reloadData];
        });
    }];
    
}

//MARK:- TableView DataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:[MovieCell reuseIdentifier]];
    
    Movie *movie = [Movie new];
    
    if (isSearchSuccess) {
        movie = searchedMovies[indexPath.row];
    }
    else {
        movie = movies[indexPath.row];
    }
    
    [self configureCell:movie movieCell:movieCell];

    return movieCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!movies && [myMoviesModel.moviesModel count]) {
        movies = [NSMutableArray arrayWithArray: myMoviesModel.moviesModel];
    }
    
    if(isSearchSuccess && [searchedMovies count] == 0) {
        return 0;
    }
    
    if(isSearchSuccess) {
        return [searchedMovies count];
    }
    
    return [myMoviesModel.moviesModel count];
}

//MARK:- TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    Movie *movie = isSearchSuccess ? searchedMovies[indexPath.row] : movies[indexPath.row];
        
    MovieDetailController *detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"MovieDetail"];
    
    detailController.movieId = movie.movieId;
    detailController.myMoviesModel = myMoviesModel;
    
    [self.navigationController pushViewController:detailController animated:true];
    
}

//MARK:- SearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearchSuccess = true;
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if(searchText.length == 0)
    {
        isSearchSuccess = false;
    }
    
    else
    {
        isSearchSuccess = true;
        searchedMovies = [[NSMutableArray alloc]init];

        for (Movie *movie in movies)
        {
            if ([movie.name containsString:searchText]) {
                [searchedMovies addObject:movie];
            }
        }
    }
    
    
    
    [self.moviesTable reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    isSearchSuccess = false;
    [self.moviesTable reloadData];
}



//MARK:- IBActions
- (IBAction)sortMovies:(UIBarButtonItem *)sender {
    if ([[sender title] isEqualToString:@"Show Movie List"]) {
        [sender setTitle:@"Show Sorted Movie List"];
        movies = [NSMutableArray arrayWithArray:myMoviesModel.moviesModel];
    }
    else {
        [sender setTitle:@"Show Movie List"];
        [movies sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            NSNumber *leftMovieYear = [NSNumber numberWithInt:[obj1 movieYear]];
            
            NSNumber *rightMovieYear = [NSNumber numberWithInt:[obj2 movieYear]];
            
            return [leftMovieYear compare: rightMovieYear];
        }];
    }
    [self.moviesTable reloadData];
}

//MARK:- Helper methods
- (void)configureCell:(Movie *)movie movieCell:(MovieCell *)movieCell {
    movieCell.nameLabel.text = movie.name;
    movieCell.yearLabel.text = [NSString stringWithFormat:@"%d", movie.movieYear];
}

@end
