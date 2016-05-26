//
//  DetailedViewController.m
//  LHL-RottenMangoes
//
//  Created by Asuka Nakagawa on 2016-05-25.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "DetailedViewController.h"
#import "Movie.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // URL that can return review JSON // 3 items
    NSString *reviewUrlString = @"http://api.rottentomatoes.com/api/public/v1.0/movies/771311818/reviews.json?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=3";
    
    NSURLSession *session1 = [NSURLSession sharedSession];
    NSURLSessionTask *reviewTask = [session1 dataTaskWithURL:[NSURL URLWithString:reviewUrlString] completionHandler:^(NSData *data1, NSURLResponse *response1, NSError *error1) {
        
        // if we don't get any error
        if (!error1) {
            NSError *jsonError1 = nil;
            
            // reviewJson is a whole dictionary
            NSDictionary *reviewJson = [NSJSONSerialization JSONObjectWithData:data1 options:0 error:&jsonError1];
            // inside the reviewJsonDictionary there's reviewArray
            NSArray *reviewArray = reviewJson[@"reviews"];
            // Create new EmptyArrayReviews holds review
            NSMutableArray *reviews = [NSMutableArray array];
            
            // accessing reviewsArray in reviewJsonDictionary to get Value of "url"
            for (NSDictionary *reviewDict in reviewArray) {
                // inside of the reviewsArray, there's linksDict
                NSDictionary *linksDict = reviewDict[@"reviews"];
                // create newEmpty Movie object
                Movie *review1 = [[Movie alloc] init];
                
                // set url to reviewURL in the movieObject
                review1.reviewURL = reviewDict[@"reviews"];
                review1.review = [NSURL URLWithString:linksDict[@"review"]];
                
                // Iterate through all the movies and create Movie object instances
                // put created reviewObject in the reviewsArray
                [reviews addObject:review1];
            }
            // save the "data"
            self.reviews = reviews;
            
            // reloadData after Downloading "data" main_queque which is the blockOfCode for getting data
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
    // 3.All of the the different tasks from NSURLSession start in a suspended state. Start the task here.
    [reviewTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
