//
//  AppDelegate.h
//  StoryContinued
//
//  Created by jerry on 13-9-6.
//
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UserInfo.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "UMSocialControllerService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UserInfo *userInfo;

@end
