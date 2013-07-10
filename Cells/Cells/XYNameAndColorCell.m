//
//  XYNameAndColorCell.m
//  Cells
//
//  Created by Xia Yong on 13-7-10.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYNameAndColorCell.h"

#define kNameValueTag   1
#define kColorValueTag  2

@implementation XYNameAndColorCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 70, 15)];
        nameLabel.textAlignment = kCTRightTextAlignment;
        nameLabel.text = @"Name:";
        nameLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:nameLabel];
        
        UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, 70, 15)];
        colorLabel.textAlignment = kCTRightTextAlignment;
        colorLabel.text = @"Color:";
        colorLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:colorLabel];
        
        UILabel *nameValue = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 200, 15)];
        nameValue.tag = kNameValueTag;
        [self.contentView addSubview:nameValue];
        
        UILabel *colorValue = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 200, 15)];
        colorValue.tag = kColorValueTag;
        [self.contentView addSubview:colorValue];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)newName {
    if (![newName isEqualToString:_name]) {
        _name = [newName copy];
        //UILabel *nameLabel = (UILabel *)[self.contentView viewWithTag:kNameValueTag];
        self.nameLabel.text = _name;
    }
}

- (void)setColor:(NSString *)newColor {
    if (![newColor isEqualToString:_color]) {
        _color = [newColor copy];
        //UILabel *colorLabel = (UILabel *)[self.contentView viewWithTag:kColorValueTag];
        self.colorLabel.text = _color;
    }
}

@end
