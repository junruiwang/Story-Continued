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
    
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:@"StoryContinued"];
    self.socialButton = [[UMSocialButton alloc] initWithButtonName:UMSocialAccount socialData:socialData controller:self];
    self.socialButton.center = self.view.center;
    self.socialButton.socialUIDelegate = self;
    [self.view addSubview:self.socialButton];
    
    
	// Do any additional setup after loading the view.
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
        //个人中心页面
        if (response.viewControllerType == UMSViewControllerAccount) {
            NSLog(@"%@",response.description);
        }
        
    }
}

@end
