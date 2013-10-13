//
//  CommonViewController.m
//  StoryContinued
//
//  Created by jerry on 13-10-13.
//
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

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
    if (!IS_IOS7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
