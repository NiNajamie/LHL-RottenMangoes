//
//  DetailedViewController.m
//  LHL-RottenMangoes
//
//  Created by Asuka Nakagawa on 2016-05-25.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "DetailedViewController.h"
#import "MovieCollectionViewController.h"
#import "Review.h"
#import "Movie.h"

@interface DetailedViewController ()

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel2;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel3;



@property (nonatomic) NSMutableArray *reviews;

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // to display a review for a movie
    self.detailLabel.text = self.movie.movieId;
    
    // URL that can return JSON // 3 reviewItems for each movie
    // put movieID in the between /moviesArray and /reviews to access reviewPage
    NSString *urlForReviewsString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%@/reviews.json?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=3", self.movie.movieId];
    
    //
    NSURL *urlForReviews = [NSURL URLWithString:urlForReviewsString];
    
    NSURLSession *session1 = [NSURLSession sharedSession];
    NSURLSessionTask *reviewTask = [session1 dataTaskWithURL:[NSURL URLWithString:urlForReviewsString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSError *jsonError = nil;
            
            // reviewJson is a whole dict
            NSDictionary *reviewJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            // in the reviewJson we set a reviewArray
            NSArray *reviewArray = reviewJson[@"reviews"];
            
            // Create new EmptyArrayReviews holds reviewObjects
            NSMutableArray *reviews = [NSMutableArray array];
            
            // accessing reviewsArray in reviewJsonDictionary to get Value of "reviews"
            for (NSDictionary *reviewDict in reviewArray) {
                // create newEmpty Review object
                Review *reviewObject = [[Review alloc] init];
                
                // set stringCriticName to criticName in the reviewObject
                reviewObject.criticName = reviewDict[@"criticName"];
                reviewObject.quote = reviewDict[@"quote"];
                // put created reviewObject in the reviewsArray
                [reviews addObject:reviewObject];
                
                // display criticName & quote in the console
                NSLog(@"criticName:%@, quote: %@", reviewObject.criticName, reviewObject.quote);

            }
            // save the "data"
            self.reviews = reviews;
            
            // reloadData after Downloading "data" main_queque which is the blockOfCode for getting data
            dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
                [self updateLabels];
            });
        }
    }];
    // 3.All of the the different tasks from NSURLSession start in a suspended state. Start the task here.
    [reviewTask resume];
}

// update each label with reviews
- (void) updateLabels {
    
    Review *review1 = [self.reviews firstObject];
//    review1.quote
    self.detailLabel.text = review1.quote;
    
    Review *review2 = [self.reviews objectAtIndex:1];
    self.reviewLabel2.text = review2.quote;
    
    Review *review3 = [self.reviews objectAtIndex:2];
    self.reviewLabel3.text = review3.quote;

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
