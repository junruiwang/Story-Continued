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
    NSURL* url = [NSURL URLWithString:self.story.iconUrl];
    NSData* imgData = [NSData dataWithContentsOfURL:url];
    UIImage *rectImage = [UIImage imageWithData:imgData];
    if (rectImage == nil) {
        rectImage = [UIImage imageNamed:@"member_pic.png"];
    }
    self.memberIconView.image = rectImage;
    self.userName.text = self.story.userName;
    self.totalMember.text = [NSString stringWithFormat:@"%d人参与接龙",self.story.totalPartake];
    self.contentLabel.text = self.story.storyHeadContext;
    self.writeTime.text = self.story.createTime;
    
    PairCommonButton *zhanButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
    zhanButton.imageUrl = @"zhan_icon.png";
    zhanButton.totalNumber = self.story.totalLike;
    zhanButton.frame = CGRectMake(30, 0, 70, 30);
    [self.bottomView addSubview:zhanButton];
    
    PairCommonButton *caiButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
    caiButton.imageUrl = @"cai_icon.png";
    caiButton.totalNumber = self.story.totalDislike;
    caiButton.frame = CGRectMake(105, 0, 70, 30);
    [self.bottomView addSubview:caiButton];
    
    SingleCommonButton *likeButton = [SingleCommonButton buttonWithType:UIButtonTypeCustom];
    likeButton.imageUrl = @"like_icon.png";
    likeButton.frame = CGRectMake(180, 0, 30, 30);
    [self.bottomView addSubview:likeButton];
    
    SingleCommonButton *shareButton = [SingleCommonButton buttonWithType:UIButtonTypeCustom];
    [shareButton addTarget:self action:@selector(shareMessage:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.imageUrl = @"share_icon.png";
    shareButton.frame = CGRectMake(255, 0, 30, 30);
    [self.bottomView addSubview:shareButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)contentButtonTap:(id)sender
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(didTapRowContent:)])
        [self.delegate didTapRowContent:self.story];
}

- (void)shareMessage:(id)sender
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(didShareButtonClicked:)])
        [self.delegate didShareButtonClicked:self.story.storyHeadContext];
}

@end
