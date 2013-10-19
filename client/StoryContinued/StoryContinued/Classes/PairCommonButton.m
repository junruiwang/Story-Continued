//
//  PairCommonButton.m
//  StoryContinued
//
//  Created by jerry on 13-10-17.
//
//

#import "PairCommonButton.h"

@implementation PairCommonButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self loadPageContent];
}

- (void)loadPageContent
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 18, 18)];
    imageView.image = [UIImage imageNamed:self.imageUrl];
    [self addSubview:imageView];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(22,3, 40, 20)];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.font = [UIFont systemFontOfSize:14];
    numberLabel.textColor = RGBCOLOR(136, 136, 136);
    numberLabel.text = [NSString stringWithFormat:@"%d",self.totalNumber];
    [self addSubview:numberLabel];
}

@end
