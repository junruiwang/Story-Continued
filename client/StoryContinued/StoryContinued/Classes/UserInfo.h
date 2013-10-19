//
//  UserInfo.h
//  StoryContinued
//
//  Created by jerry on 13-10-19.
//
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

/**
 微博平台名称,例如"sina"、"tencent",定义在`UMSocialEnum.h`
 */
@property (nonatomic, copy) NSString *platformName;

/**
 用户昵称
 */
@property (nonatomic, copy) NSString *userName;

/**
 用户在微博的id号
 */
@property (nonatomic, copy) NSString *usid;

/**
 用户微博头像的url
 */
@property (nonatomic, copy) NSString *iconURL;

/**
 用户授权后得到的accessToken
 */
@property (nonatomic, copy) NSString *accessToken;

/**
 用户微博网址url
 */
@property (nonatomic, copy) NSString *profileURL;

/**
 是否首次授权，sdk内使用
 */
@property (nonatomic) BOOL isFirstOauth;

@end
