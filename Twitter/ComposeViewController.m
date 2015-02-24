//
//  ComposeViewController.m
//  Twitter
//
//  Created by Rose Marie Philip on 2/23/15.
//  Copyright (c) 2015 Rose Marie Philip. All rights reserved.
//

#import "ComposeViewController.h"
#import "TweetsViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userScreenName;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;

- (void)tweetsView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    
    User *currentUser = [User currentUser];
    self.userName.text = currentUser.name;
    self.userScreenName.text = [NSString stringWithFormat:@"@%@", currentUser.screenname];
    self.userImageView.layer.cornerRadius = 3;
    self.userImageView.clipsToBounds = YES;
    [self.userImageView setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    [self.tweetText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancel {
    [self tweetsView];
}

- (void)onTweet {
    NSDictionary *params = @{@"status" : self.tweetText.text};
    [[TwitterClient sharedInstance] statusUpdateWithParams:params];
    [self tweetsView];
}

- (void)tweetsView {
    TweetsViewController *vc = [[TweetsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
