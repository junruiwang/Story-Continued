//
//  StoryDetailViewController.m
//  StoryContinued
//
//  Created by jerry on 13-10-20.
//
//

#import "StoryDetailViewController.h"
#import "ContentCell.h"

@interface StoryDetailViewController ()

@end

@implementation StoryDetailViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadData
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell *cell = (ContentCell *)[tableView dequeueReusableCellWithIdentifier:@"ContentCellID"];
    
    if (cell == nil)
    {
        cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentCellID"];
        
    }
    int row = [indexPath row];
    cell.levelTag.text = [NSString stringWithFormat:@"#%d",row+1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 219;
}

@end
