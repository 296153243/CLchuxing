//
//  UIView+JKPicker.m
//  xianyu
//
//  Created by ijointoo on 2017/8/10.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "UIView+JKPicker.h"

@implementation UIView (JKPicker)

- (CGFloat)JKleft {
    return self.frame.origin.x;
}
-(void)setJKleft:(CGFloat)JKleft{
    CGRect frame = self.frame;
    frame.origin.x = JKleft;
    self.frame = frame;
}
- (CGFloat)JKtop {
    return self.frame.origin.y;
}
- (void)setJKtop:(CGFloat)JKtop {
    CGRect frame = self.frame;
    frame.origin.y = JKtop;
    self.frame = frame;
}

- (CGFloat)JKright {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setJKright:(CGFloat)JKright {
    CGRect frame = self.frame;
    frame.origin.x = JKright - frame.size.width;
    self.frame = frame;
}

- (CGFloat)JKbottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setJKbottom:(CGFloat)JKbottom {
    CGRect frame = self.frame;
    frame.origin.y = JKbottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)JKcenterX {
    return self.center.x;
}

- (void)setJKcenterX:(CGFloat)JKcenterX {
    self.center = CGPointMake(JKcenterX, self.center.y);
}

- (CGFloat)JKcenterY {
    return self.center.y;
}

- (void)setJKcenterY:(CGFloat)JKcenterY {
    self.center = CGPointMake(self.center.x, JKcenterY);
}

- (CGFloat)JKwidth {
    return self.frame.size.width;
}

- (void)setJKwidth:(CGFloat)JKwidth {
    CGRect frame = self.frame;
    frame.size.width = JKwidth;
    self.frame = frame;
}

- (CGFloat)JKheight {
    return self.frame.size.height;
}

- (void)setJKheight:(CGFloat)JKheight {
    CGRect frame = self.frame;
    frame.size.height = JKheight;
    self.frame = frame;
}

- (CGPoint)JKorigin {
    return self.frame.origin;
}
-(void)setJKorigin:(CGPoint)JKorigin{
    CGRect frame = self.frame;
    frame.origin = JKorigin;
    self.frame = frame;
}
- (CGSize)JKsize {
    return self.frame.size;
}

- (void)setJKsize:(CGSize)JKsize {
    CGRect frame = self.frame;
    frame.size = JKsize;
    self.frame = frame;
}
@end
