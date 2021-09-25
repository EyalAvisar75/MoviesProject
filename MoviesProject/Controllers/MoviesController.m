//
//  MoviesControllerViewController.m
//  MoviesProject
//
//  Created by Eyal Avissar on 25/09/2021.
//  Copyright © 2021 Eyal Avissar. All rights reserved.
//

#import "MoviesController.h"

@interface MoviesController ()

{
    MoviesModel *myMoviesModel;
    NSMutableArray *movies;
}

@end

@implementation MoviesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moviesTable.delegate = self;
    self.moviesTable.dataSource = self;
    
    myMoviesModel = [[MoviesModel alloc] init];

    [myMoviesModel getAllMovies:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.moviesTable reloadData];
        });
    }];
    
}




- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSLog(@"rows %lu", (unsigned long)[movies count]);
    Movie *movie = movies[indexPath.row];
    
    cell.textLabel.text = movie.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", movie.year];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!movies) {
        movies = [myMoviesModel.moviesModel copy];
    }
    
    return [myMoviesModel.moviesModel count];
}


@end
