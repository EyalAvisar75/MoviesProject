//
//  MovieDetailController.h
//  MoviesProject
//
//  Created by Eyal Avissar on 25/09/2021.
//  Copyright © 2021 Eyal Avissar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UITextView *movieTextView;

@end

NS_ASSUME_NONNULL_END
