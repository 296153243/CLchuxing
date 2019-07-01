//
//  MAMapView+Help.m
//  QuPassenger
//
//  Created by Chenmusong on 2018/1/4.
//  Copyright © 2018年 com.Qyueche. All rights reserved.
//

#import "MAMapView+Help.h"

@implementation MAMapView (Help)
+ (void)hiddenLogo:(MAMapView *)mapView{
    
    [mapView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
   
        if ([obj isKindOfClass:[UIImageView class]]) {
            
            UIImageView * logoM = obj;
            
            logoM.layer.contents = (__bridge id)[UIImage imageNamed:@""].CGImage;
            
        }
        
    }];
    

}
@end
