//
//  CommonJsonParser.h
//  StoryContinued
//
//  Created by jerry on 13-10-19.
//
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "SBJson.h"

@class CommonJsonParser;

#pragma mark - CommonJsonParserDelegate

@protocol CommonJsonParserDelegate <NSObject>

@optional

- (void)parser:(CommonJsonParser*)parser DidFailedParseWithMsg:(NSString*)msg errCode:(NSInteger)code;
- (void)parser:(CommonJsonParser*)parser DidParsedData:(NSDictionary *)data;

@end

@interface CommonJsonParser : NSObject

@property(nonatomic,strong) NSURLConnection *connection;
@property(nonatomic,strong) NSMutableData *requestData;

@property (nonatomic) BOOL isHTTPGet;
@property (nonatomic, weak) id<CommonJsonParserDelegate> delegate;
@property (nonatomic, copy) NSString *serverAddress;
@property (nonatomic, copy) NSString *requestString;

- (void)start;
- (void)cancel;
- (BOOL)parserJSONString:(NSString *)responseData;

@end
