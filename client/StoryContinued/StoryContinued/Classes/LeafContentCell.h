//
//  LeafContentCell.h
//  StoryContinued
//
//  Created by jerry on 13-10-26.
//
//

#import <UIKit/UIKit.h>

@interface LeafContentCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel *topTitleLabel;
@property(nonatomic,weak) IBOutlet UIView *centerView;
@property(nonatomic,weak) IBOutlet UIView *bottomView;
@property(nonatomic,weak) IBOutlet UIScrollView *contentScrollView;


@end
