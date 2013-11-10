//
//  UserInfo.m
//  StoryContinued
//
//  Created by jerry on 13-10-19.
//
//

#import "UserInfo.h"

@implementation UserInfo

- (id)init
{
    if (self = [super init])
    {
        _uid = @"0";
    }
    return self;
}

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"平台：%@，昵称：%@，会员ID：%@，会员头像：%@，微博网址：%@，会员性别：%@。",self.platformName,self.userName,self.uid,self.iconURL,self.profileURL,self.gender];
    return desc;
}

@end
