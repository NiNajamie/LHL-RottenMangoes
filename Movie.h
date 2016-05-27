//
//  Movie.h
//  LHL-RottenMangoes
//
//  Created by Asuka Nakagawa on 2016-05-24.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Movie : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *synopsis;

@property (nonatomic) NSURL *url;
@property (nonatomic) NSURL *thumbnail;

@property (nonatomic) NSString *movieId;

// for detailedVC to display critic & quote
@property (nonatomic) NSString *criticName;
@property (nonatomic) NSString *quote;

// storing reviewObject to the reviewsArray
@property (nonatomic) NSMutableArray *reviews;




@end
