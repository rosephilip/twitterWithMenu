//
//  TweetDetailsViewController.m
//  Twitter
//
//  Created by Rose Marie Philip on 2/23/15.
//  Copyright (c) 2015 Rose Marie Philip. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"

@interface TweetDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;
@property (weak, nonatomic) IBOutlet UIImageView *replyImage;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UIButton *tweetReplyButton;
@property (weak, nonatomic) IBOutlet UITextView *replyText;
- (IBAction)onReply:(id)sender;
- (IBAction)onRetweet:(id)sender;
- (IBAction)onFavorite:(id)sender;
- (IBAction)tweetReply:(id)sender;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userName.text = self.tweet.user.name;
    self.screenName.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenname];
    self.userImageView.layer.cornerRadius = 3;
    self.userImageView.clipsToBounds = YES;
    [self.userImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.tweetLabel.text = self.tweet.text;
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
    self.replyText.hidden = YES;
    self.tweetReplyButton.hidden = YES;
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

- (IBAction)onReply:(id)sender {
    self.replyText.hidden = NO;
    [self.replyText becomeFirstResponder];
    self.tweetReplyButton.hidden = NO;
    self.replyText.text = [NSString stringWithFormat:@"%@ ", self.screenName.text];
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

- (IBAction)tweetReply:(id)sender {
    NSDictionary *params = @{@"status" : self.replyText.text, @"id" : self.tweet.tweetId};
    [[TwitterClient sharedInstance] statusUpdateWithParams:params];
    TweetsViewController *vc = [[TweetsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}


@end
