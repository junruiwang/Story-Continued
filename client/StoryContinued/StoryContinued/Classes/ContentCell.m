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
    NSURL* url = [NSURL URLWithString:self.content.iconUrl];
    NSData* imgData = [NSData dataWithContentsOfURL:url];
    UIImage *rectImage = [UIImage imageWithData:imgData];
    if (rectImage == nil) {
        rectImage = [UIImage imageNamed:@"member_pic.png"];
    }
    self.memberIconView.image = rectImage;
    self.userName.text = self.content.userName;
    self.writeTime.text = self.content.createTime;
    self.levelTag.text = [NSString stringWithFormat:@"%d楼",self.content.level];
    self.contentLabel.text = self.content.contentText;
}

@end
