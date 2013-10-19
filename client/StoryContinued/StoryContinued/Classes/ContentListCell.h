//
//  ContentListCell.h
//  StoryContinued
//
//  Created by jerry on 13-10-15.
//
//

#import <UIKit/UIKit.h>

@interface ContentListCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIImageView *memberIconView;
@property(nonatomic,weak) IBOutlet UILabel *userName;
@property(nonatomic,weak) IBOutlet UILabel *writeTime;
@property(nonatomic,weak) IBOutlet UILabel *totalMember;
@property(nonatomic,weak) IBOutlet UIButton *contentButton;
@property(nonatomic,weak) IBOutlet UILabel *contentLabel;
@property(nonatomic,weak) IBOutlet UIView *bottomView;
@property(nonatomic) int zanCount;
@property(nonatomic) int caiCount;

- (IBAction)contentButtonTap:(id)sender;

@end
