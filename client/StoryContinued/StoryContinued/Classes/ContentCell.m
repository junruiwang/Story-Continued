//
//  ContentCell.m
//  StoryContinued
//
//  Created by jerry on 13-10-22.
//
//

#import "ContentCell.h"
#import "PairCommonButton.h"
#import "SingleCommonButton.h"

@implementation ContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];    
    [self initPageViews];
}

- (void)initPageViews
{
    NSArray *views = [self.bottomView subviews];
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    NSURL* url = [NSURL URLWithString:self.content.iconUrl];
    NSData* imgData = [NSData dataWithContentsOfURL:url];
    UIImage *rectImage = [UIImage imageWithData:imgData];
    if (rectImage == nil) {
        rectImage = [UIImage imageNamed:@"member_pic.png"];
    }
    self.memberIconView.image = rectImage;
    self.userName.text = self.content.userName;
    self.writeTime.text = self.content.createTime;
    self.levelTag.text = [NSString stringWithFormat:@"#%d",self.content.level];
    self.contentLabel.text = self.content.contentText;
    
    PairCommonButton *zhanButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
    zhanButton.imageUrl = @"zhan_icon.png";
    zhanButton.totalNumber = self.content.like;
    zhanButton.frame = CGRectMake(30, 0, 70, 30);
    [self.bottomView addSubview:zhanButton];
    
    PairCommonButton *caiButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
    caiButton.imageUrl = @"cai_icon.png";
    caiButton.totalNumber = self.content.dislike;
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

@end
