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
                
        NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
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
                    movie.movieYear = [jsonMovies[index][@"year"] intValue];
                    
                    [self->movies addObject:movie];
                }
                
                self.moviesModel = self->movies;

                completion();

            }
        }];
        [task resume];
    }
}

- (void)getMovieDescriptionById:(NSString *) movieId completion :(void (^)(void))handleCompletion {
        
    NSString *moviesURLString = [NSString stringWithFormat:@"https://x-mode.co.il/exam/descriptionMovies#4.txt"];
//
    
    /*
     got this as data string
     MoviesProject[5079:219014] <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
     <html>
      <head>
       <title>Index of /exam/descriptionMovies</title>
      </head>
      <body>
     <h1>Index of /exam/descriptionMovies</h1>
     <ul></ul>
     </body></html>
     */
    
        
    //    NSString *moviesURLString = [NSString stringWithFormat:@"https://x-mode.co.il/exam/descriptionMovies4.txt"];
    /*
     got this as data string

     2021-09-25 13:41:16.856913+0300 MoviesProject[5098:220217] <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
     <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="he">
     <head>
     <title>x-mode.co.il - </title>
     <meta name="description" content="" />
     <meta name="keywords" content="" />
     <meta http-equiv="content-type"...
     */

        NSURL* url = [NSURL URLWithString: moviesURLString];
        
        NSURLSession* session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"Error downloading movie data");
                NSLog(@"%@",error.localizedDescription);
                return;
            }
            
            
            if (data) {
                NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSLog(@"%@", dataString);
                handleCompletion();
            }
        }];
        
        [task resume];
}


@end
