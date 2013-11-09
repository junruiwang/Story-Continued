//
//  JBStory.m
//  StoryContinued
//
//  Created by jerry on 13-10-19.
//
//

#import "JBStory.h"
#import "ValidateInputUtil.h"

@implementation JBStory

+ (JBStory *)unarchived:(NSData *) data
{
    JBStory *story = (JBStory *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return story;
}

- (id) initWithDictionary : (NSDictionary *) dict
{
    if (dict == nil) {
        self = [super init];
        return self;
    }
    
    if (self = [super init]) {
        self.storyId = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"id"]];
        self.createTime = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"createTime"]];
        self.totalPartake = [[dict objectForKey:@"totalPartake"] intValue];
        self.storyHeadContext = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"storyHeadContext"]];
        self.totalLike = [[dict objectForKey:@"totalLike"] intValue];
        self.totalDislike = [[dict objectForKey:@"totalDislike"] intValue];
        self.userName = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"userName"]];
        self.iconUrl = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"iconUrl"]];
        [self computerHeadContext];
    }
    return self;
}

- (NSData *)archived
{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.storyId = [aDecoder decodeObjectForKey:@"storyId"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.totalPartake = [aDecoder decodeIntegerForKey:@"totalPartake"];
        self.storyHeadContext = [aDecoder decodeObjectForKey:@"storyHeadContext"];
        self.totalLike = [aDecoder decodeIntegerForKey:@"totalLike"];
        self.totalDislike = [aDecoder decodeIntegerForKey:@"totalDislike"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.iconUrl = [aDecoder decodeObjectForKey:@"iconUrl"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.storyId forKey:@"storyId"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeInteger:self.totalPartake forKey:@"totalPartake"];
    [aCoder encodeObject:self.storyHeadContext forKey:@"storyHeadContext"];
    [aCoder encodeInteger:self.totalLike forKey:@"totalLike"];
    [aCoder encodeInteger:self.totalDislike forKey:@"totalDislike"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.iconUrl forKey:@"iconUrl"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    JBStory *story = [[self class] allocWithZone:zone];
    self.storyId = [self.storyId copyWithZone:zone];
    self.createTime = [self.createTime copyWithZone:zone];
    self.totalPartake = self.totalPartake;
    self.storyHeadContext = [self.storyHeadContext copyWithZone:zone];
    self.totalLike = self.totalLike;
    self.totalDislike = self.totalDislike;
    self.userName = [self.userName copyWithZone:zone];
    self.iconUrl = [self.iconUrl copyWithZone:zone];
    return story;
}

- (void)computerHeadContext
{
    NSString *vText = self.storyHeadContext;
    vText = [vText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    float vHeight = 20;
    if (vText || ![vText isEqualToString:@""])
    {
        CGSize stringSize = [vText sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(291, 800) lineBreakMode:(NSLineBreakByWordWrapping)];
        if (stringSize.height > vHeight)
        {
            vHeight = stringSize.height;
        }
    }
    self.textHeight = vHeight;
}

@end
