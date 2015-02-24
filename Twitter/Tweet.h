//
//  Tweet.h
//  Twitter
//
//  Created by Rose Marie Philip on 2/21/15.
//  Copyright (c) 2015 Rose Marie Philip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL retweeted;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) id tweetId;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
