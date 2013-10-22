//
//  ContentCell.h
//  StoryContinued
//
//  Created by jerry on 13-10-22.
//
//

#import <UIKit/UIKit.h>

@interface ContentCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UIImageView *memberIconView;
@property(nonatomic,weak) IBOutlet UILabel *userName;
@property(nonatomic,weak) IBOutlet UILabel *writeTime;
@property(nonatomic,weak) IBOutlet UILabel *levelTag;
@property(nonatomic,weak) IBOutlet UILabel *contentLabel;
@property(nonatomic,weak) IBOutlet UIView *bottomView;
@property(nonatomic) int zanCount;
@property(nonatomic) int caiCount;

@end
