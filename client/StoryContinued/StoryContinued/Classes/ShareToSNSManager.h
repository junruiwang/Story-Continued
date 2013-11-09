//
//  ShareToSNSManager.h
//  StoryContinued
//
//  Created by jerry on 13-9-6.
//
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "Constants.h"
#import "UMSocial.h"
#import "UMSocialControllerService.h"

@interface ShareToSNSManager : NSObject <UMSocialUIDelegate>

+ (void)shareWithList:(UIViewController *)controller shareImage:(UIImage *)shareImage shareText:(NSString *)shareText;
+ (void)showAlertMessage:(NSString *)msg;

@end
