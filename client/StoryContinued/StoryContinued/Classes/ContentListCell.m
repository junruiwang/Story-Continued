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
//    
//    UITapGestureRecognizer *detailTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetail)];
//    [self.contentView addGestureRecognizer:detailTap];
    
    
    [self initPageViews];
}

- (void)initPageViews
{
    PairCommonButton *zhanButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
    zhanButton.imageUrl = @"zhan_icon.png";
    zhanButton.totalNumber = self.zanCount;
    zhanButton.frame = CGRectMake(5, 0, 60, 30);
    [self.bottomView addSubview:zhanButton];
    
    PairCommonButton *caiButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
    caiButton.imageUrl = @"cai_icon.png";
    caiButton.totalNumber = self.caiCount;
    caiButton.frame = CGRectMake(75, 0, 60, 30);
//    [caiButton setImage:[UIImage imageNamed:@"pair_btn.png"] forState:UIControlStateNormal];
    [self.bottomView addSubview:caiButton];
    
    SingleCommonButton *likeButton = [SingleCommonButton buttonWithType:UIButtonTypeCustom];
    likeButton.imageUrl = @"like_icon.png";
    likeButton.frame = CGRectMake(150, 0, 30, 30);
//    [likeButton setImage:[UIImage imageNamed:@"sign_btn.png"] forState:UIControlStateNormal];
    [self.bottomView addSubview:likeButton];
    
    SingleCommonButton *shareButton = [SingleCommonButton buttonWithType:UIButtonTypeCustom];
    shareButton.imageUrl = @"share_icon.png";
    shareButton.frame = CGRectMake(270, 0, 30, 30);
//    [shareButton setImage:[UIImage imageNamed:@"sign_btn.png"] forState:UIControlStateNormal];
    [self.bottomView addSubview:shareButton];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)contentButtonTap:(id)sender;
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"信息提醒" message:@"你点击了我" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
