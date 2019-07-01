//
//  QuMapView.m
//  QuPassenger
//
//  Created by 朱青 on 2018/1/17.
//  Copyright © 2018年 com.Qyueche. All rights reserved.
//

#import "QuMapView.h"

@implementation QuMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.showsLabels = YES;
        self.showsCompass = NO;
        self.showsScale = NO;
        self.skyModelEnable = NO;
        self.rotateCameraEnabled = NO;
        self.rotateEnabled = NO;
    
        [MAMapView hiddenLogo:self];
    }
    return self;
}

@end
