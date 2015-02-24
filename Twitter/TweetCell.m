//
//  TweetCell.m
//  Twitter
//
//  Created by Rose Marie Philip on 2/22/15.
//  Copyright (c) 2015 Rose Marie Philip. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "TweetDetailsViewController.h"

@interface TweetCell ()

@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImage;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;
- (IBAction)onRetweet:(id)sender;
- (IBAction)onFavorite:(id)sender;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    self.profileImageView.layer.cornerRadius = 3;
    self.profileImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.tweetLabel.text = tweet.text;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenname];
    self.authorLabel.text = tweet.user.name;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    
    int seconds = -(int)[tweet.createdAt timeIntervalSinceNow];
    if (seconds < 60) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d sec", seconds];
    } else if (seconds < 3600) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d min", seconds/60];
    } else if (seconds < 3600 * 24) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d hrs", seconds/3600];
    } else {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"dd-MM-yyyy";
        self.timeLabel.text  = [NSString stringWithFormat:@"%@", [format stringFromDate:tweet.createdAt]];
    }
    
    if (self.tweet.favorited == NO) {
        self.favoriteImage.image = [UIImage imageNamed:@"favorite_off.png"];
    } else {
        self.favoriteImage.image = [UIImage imageNamed:@"favorite_on.png"];
    }
    if (self.tweet.retweeted == NO) {
        self.retweetImage.image = [UIImage imageNamed:@"retweet.png"];
    } else {
        self.retweetImage.image = [UIImage imageNamed:@"retweet_on.png"];
    }
    self.replyImage.image = [UIImage imageNamed:@"reply.png"];
}

- (IBAction)onRetweet:(id)sender {
    if(self.tweet.retweeted == NO) {
        [[TwitterClient sharedInstance] retweetStatusWithParams:self.tweet.tweetId];
        self.retweetImage.image = [UIImage imageNamed:@"retweet_on.png"];
    }
}

- (IBAction)onFavorite:(id)sender {
    if (self.tweet.favorited == NO) {
        NSDictionary *params = @{@"id" : self.tweet.tweetId};
        [[TwitterClient sharedInstance] favoriteStatusWithParams:params];
        self.favoriteImage.image = [UIImage imageNamed:@"favorite_on.png"];
    }
}
@end
