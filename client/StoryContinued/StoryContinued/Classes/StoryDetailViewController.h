//
//  StoryDetailViewController.h
//  StoryContinued
//
//  Created by jerry on 13-10-20.
//
//

#import "CommonViewController.h"

@interface StoryDetailViewController : CommonViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView *listTableView;

@end
