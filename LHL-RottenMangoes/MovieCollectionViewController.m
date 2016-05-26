//
//  MovieCollectionViewController.m
//  LHL-RottenMangoes
//
//  Created by Asuka Nakagawa on 2016-05-25.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "MovieCollectionViewController.h"
#import "CollectionViewCell.h"
#import "Movie.h"

@interface MovieCollectionViewController ()

// (public)can access from anywhere inside the class
@property (nonatomic) NSArray *movies;

@end

@implementation MovieCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. Specify a URL that can return JSON // 50 items
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=xe4xau69pxaah5tmuryvrw75&page_limit=50";
    
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
            
            // Create new EmptyArrayMovies holds movie
            NSMutableArray *movies = [NSMutableArray array];
            
            
            
            // accessing moviesArray in movieDictionary to get Value of "title/synopsis/url"
            for (NSDictionary *movieDict in moviesArray) {
                // inside of the moviesArray, there's postersDict
                NSDictionary *postersDict = movieDict[@"posters"];
                // create newEmpty Movie object
                Movie *movie = [[Movie alloc] init];
                
                // set stringTitle to title in the movieObject
                movie.title = movieDict[@"title"];
                movie.synopsis = movieDict[@"synopsis"];
                
                // set url to url in the movieObject
                movie.url = movieDict[@"url"];
                movie.thumbnail = [NSURL URLWithString:postersDict[@"thumbnail"]];
//                // convert stringYear to intValue
//                movie.year = [movieDict[@"year"] intValue];
                
                // Iterate through all the movies and create Movie object instances
                // put created movieObject in the moviesArray
                [movies addObject:movie];
//             [movies addObject:movieDict];

                // display movie's title & synopsis in console
                NSLog(@"Title: %@, synopsis: %@", movie.title, movie.synopsis);
    
            }
            // save the "data"
            self.movies = movies;
            
            // reloadData after Downloading "data" main_queque which is the blockOfCode for getting data
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            
            //            Movie *secondMovie = movies[1];
            //            NSString *str = secondMovie.title;
            //            int year = secondMovie.year;
            //
            //            NSDictionary *thirdMovie = movies[2];
            //            NSString *st = thirdMovie[@"tityle"];
            //            int year2 = [[thirdMovie objectForKey:@"year"] intValue];
            
        }
        // 4. Handle any response in the completionHandler.
//        NSLog(@"%@", data);
        // we need to casting the object from JSON NSStirng into an NSDictionary
    }];
    
    // 3.All of the the different tasks from NSURLSession start in a suspended state. Start the task here.
    [dataTask resume];
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // set each cell has data
    Movie *dataEachCell = [self.movies objectAtIndex:indexPath.item];
    
    // match the title/year to title/year from Movies
    cell.titleLabel.text = dataEachCell.title;
    cell.synopsisLabel.text = dataEachCell.synopsis;
    
    // converting NSURL to thumbnailImage(UIImage)
    NSData *data = [[NSData alloc] initWithContentsOfURL:dataEachCell.thumbnail];
    cell.thumbnailImage.image = [UIImage imageWithData:data];
  //  cell.thumbnailImage.image = dataEachCell.thumbnail;
    
    return cell;
}


//#pragma mark - Navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    // cell is sender
//    //    SongItemCell *cell = (SongItemCell*) sender;
//    NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
//    //    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
//    
//    // set specific cell has specific data
//    Movie *dataEachCell = [self.movies objectAtIndex:indexPath.item];
//    self.movies.title = dataEachCell.title;
//    self.movies = dataEachCell.year;
//}




#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
