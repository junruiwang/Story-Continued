//
//  CommonViewController.m
//  StoryContinued
//
//  Created by jerry on 13-10-13.
//
//

#import "CommonViewController.h"

@interface CommonViewController ()

- (void)backButtonClicked:(id)sender;

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
    self.view.backgroundColor = RGBCOLOR(230, 230, 230);
    if (!IS_IOS7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    [self generateBarButton];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateBarButton
{
    //add left button
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"navigationbar_back_os7"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted_os7"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(10, 5, 30, 30);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downloadData
{
    
}

@end
