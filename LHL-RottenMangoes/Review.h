//
//  Review.h
//  LHL-RottenMangoes
//
//  Created by Asuka Nakagawa on 2016-05-26.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface Review : Movie

// for detailedVC to display critic & quote
@property (nonatomic) NSString *criticName;
@property (nonatomic) NSString *quote;

@end