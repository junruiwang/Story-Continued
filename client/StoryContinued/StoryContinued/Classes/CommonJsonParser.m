//
//  CommonJsonParser.m
//  StoryContinued
//
//  Created by jerry on 13-10-19.
//
//

#import "CommonJsonParser.h"
#import "NSDataAES.h"

@implementation CommonJsonParser

- (id)init
{
    if(self = [super init])
    {
        _requestData = [[NSMutableData alloc] init];
        _isHTTPGet = YES;
    }
    return self;
}

- (void)start
{
    [self cancel];
    [self.requestData resetBytesInRange:NSMakeRange(0, [self.requestData length])];
    [self.requestData setLength:0];
    
    NSString *uid = TheAppDelegate.userInfo.usid;
    NSString *httpBodyString = @"";
    if (self.requestString !=nil && ![self.requestString isEqualToString:@""])
    {
        httpBodyString = [NSString stringWithFormat:@"%@&clientVersion=%@&userId=%@", self.requestString, kClientVersion, uid];
    } else {
        httpBodyString = [NSString stringWithFormat:@"clientVersion=%@&userId=%@", kClientVersion, uid];
    }
    httpBodyString = [httpBodyString stringByAppendingFormat:@"&sign=%@", [[uid stringByAppendingFormat:kSecurityKey] MD5String]];
    
    if(self.isHTTPGet == YES)
    {
        NSString* url = [NSString stringWithFormat:@"%@?%@", self.serverAddress, httpBodyString];
        NSLog(@"%s get:%@", __FUNCTION__, url);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
        self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    } else {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSLog(@"%s full url:[%@?%@]", __FUNCTION__, self.serverAddress, httpBodyString);
        [request setTimeoutInterval:60]; // default is 60s
        [request setURL:[NSURL URLWithString:self.serverAddress]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    
    [self.connection start];
}

- (void)cancel
{
    [self.connection cancel];
    self.connection = nil;
}

- (BOOL)parserJSONString:(NSString *)responseData
{
    if(responseData == nil || [responseData length] == 0)
    {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:DidFailedParseWithMsg:errCode:)])
            [self.delegate parser:self DidFailedParseWithMsg:@"response data is nil or empty" errCode:-1];
        return NO;
    }
    NSDictionary *dictionary = [responseData JSONValue];
    if (dictionary == nil) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:DidFailedParseWithMsg:errCode:)])
            [self.delegate parser:self DidFailedParseWithMsg:@"response data is not NSDictionary" errCode:-1];
        return NO;
    }
    int code = [[dictionary valueForKey:@"resultCode"] intValue];
    NSString *resultMsg = [dictionary valueForKey:@"resultMsg"];
    if(code != 0){
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:DidFailedParseWithMsg:errCode:)])
            [self.delegate parser:self DidFailedParseWithMsg:resultMsg errCode:code];
        return NO;
    }
    
    return YES;
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:DidFailedParseWithMsg:errCode:)])
    {   [self.delegate parser:self DidFailedParseWithMsg:@"connection error" errCode:-1];   }
    [self cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
{
    [self.requestData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString* jsonString = [[NSString alloc] initWithData:self.requestData encoding:NSUTF8StringEncoding];
    [self parserJSONString:jsonString];
    [self cancel];
}

@end
