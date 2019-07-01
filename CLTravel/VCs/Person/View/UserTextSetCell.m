//
//  UserTextSetCell.m
//  QuPassenger
//
//  Created by 朱青 on 2017/11/6.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "UserTextSetCell.h"

@implementation UserTextSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameTextField.borderStyle = UITextBorderStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
