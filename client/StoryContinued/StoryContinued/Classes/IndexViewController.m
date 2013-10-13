//
//  IndexViewController.m
//  StoryContinued
//
//  Created by jerry on 13-10-13.
//
//

#import "IndexViewController.h"

#define TAB_TAG_INDEX 10000

@interface IndexViewController ()

- (void)tabbarItemClick:(id)sender;

@end

@implementation IndexViewController

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
    self.title = @"推荐";
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initCustomTabBar];
}

- (void)initCustomTabBar
{
    CGRect rect = self.tabBar.frame;
    self.customTabView = [[UIView alloc] initWithFrame:rect];
    if (IS_IOS7) {
        self.customTabView.backgroundColor = [UIColor clearColor];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsDefault];
        self.tabBar.hidden = YES;
        UIImage* img = [[UIImage imageNamed:@"tabbar_background.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        self.customTabView.backgroundColor = [UIColor colorWithPatternImage:img];
    }
    
    [self addViewsTabBar];
    [self.view addSubview:self.customTabView];
}

- (void)addViewsTabBar
{
    UIButton *recomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recomBtn.tag = TAB_TAG_INDEX;
    recomBtn.frame = CGRectMake(25, 10, 30, 30);
    recomBtn.enabled = NO;
    [recomBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [recomBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_home.png"] forState:UIControlStateNormal];
    [recomBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_home_highlighted.png"] forState:UIControlStateDisabled];
    [self.customTabView addSubview:recomBtn];
    
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.tag = TAB_TAG_INDEX+1;
    newBtn.frame = CGRectMake(105, 10, 30, 30);
    newBtn.enabled = YES;
    [newBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [newBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_message_center.png"] forState:UIControlStateNormal];
    [newBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_message_center_selected.png"] forState:UIControlStateDisabled];
    [self.customTabView addSubview:newBtn];
    
    UIButton *myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.tag = TAB_TAG_INDEX+2;
    myBtn.frame = CGRectMake(185, 10, 30, 30);
    myBtn.enabled = YES;
    [myBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [myBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_profile.png"] forState:UIControlStateNormal];
    [myBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_profile_selected.png"] forState:UIControlStateDisabled];
    [self.customTabView addSubview:myBtn];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.tag = TAB_TAG_INDEX+3;
    moreBtn.frame = CGRectMake(265, 10, 30, 30);
    moreBtn.enabled = YES;
    [moreBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_more.png"] forState:UIControlStateNormal];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_more_selected.png"] forState:UIControlStateDisabled];
    [self.customTabView addSubview:moreBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabbarItemClick:(id)sender
{
    UIButton *but=sender;
    [self setSelectedIndex:but.tag-TAB_TAG_INDEX];
    [sender setEnabled:NO];
    for (int i=TAB_TAG_INDEX; i<=10003; i++) {
        UIButton *temp=(UIButton*)[self.customTabView viewWithTag:i];
        [temp setEnabled:temp.tag==but.tag?NO:YES];
    }
    switch (but.tag) {
        case TAB_TAG_INDEX:
            self.title = @"推荐";
            break;
        case TAB_TAG_INDEX+1:
            self.title = @"最新";
            break;
        case TAB_TAG_INDEX+2:
            self.title = @"我的";
            break;
        case TAB_TAG_INDEX+3:
            self.title = @"更多";
            break;
        default:
            break;
    }
}

@end
