//
//  ShareToSNSManager.m
//  StoryContinued
//
//  Created by jerry on 13-9-6.
//
//

#import "ShareToSNSManager.h"

@implementation ShareToSNSManager

+ (void)showAlertMessage:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"信息提示", nil)
                              message:msg
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                              otherButtonTitles:nil];
    [alertView show];
}

//默认面板方式展示分享平台
+ (void)shareWithList:(UIViewController *)controller shareImage:(UIImage *)shareImage shareText:(NSString *)shareText
{
    //设置微信图文分享
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialData defaultData].extConfig.title = @"艾玛，好经典的段子";
    //如果得到分享完成回调，需要传递delegate参数
    [UMSocialSnsService presentSnsIconSheetView:controller appKey:kUMengShareKey shareText:shareText shareImage:shareImage shareToSnsNames:[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray delegate:nil];
}


#pragma mark - UMSocialUIDelegate method

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

@end
