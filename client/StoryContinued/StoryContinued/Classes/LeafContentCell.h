//
//  LeafContentCell.h
//  StoryContinued
//
//  Created by jerry on 13-10-26.
//
//

#import <UIKit/UIKit.h>

@class ContentListCell;

#pragma mark - LeafContentCellDelegate

@protocol LeafContentCellDelegate <NSObject>

@optional

- (void)didScrollRowContent:(NSInteger)pageIndex;

@end

@interface LeafContentCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, weak) id<LeafContentCellDelegate> delegate;
@property(nonatomic,weak) IBOutlet UILabel *topTitleLabel;
@property(nonatomic,weak) IBOutlet UIView *centerView;
@property(nonatomic,weak) IBOutlet UIView *bottomView;
@property(nonatomic,weak) IBOutlet UIScrollView *contentScrollView;
@property(nonatomic) NSInteger pageIndex;
@property(nonatomic,strong) NSString *storyId;
@property(nonatomic,strong) NSArray *leafList;

@end
