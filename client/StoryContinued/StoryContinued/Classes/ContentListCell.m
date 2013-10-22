//
//  ContentListCell.m
//  StoryContinued
//
//  Created by jerry on 13-10-15.
//
//

#import "ContentListCell.h"
#import "PairCommonButton.h"
#import "SingleCommonButton.h"

@implementation ContentListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews]; 
//    UITapGestureRecognizer *detailTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetail)];
//    [self.contentView addGestureRecognizer:detailTap];
    
    
    [self initPageViews];
}

- (void)initPageViews
{
    NSArray *views = [self.bottomView subviews];
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    
    PairCommonButton *zhanButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
    zhanButton.imageUrl = @"zhan_icon.png";
    zhanButton.totalNumber = self.zanCount;
    zhanButton.frame = CGRectMake(30, 0, 70, 30);
    [self.bottomView addSubview:zhanButton];
    
    PairCommonButton *caiButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
    caiButton.imageUrl = @"cai_icon.png";
    caiButton.totalNumber = self.caiCount;
    caiButton.frame = CGRectMake(105, 0, 70, 30);
    [self.bottomView addSubview:caiButton];
    
    SingleCommonButton *likeButton = [SingleCommonButton buttonWithType:UIButtonTypeCustom];
    likeButton.imageUrl = @"like_icon.png";
    likeButton.frame = CGRectMake(180, 0, 30, 30);
    [self.bottomView addSubview:likeButton];
    
    SingleCommonButton *shareButton = [SingleCommonButton buttonWithType:UIButtonTypeCustom];
    shareButton.imageUrl = @"share_icon.png";
    shareButton.frame = CGRectMake(255, 0, 30, 30);
    [self.bottomView addSubview:shareButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)contentButtonTap:(id)sender;
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"信息提醒" message:@"你点击了我" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(didTapRowContent:)])
        [self.delegate didTapRowContent:nil];
}

@end
