//
//  UserHeadSetCell.m
//  QuPassenger
//
//  Created by 朱青 on 2017/11/6.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "UserHeadSetCell.h"

@implementation UserHeadSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.headImageView.layer setMasksToBounds:YES];
    [self.headImageView setCornerRadius:30.0f AndBorder:0.0f borderColor:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
