//
//  ViewController.m
//  LHL-RottenMangoes
//
//  Created by Asuka Nakagawa on 2016-05-24.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1. Specify a URL that can return JSON
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=xe4xau69pxaah5tmuryvrw75";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    // this blockOfCode keeps data, but nothing to do
    //2. Create an NSURLSessionDataTask using the NSURLSession sharedSession. The data task is the object that does the work for you.
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        // if we don't get any error
        if (!error) {
            NSError *jsonError = nil;
            
            // json is a whole dictionary
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            // inside the jsonDictionary there's moviesArray
            NSArray *moviesArray = json[@"movies"];
            
            NSMutableArray *movies = [NSMutableArray array];
            
            // accessing moviesArray in movieDictionary to get Value of "title"
            for (NSDictionary *movieDict in moviesArray) {
                
                // create newEmpty Movie object
                Movie *movie = [[Movie alloc] init];
                
                // set stringTitle to title in the movieObject
                movie.title = movieDict[@"title"];
                
                // convert stringYear to intValue
                movie.year = [movieDict[@"year"] intValue];
                
                // put created movieObject instance in the movies
                [movies addObject:movie];
                
//             [movies addObject:movieDict];
            }
            
//            Movie *secondMovie = movies[1];
//            NSString *str = secondMovie.title;
//            int year = secondMovie.year;
//            
//            
//            NSDictionary *thirdMovie = movies[2];
//            NSString *st = thirdMovie[@"tityle"];
//            int year2 = [[thirdMovie objectForKey:@"year"] intValue];
 

        }

            
        // 4. Handle any response in the completionHandler.
        NSLog(@"%@", data);
        // we need to casting the object from JSON NSStirng into an NSDictionary
        
    
    }];
    
    
    // 3.All of the the different tasks from NSURLSession start in a suspended state. Start the task here.
    [dataTask resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
