//
//  MemberCenterViewController.m
//  StoryContinued
//
//  Created by jerry on 13-11-9.
//
//

#import "MemberCenterViewController.h"
#import "UMSocialBar.h"

@interface MemberCenterViewController ()<UMSocialUIDelegate>

@property(nonatomic,strong) UMSocialButton *socialButton;
@property(nonatomic,strong) UIButton *logoutButton;

@end

@implementation MemberCenterViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.logoutButton.frame = CGRectMake(self.view.center.x - 40, self.view.center.y, 80, 30);
    [self.logoutButton setTitle:@"注销登录" forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutButton];
	// Do any additional setup after loading the view.
}

- (void)generateBarButton
{
    //add left button
    self.parentViewController.navigationItem.leftBarButtonItem = nil;
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    //add right button
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:@"StoryContinued"];
    self.socialButton = [[UMSocialButton alloc] initWithButtonName:UMSocialAccount socialData:socialData controller:self];
    self.socialButton.center = self.view.center;
    self.socialButton.socialUIDelegate = self;
    //    [self.navigationController.navigationBar addSubview:rightBtn];
    self.parentViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.socialButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self generateBarButton];
    if ([UMSocialAccountManager isLoginWithSnsAccount]) {
        self.logoutButton.hidden = NO;
    } else {
        self.logoutButton.hidden = YES;
    }
}

- (void)logout
{
    if ([UMSocialAccountManager isLoginWithSnsAccount]) {
        [[UMSocialDataService defaultDataService] requestUnBindToSnsWithCompletion:^(UMSocialResponseEntity * response){
            //do logout
        }];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UMSocialUIDelegate

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //授权成功
    if (response.responseCode == UMSResponseCodeSuccess) {
        //登录成功，设置登录用户信息
        if (response.responseType == UMSResponseGetAccount && response.viewControllerType == UMSViewControllerLogin) {
            NSDictionary *data = response.data;
            TheAppDelegate.userInfo.platformName = [data valueForKey:@"default"];
            TheAppDelegate.userInfo.userName = [data valueForKey:@"username"];
            TheAppDelegate.userInfo.uid = [data valueForKey:@"uid"];
            TheAppDelegate.userInfo.iconURL = [data valueForKey:@"icon"];
            NSDictionary *loginaccount = [data valueForKey:@"loginaccount"];
            NSDictionary *account = [loginaccount valueForKey:TheAppDelegate.userInfo.platformName];
            TheAppDelegate.userInfo.gender = [account valueForKey:@"gender"];
            TheAppDelegate.userInfo.profileURL = [account valueForKey:@"profile_url"];
            NSLog(@"%@",[TheAppDelegate.userInfo description]);
        }
        
    }
}

@end
