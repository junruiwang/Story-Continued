//
//  RecommendViewController.m
//  StoryContinued
//
//  Created by jerry on 13-10-13.
//
//

#import "RecommendViewController.h"

@interface RecommendViewController ()

@end

@implementation RecommendViewController

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
    self.mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSLog(@"%@",NSStringFromCGRect(self.mainWebView.frame));
    
    self.mainWebView.scrollView.bounces = NO;
    self.mainWebView.scalesPageToFit = YES;
    self.mainWebView.delegate = nil;
    [self.view addSubview:self.mainWebView];
    
    NSURL *serverUrl = [NSURL URLWithString:[@"http://www.163.com" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:serverUrl cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:20];
    [self.mainWebView loadRequest:request];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self generateBarButton];
}

- (void)generateBarButton
{
    //add left button
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"navigationbar_compose_os7"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"navigationbar_compose_highlighted_os7"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(publishEssay) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(10, 5, 30, 30);
    self.parentViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    //add right button
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"navigationbar_refresh_os7"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"navigationbar_refresh_highlighted_os7"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(self.view.frame.size.width-40, 5, 30, 30);
    //    [self.navigationController.navigationBar addSubview:rightBtn];
    self.parentViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

//发表段子
- (void)publishEssay
{
    
}

//刷新视图
- (void)refreshTableView
{
    NSLog(@"News pages already refreshed!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
