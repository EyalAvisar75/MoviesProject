//
//  Movie.h
//  MoviesProject
//
//  Created by Eyal Avissar on 25/09/2021.
//  Copyright © 2021 Eyal Avissar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (copy) NSString *movieId;
@property (copy) NSString *name;
@property (copy) NSString *category;
@property int movieYear;

@end

NS_ASSUME_NONNULL_END
