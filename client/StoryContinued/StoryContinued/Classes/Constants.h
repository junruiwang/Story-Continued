//
//  Constants.h
//  StoryContinued
//
//  Created by jerry on 13-10-13.
//
//

#ifndef StoryContinued_Constants_h
#define StoryContinued_Constants_h

#import "AppDelegate.h"
#define TheAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7
#define RGBCOLOR(R,G,B) [UIColor colorWithRed:(float)R/255.0 green:(float)G/255.0 blue:(float)B/255.0 alpha:1]

#endif
