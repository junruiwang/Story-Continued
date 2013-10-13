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
    self.mainWebView.scrollView.bounces = NO;
    self.mainWebView.scalesPageToFit = YES;
    self.mainWebView.delegate = nil;
    [self.view addSubview:self.mainWebView];
    
    NSURL *serverUrl = [NSURL URLWithString:[@"http://www.163.com" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:serverUrl cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:20];
    [self.mainWebView loadRequest:request];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
