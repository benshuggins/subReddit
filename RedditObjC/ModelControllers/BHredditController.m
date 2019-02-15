//
//  BHredditController.m
//  RedditObjC
//
//  Created by Ben Huggins on 2/13/19.
//  Copyright © 2019 User. All rights reserved.
//

//sharedController and URLSession containing searchForPostWithSearchTerm

#import "BHredditController.h"
#import "BHPost.h"
#import <UIKit/UIKit.h>

@implementation BHredditController

static NSString * const baseURLString = @"https://www.reddit.com/r/";

+ (instancetype)sharedController
{
    static BHredditController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[BHredditController alloc] init];
    });
    return sharedController;
}

- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<BHPost *> *, NSError *))completion
{
    
    NSURL *baseURL = [NSURL URLWithString: baseURLString];   // NSURL *searchURL = [self baseURL];
    
    
    NSURL *searchURL = [baseURL URLByAppendingPathComponent: searchTerm];
    
    
    searchURL = [searchURL URLByAppendingPathExtension: @"json"];
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"no data returned from the task");
            completion(nil, error);
            return;
        }
        
        //this starts us at the TLD
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if(!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]){
            NSLog(@"JSONDictionary is not dictionary class");
            completion(nil, error);
            return;
            
        }
        
        //this starts us at our data dictionary "data" and gives *postDataDictinaries
        // all that opens up with tapping the plus button
        NSDictionary *postDataDictionaries = jsonDictionary[@"data"];
        NSArray *childrenArray = postDataDictionaries[@"children"];
        //NSDictionary *dataArray = childrenArray[@"data"]; this isnt needed because we are already inside of children and
        //remember we have our data dictionary already defined so you should try without creating that!!!!!!!!!!!!!!!!!!!!
        //no we need to loop through our
        
        
        //We need a placeholder array so we can complete with the type that we defined for our return object BHPosts.
        
        
        NSMutableArray *postsArray = [NSMutableArray array];
        
        
        for (NSDictionary *dataDictionary in childrenArray) {
            
            BHPost *post = [[BHPost alloc] initWithDictionary:dataDictionary];
            [postsArray addObject:post];
            
        }
        completion(postsArray, nil);
        
        
    }]resume];
    
    //FetchingImage
    
}

-(void)fethImagePost:(BHPost *)post completion:(void(^)(UIImage *))completion

{
    // string version of our image
    NSString *thumbnailString = [[NSString alloc] initWithFormat:@"%@", post.thumbnail];
    
    //turn into a URL
    NSURL *thumbnailUrl = [[NSURL alloc] initWithString:thumbnailString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:thumbnailUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"error handling image %@", error);
            completion(nil); return;
        }
        
        if (!data) {
            NSLog(@"Error no data from image task %@", error);
            completion(nil); return;
        }
        //handle image
        
        UIImage *thumbnail = [[UIImage alloc] initWithData:data];
        completion(thumbnail);
        
    }]resume];
    
}

@end
