//
//  MoviesModel.m
//  MoviesProject
//
//  Created by Eyal Avissar on 25/09/2021.
//  Copyright © 2021 Eyal Avissar. All rights reserved.
//https://x-mode.co.il/exam/allMovies/allMovies.txt
//https://x-mode.co.il/exam/descriptionMovies<#movieId>.txt

#import "MoviesModel.h"
#import "Movie.h"

@implementation MoviesModel
{
    NSMutableArray *movies;
}

- (void)getAllMovies:(void (^)(void))completion {
    if (!movies) {
        movies = [[NSMutableArray alloc] init];
        
        NSString *moviesURLString = @"https://x-mode.co.il/exam/allMovies/allMovies.txt";
        
        NSURL* url = [NSURL URLWithString: moviesURLString];
        
        NSURLSession* session = [NSURLSession sharedSession];
        
        NSURLSessionDownloadTask* task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"Eror downloading movie data");
                NSLog(@"%@",error.localizedDescription);
                return;
            }
            
            if (data) {
                NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSArray *jsonMovies = jsonDictionary[@"movies"];
                
                for (int index = 0; index < [jsonMovies count]; index++) {
                    
                    Movie *movie = [Movie new];
                    
                    movie.movieId = jsonMovies[index][@"Id"];
                    movie.name = jsonMovies[index][@"name"];
                    movie.category = jsonMovies[index][@"category"];
                    movie.year = [jsonMovies[index][@"year"] intValue];
                    
                    [self->movies addObject:movie];
                }
                
                self.moviesModel = self->movies;
                
                NSLog(@"my movies %lu", [self.moviesModel count]);
                
//                for (Movie *movie in self.moviesModel) {
//                    NSLog(@"%@", movie.name);
//                }
                
                completion();

            }
        }];
        [task resume];
    }
}


@end
