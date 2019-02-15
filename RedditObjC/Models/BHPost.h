//
//  BHPost.h
//  RedditObjC
//
//  Created by Ben Huggins on 2/13/19.
//  Copyright © 2019 User. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BHPost : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *url;
@property (nonatomic, copy, readonly) NSString *subreddit;
@property (nonatomic, copy, readonly) NSString *thumbnail;

-(instancetype)initWithTitle:(NSString *)title url:(NSString *)url subreddit:(NSString *)subreddit thumbnail:(NSString *)thumbnail;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
