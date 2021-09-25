//
//  MovieDetailController.m
//  MoviesProject
//
//  Created by Eyal Avissar on 25/09/2021.
//  Copyright © 2021 Eyal Avissar. All rights reserved.
//

#import "MovieDetailController.h"

@interface MovieDetailController ()

@end

@implementation MovieDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.myMoviesModel getMovieDescriptionById: self.movieId completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.movieTextView.text = @"Text goes here.\n The generalPlan: hold movie as a property of this view. Check if files by movie name description, movie name image, exist with file manager. If so, get image - image with urlContents from one and text from anothe. Else, call URLSession with download task, create two files accordingly. Files should probably be temporary, or we should check for date attribute within decided range.";
        });
    }];
}



@end
