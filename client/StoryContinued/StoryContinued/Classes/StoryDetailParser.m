//
//  StoryDetailParser.m
//  StoryContinued
//
//  Created by jerry on 13-10-26.
//
//

#import "StoryDetailParser.h"
#import "JBContent.h"

@implementation StoryDetailParser

- (BOOL)parserJSONString:(NSString *)responseData
{
    if ([super parserJSONString:responseData]) {
        NSDictionary *dictionary = [responseData JSONValue];
        NSArray *array = [dictionary valueForKey:@"data"];
        NSMutableArray *contentList = [[NSMutableArray alloc] initWithCapacity:10];
        
        for (NSDictionary *dict in array)
        {
            JBContent *content = [[JBContent alloc] initWithDictionary:dict];
            [contentList addObject:content];
        }
        NSDictionary *data = @{@"data":contentList};
        
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:DidParsedData:)]){
            [self.delegate parser:self DidParsedData:data];
        }
    }
    return YES;
}

@end
