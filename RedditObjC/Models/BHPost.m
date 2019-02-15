//
//  BHPost.m
//  RedditObjC
//
//  Created by Ben Huggins on 2/13/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "BHPost.h"

@implementation BHPost

-(instancetype)initWithTitle:(NSString *)title url:(NSString *)url subreddit:(NSString *)subreddit thumbnail:(nonnull NSString *)thumbnail
{
    
    self = [super init];
    if (self) {
        
        _title = [title copy];
        _url = url;
        _subreddit = subreddit;
        _thumbnail = [thumbnail copy];
  
    }
    return self;

}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    //get each post from the data key; represents what we are grabbing and what is being cycled through in the for loop
    //in the modelcontroller
    NSDictionary *dataDictionary = dictionary[@"data"];
    
    //after entering your innermost dictionary that contains your object model you can then
    //define your properties that come from the json
    
    NSString *title = dataDictionary[@"title"];
    NSString *url = dataDictionary[@"url"];
    NSString *subreddit = dataDictionary[@"subreddit"];
    NSString *thumbnail = dataDictionary[@"thumbnail"];
    
    return [self initWithTitle:title url:url subreddit: subreddit thumbnail:thumbnail];
    
}

@end
