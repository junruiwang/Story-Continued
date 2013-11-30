//
//  ContentCell.h
//  StoryContinued
//
//  Created by jerry on 13-10-22.
//
//

#import <UIKit/UIKit.h>
#import "JBContent.h"

@interface ContentCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UIImageView *memberIconView;
@property(nonatomic,weak) IBOutlet UILabel *userName;
@property(nonatomic,weak) IBOutlet UILabel *writeTime;
@property(nonatomic,weak) IBOutlet UILabel *levelTag;
@property(nonatomic,weak) IBOutlet UILabel *contentLabel;
@property(nonatomic,strong) JBContent *content;
@property(nonatomic,strong) IBOutlet UIImageView *dashedImageView;

@end
