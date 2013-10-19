//
//  SingleCommonButton.m
//  StoryContinued
//
//  Created by jerry on 13-10-19.
//
//

#import "SingleCommonButton.h"

@implementation SingleCommonButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
}

@end
