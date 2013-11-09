//
//  LatelyViewController.h
//  StoryContinued
//
//  Created by jerry on 13-10-15.
//
//

#import "CommonViewController.h"

@interface LatelyViewController : CommonViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView *listTableView;

@end
