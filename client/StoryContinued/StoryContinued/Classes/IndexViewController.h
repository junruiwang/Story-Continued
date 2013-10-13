//
//  IndexViewController.h
//  StoryContinued
//
//  Created by jerry on 13-10-13.
//
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface IndexViewController : UITabBarController

@property (nonatomic, strong) UIView *customTabView;

- (void)tabbarItemClick:(id)sender;

@end
