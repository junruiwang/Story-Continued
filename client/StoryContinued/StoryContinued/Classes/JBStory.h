//
//  JBStory.h
//  StoryContinued
//
//  Created by jerry on 13-10-19.
//
//

#import <Foundation/Foundation.h>

@interface JBStory : NSObject <NSCoding, NSCopying>

@property(nonatomic,copy) NSString *storyId;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,assign) NSInteger totalPartake;
@property(nonatomic,copy) NSString *storyHeadContext;
@property(nonatomic,assign) NSInteger totalLike;
@property(nonatomic,assign) NSInteger totalDislike;
@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *iconUrl;
@property(nonatomic) float textHeight;

+ (JBStory *)unarchived:(NSData *) data;

- (id) initWithDictionary : (NSDictionary *) dict;
- (NSData *)archived;

@end
