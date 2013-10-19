//
//  Constants.h
//  StoryContinued
//
//  Created by jerry on 13-10-13.
//
//

#ifndef StoryContinued_Constants_h
#define StoryContinued_Constants_h

// URL
#define kTestURL                          @"http://1.longstory.duapp.com/StoryContinued"
#define kProductionURL                    @""

#ifdef DEBUG
#define kBaseURL                          kTestURL
#else
#define kBaseURL                          kProductionURL
#endif

#define kClientVersionURL                 [kBaseURL stringByAppendingPathComponent:@"getClientVersion"]
#define kStoryListSearchURL               [kBaseURL stringByAppendingPathComponent:@"/story/list"]
#define kHotelPricePlanURL                [kBaseURL stringByAppendingPathComponent:@"hotels/room/newlist"]
#define kHotelOverviewURL                 [kBaseURL stringByAppendingPathComponent:@"hotels/hotel"]
#define kHotelRatingURL                   [kBaseURL stringByAppendingPathComponent:@"/lvping/rating"]
#define kHotelPriceConfirmURL             [kBaseURL stringByAppendingPathComponent:@"hotels/room/getPriceTimeDpa"]
#define kHotelOrderPlaceURL               [kBaseURL stringByAppendingPathComponent:@"hotels/order"]
#define kHotelOrderDetailURL              [kBaseURL stringByAppendingPathComponent:@"hotels/order/view"]
#define kUserOrderListURL                 [kBaseURL stringByAppendingPathComponent:@"hotels/order/list"]
#define kUserActiveOrderListURL           [kBaseURL stringByAppendingPathComponent:@"hotels/order/activeList"]
#define kHotelOrderCancelURL              [kBaseURL stringByAppendingPathComponent:@"hotels/order/cancel"]
#define kUserRegisterURL                  [kBaseURL stringByAppendingPathComponent:@"member"]


#define kStoryTypeHot  @"hot"
#define kStoryTypeLast @"last"
#define kPageSize 10
#define kClientVersion  @"1.0.0"
// for signature
#define kSecurityKey @"7e6bfbe8101e8925ad985407ebdb5afb"

#import "AppDelegate.h"
#define TheAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7
#define RGBCOLOR(R,G,B) [UIColor colorWithRed:(float)R/255.0 green:(float)G/255.0 blue:(float)B/255.0 alpha:1]

#endif