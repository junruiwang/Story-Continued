//
//  JBContent.h
//  StoryContinued
//
//  Created by jerry on 13-10-26.
//
//

#import <Foundation/Foundation.h>

@interface JBContent : NSObject

@property(nonatomic,copy) NSString *parentId;
@property(nonatomic,copy) NSString *contentId;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *contentText;
@property(nonatomic,assign) NSInteger level;
@property(nonatomic,assign) NSInteger like;
@property(nonatomic,assign) NSInteger dislike;
@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *iconUrl;
@property(nonatomic) float textHeight;

- (id) initWithDictionary : (NSDictionary *) dict;

@end
