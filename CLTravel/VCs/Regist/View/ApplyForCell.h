//
//  ApplyForCell.h
//  CLDriver
//
//  Created by MOOSON_ on 2018/10/24.
//  Copyright © 2018年 MOOSON_. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplyForCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ibTitleLab;
@property (weak, nonatomic) IBOutlet UIButton *ibCommitBtn;
@property (weak, nonatomic) IBOutlet UILabel *ibTitle;
@property (weak, nonatomic) IBOutlet UILabel *ibTextLab;
@property (weak, nonatomic) IBOutlet UITextField *ibContentTf;
@property (weak, nonatomic) IBOutlet UIView *ibImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ibTitleTop;

@end

NS_ASSUME_NONNULL_END
