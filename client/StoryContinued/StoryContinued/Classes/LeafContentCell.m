//
//  LeafContentCell.m
//  StoryContinued
//
//  Created by jerry on 13-10-26.
//
//

#import "LeafContentCell.h"

@implementation LeafContentCell

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
//    [self initPageViews];
}

- (void)initPageViews
{
    
}


@end
