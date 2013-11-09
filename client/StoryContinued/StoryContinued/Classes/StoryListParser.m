//
//  StoryListParser.m
//  StoryContinued
//
//  Created by jerry on 13-10-19.
//
//

#import "StoryListParser.h"
#import "JBStory.h"

@implementation StoryListParser

- (BOOL)parserJSONString:(NSString *)responseData
{
    if ([super parserJSONString:responseData]) {
        NSDictionary *dictionary = [responseData JSONValue];
        
        NSArray *array = [dictionary valueForKey:@"data"];
        NSMutableArray *storyList = [[NSMutableArray alloc] initWithCapacity:10];
        
        for (NSDictionary *dict in array)
        {
            JBStory *story = [[JBStory alloc] initWithDictionary:dict];
            [storyList addObject:story];
        }
        NSDictionary *data = @{@"data":storyList};
        
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:DidParsedData:)]){
            [self.delegate parser:self DidParsedData:data];
        }
    }
    return YES;
}

@end
