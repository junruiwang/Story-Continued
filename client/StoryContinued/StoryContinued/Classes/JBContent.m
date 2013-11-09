//
//  JBContent.m
//  StoryContinued
//
//  Created by jerry on 13-10-26.
//
//

#import "JBContent.h"
#import "ValidateInputUtil.h"

@implementation JBContent

- (id) initWithDictionary : (NSDictionary *) dict
{
    if (dict == nil) {
        self = [super init];
        return self;
    }
    
    if (self = [super init]) {
        self.contentId = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"id"]];
        self.createTime = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"createTime"]];
        self.contentText = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"contentText"]];
        self.level = [[dict objectForKey:@"level"] intValue];
        self.like = [[dict objectForKey:@"like"] intValue];
        self.dislike = [[dict objectForKey:@"dislike"] intValue];
        self.userName = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"userName"]];
        self.iconUrl = [ValidateInputUtil valueOfObjectToString:[dict objectForKey:@"iconUrl"]];
        [self computerHeadContext];
    }
    return self;
}

- (void)computerHeadContext
{
    NSString *vText = self.contentText;
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
