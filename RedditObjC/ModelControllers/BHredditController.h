//
//  BHredditController.h
//  RedditObjC
//
//  Created by Ben Huggins on 2/13/19.
//  Copyright © 2019 User. All rights reserved.
//


// here we create our shared instance and our searchFunc that contains our searchTerm
//and the array of post that we are going to recieve back and an error or not if we choose to

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class BHPost;

NS_ASSUME_NONNULL_BEGIN

@interface BHredditController : NSObject

//shared Controller declaration
+ (instancetype)sharedController;

// SearchFunc declaration with searchterm, and array to recieve back and error

- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^ _Nullable) (NSArray<BHPost *> *posts, NSError *error))completion;

-(void)fethImagePost:(BHPost *)post completion:(void(^)(UIImage *))completion;


@end

NS_ASSUME_NONNULL_END
