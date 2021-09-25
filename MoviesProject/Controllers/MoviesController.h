//
//  MoviesControllerViewController.h
//  MoviesProject
//
//  Created by Eyal Avissar on 25/09/2021.
//  Copyright © 2021 Eyal Avissar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviesModel.h"
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MoviesDelegate <NSObject>



@end


@interface MoviesController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *moviesTable;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)sortMovies:(id)sender;

@end

NS_ASSUME_NONNULL_END
