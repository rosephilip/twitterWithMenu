//
//  TwitterClient.h
//  Twitter
//
//  Created by Rose Marie Philip on 2/21/15.
//  Copyright (c) 2015 Rose Marie Philip. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

extern NSString * const TweetUpdated;

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)statusUpdateWithParams:(NSDictionary *)params;
- (void)favoriteStatusWithParams:(NSDictionary *)params;
- (void)retweetStatusWithParams:(id)tweetId;

@end
