//
//  IndexViewController.m
//  StoryContinued
//
//  Created by jerry on 13-10-13.
//
//

#import "IndexViewController.h"

#define TAB_TAG_INDEX 10000
#define LABEL_TAG_INDEX 20000

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
    self.view.backgroundColor = RGBCOLOR(230, 230, 230);
    self.title = @"推荐";
    [self generateBarButton];
	// Do any additional setup after loading the view.
}

- (void)generateBarButton
{
    //add left button
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"navigationbar_compose_os7"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"navigationbar_compose_highlighted_os7"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(publishEssay) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(10, 5, 30, 30);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    [self.navigationController.navigationBar addSubview:leftBtn];
    //add right button
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"navigationbar_refresh_os7"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"navigationbar_refresh_highlighted_os7"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(publishEssay) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(self.view.frame.size.width-40, 5, 30, 30);
//    [self.navigationController.navigationBar addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

//发表段子
- (void)publishEssay
{
    
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
    recomBtn.frame = CGRectMake(17, 5, 30, 30);
    recomBtn.enabled = NO;
    [recomBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [recomBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_tuijian_os7"] forState:UIControlStateNormal];
    [recomBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_tuijian_selected_os7"] forState:UIControlStateDisabled];
    [self.customTabView addSubview:recomBtn];
    UILabel *recomLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 35, 30, 12)];
    recomLabel.tag = LABEL_TAG_INDEX;
    recomLabel.backgroundColor = [UIColor clearColor];
    recomLabel.textAlignment = NSTextAlignmentCenter;
    recomLabel.textColor = RGBCOLOR(240, 124, 44);
    recomLabel.font = [UIFont systemFontOfSize:12];
    recomLabel.text = @"推荐";
    [self.customTabView addSubview:recomLabel];
    
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.tag = TAB_TAG_INDEX+1;
    newBtn.frame = CGRectMake(81, 5, 30, 30);
    newBtn.enabled = YES;
    [newBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [newBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_last_os7"] forState:UIControlStateNormal];
    [newBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_last_selected_os7"] forState:UIControlStateDisabled];
    [self.customTabView addSubview:newBtn];
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(81, 35, 30, 12)];
    newLabel.tag = LABEL_TAG_INDEX+1;
    newLabel.backgroundColor = [UIColor clearColor];
    newLabel.textAlignment = NSTextAlignmentCenter;
    newLabel.textColor = RGBCOLOR(136, 136, 136);
    newLabel.font = [UIFont systemFontOfSize:12];
    newLabel.text = @"最新";
    [self.customTabView addSubview:newLabel];
    
    UIButton *myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.tag = TAB_TAG_INDEX+2;
    myBtn.frame = CGRectMake(145, 5, 30, 30);
    myBtn.enabled = YES;
    [myBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [myBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_profile_os7"] forState:UIControlStateNormal];
    [myBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_profile_selected_os7"] forState:UIControlStateDisabled];
    [self.customTabView addSubview:myBtn];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 35, 30, 12)];
    myLabel.tag = LABEL_TAG_INDEX+2;
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.textColor = RGBCOLOR(136, 136, 136);
    myLabel.font = [UIFont systemFontOfSize:12];
    myLabel.text = @"我的";
    [self.customTabView addSubview:myLabel];
    
    UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hotBtn.tag = TAB_TAG_INDEX+3;
    hotBtn.frame = CGRectMake(209, 5, 30, 30);
    hotBtn.enabled = YES;
    [hotBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [hotBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_discover_os7"] forState:UIControlStateNormal];
    [hotBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_discover_selected_os7"] forState:UIControlStateDisabled];
    [self.customTabView addSubview:hotBtn];
    UILabel *hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(209, 35, 30, 12)];
    hotLabel.tag = LABEL_TAG_INDEX+3;
    hotLabel.backgroundColor = [UIColor clearColor];
    hotLabel.textAlignment = NSTextAlignmentCenter;
    hotLabel.textColor = RGBCOLOR(136, 136, 136);
    hotLabel.font = [UIFont systemFontOfSize:12];
    hotLabel.text = @"八卦";
    [self.customTabView addSubview:hotLabel];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.tag = TAB_TAG_INDEX+4;
    moreBtn.frame = CGRectMake(273, 5, 30, 30);
    moreBtn.enabled = YES;
    [moreBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_more_os7"] forState:UIControlStateNormal];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_more_selected_os7"] forState:UIControlStateDisabled];
    [self.customTabView addSubview:moreBtn];
    UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(273, 35, 30, 12)];
    moreLabel.tag = LABEL_TAG_INDEX+4;
    moreLabel.backgroundColor = [UIColor clearColor];
    moreLabel.textAlignment = NSTextAlignmentCenter;
    moreLabel.textColor = RGBCOLOR(136, 136, 136);
    moreLabel.font = [UIFont systemFontOfSize:12];
    moreLabel.text = @"更多";
    [self.customTabView addSubview:moreLabel];
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
    for (int i=TAB_TAG_INDEX; i<=10004; i++) {
        UIButton *temp=(UIButton*)[self.customTabView viewWithTag:i];
        [temp setEnabled:temp.tag==but.tag?NO:YES];
    }
    
    for (int i=LABEL_TAG_INDEX; i<=20004; i++) {
        UILabel *temp=(UILabel*)[self.customTabView viewWithTag:i];
        temp.textColor = RGBCOLOR(136, 136, 136);
    }
    switch (but.tag) {
        case TAB_TAG_INDEX:
        {
            UILabel *label=(UILabel*)[self.customTabView viewWithTag:LABEL_TAG_INDEX];
            label.textColor = RGBCOLOR(240, 124, 44);
            self.title = @"推荐";
            break;
        }
            
        case TAB_TAG_INDEX+1:
        {
            UILabel *label=(UILabel*)[self.customTabView viewWithTag:LABEL_TAG_INDEX+1];
            label.textColor = RGBCOLOR(240, 124, 44);
            self.title = @"最新";
            break;
        }
        case TAB_TAG_INDEX+2:
        {
            UILabel *label=(UILabel*)[self.customTabView viewWithTag:LABEL_TAG_INDEX+2];
            label.textColor = RGBCOLOR(240, 124, 44);
            self.title = @"我的";
            break;
        }
        case TAB_TAG_INDEX+3:
        {
            UILabel *label=(UILabel*)[self.customTabView viewWithTag:LABEL_TAG_INDEX+3];
            label.textColor = RGBCOLOR(240, 124, 44);
            self.title = @"八卦";
            break;
        }
            
        case TAB_TAG_INDEX+4:
        {
            UILabel *label=(UILabel*)[self.customTabView viewWithTag:LABEL_TAG_INDEX+4];
            label.textColor = RGBCOLOR(240, 124, 44);
            self.title = @"更多";
            break;
        }
        default:
            break;
    }
}

@end
