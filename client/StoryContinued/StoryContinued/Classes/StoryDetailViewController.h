//
//  StoryDetailViewController.h
//  StoryContinued
//
//  Created by jerry on 13-10-20.
//
//

#import "CommonViewController.h"
#import "JBStory.h"

@interface StoryDetailViewController : CommonViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView *listTableView;
@property(nonatomic,strong) UIButton *jielongButton;
@property(nonatomic,strong) JBStory *story;

@end
