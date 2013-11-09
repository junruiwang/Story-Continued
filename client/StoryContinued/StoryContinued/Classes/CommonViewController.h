//
//  CommonViewController.h
//  StoryContinued
//
//  Created by jerry on 13-10-13.
//
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "CommonJsonParser.h"

@interface CommonViewController : UIViewController <CommonJsonParserDelegate>

- (void)downloadData;

@end
