//
//  LeafContentCell.m
//  StoryContinued
//
//  Created by jerry on 13-10-26.
//
//

#import "LeafContentCell.h"
#import "Constants.h"
#import "JBContent.h"
#import "PairCommonButton.h"
#import "SingleCommonButton.h"

@implementation LeafContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leafList = [[NSArray alloc] init];
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
    NSArray *contViews = [self.contentScrollView subviews];
    for (UIView *view in contViews) {
        [view removeFromSuperview];
    }
    
    CGRect rect = self.contentScrollView.frame;
    self.contentScrollView.contentSize = CGSizeMake(rect.size.width * self.leafList.count, rect.size.height);
    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    
    for (int i=0; i<self.leafList.count; i++) {
        JBContent *content = self.leafList[i];
        UIView *leafView = [[UIView alloc] initWithFrame:[self getRectByPageNumber:i andViewWidth:rect]];
        leafView.backgroundColor = [UIColor clearColor];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 291, rect.size.height-40)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = RGBCOLOR(51, 51, 51);
        textLabel.font = [UIFont systemFontOfSize:17];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.numberOfLines = 0;
        textLabel.text = content.contentText;
        [leafView addSubview:textLabel];
        
        UIView *tagView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height-40, rect.size.width, 40)];
        tagView.backgroundColor = [UIColor clearColor];
        
        UIImageView *memberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 8, 25, 25)];
        NSURL* url = [NSURL URLWithString:content.iconUrl];
        NSData* imgData = [NSData dataWithContentsOfURL:url];
        UIImage *rectImage = [UIImage imageWithData:imgData];
        if (rectImage == nil) {
            rectImage = [UIImage imageNamed:@"member_pic.png"];
        }
        memberImageView.image = rectImage;
        [tagView addSubview:memberImageView];
        
        UILabel *memName = [[UILabel alloc] initWithFrame:CGRectMake(37, 4, 134, 18)];
        memName.backgroundColor = [UIColor clearColor];
        memName.textColor = RGBCOLOR(136, 136, 136);
        memName.font = [UIFont systemFontOfSize:10];
        memName.text = content.userName;
        [tagView addSubview:memName];
        
        UILabel *createTime = [[UILabel alloc] initWithFrame:CGRectMake(37, 17, 134, 19)];
        createTime.backgroundColor = [UIColor clearColor];
        createTime.textColor = RGBCOLOR(136, 136, 136);
        createTime.font = [UIFont systemFontOfSize:10];
        createTime.text = content.createTime;
        [tagView addSubview:createTime];
        
        PairCommonButton *zhanButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
        zhanButton.imageUrl = @"zhan_icon.png";
        zhanButton.totalNumber = content.like;
        zhanButton.frame = CGRectMake(150, 10, 70, 30);
        [tagView addSubview:zhanButton];
        
        PairCommonButton *caiButton = [PairCommonButton buttonWithType:UIButtonTypeCustom];
        caiButton.imageUrl = @"cai_icon.png";
        caiButton.totalNumber = content.dislike;
        caiButton.frame = CGRectMake(230, 10, 70, 30);
        [tagView addSubview:caiButton];
        
        [leafView addSubview:tagView];
        [self.contentScrollView addSubview:leafView];
    }
    [self.contentScrollView setContentOffset:CGPointMake(rect.size.width*self.pageIndex, 0)];
}

//- (void)updatePager
//{
//    self.pagerView.page = floorf(self.contentScrollView.contentOffset.x / self.contentScrollView.frame.size.width);
//}


- (CGRect)getRectByPageNumber:(CGFloat)num andViewWidth:(CGRect)rect
{
    return CGRectMake(num * rect.size.width, 0, rect.size.width, rect.size.height);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int location=((int)self.contentScrollView.contentOffset.x)/((int)self.contentScrollView.frame.size.width);
    self.pageIndex = location;
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(didScrollRowContent:)])
        [self.delegate didScrollRowContent:location];
}

@end
