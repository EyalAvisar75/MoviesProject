//
//  MoviesModel.h
//  MoviesProject
//
//  Created by Eyal Avissar on 25/09/2021.
//  Copyright © 2021 Eyal Avissar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoviesModel : NSObject

@property NSArray *moviesModel;

-(void)getAllMovies:  (void (^)(void)) completion;

@end

NS_ASSUME_NONNULL_END
