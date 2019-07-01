//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "QuAnnotationView.h"

#define kCalloutWidth   170.0
#define kCalloutHeight  75.0

@interface QuAnnotationView ()

@end

@implementation QuAnnotationView

#pragma mark - Handle Action
- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override
- (void)setSelected:(BOOL)selected
{
    
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.selectBlock) {
            self.selectBlock();
        }
        if (self.calloutView == nil)
        {
            weakSelf(weakSelf)
            /* Construct custom callout. */
            QuCalloutView *calloutView = [[QuCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];

            calloutView.calloutBlock = ^(NSInteger type) {
                
                if (weakSelf.calloutBlock) {
                    weakSelf.calloutBlock(type, self.imageArray);
                }
                
            };
            self.calloutView = calloutView;

            
        }
        
        if (self.name.length > 0) {
            [self.calloutView setName:self.name];
            [self.calloutView setShowNav:self.showNav];
            
            CGFloat nameWidth = WidthForString(self.name, 13.0f, 18.0f);
            CGFloat subnNameWidth = WidthForString(self.calloutView.subName, 10.0f, 18.0f);
            
            CGFloat calloutWidth = 0.0;
            
            if (nameWidth < subnNameWidth) {
                calloutWidth = subnNameWidth + 24;
            }
            else{
                calloutWidth = nameWidth + 24;
            }
            if (self.showNav) {
                calloutWidth += 54;

            }

            if (calloutWidth <= SCREEN_WIDTH - 20) {
                [self.calloutView setFrame:CGRectMake(0, 0, calloutWidth, kCalloutHeight)];
            }
            else{
                self.calloutView = [[QuCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            }
            
        }
        self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                              -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self){
        
    }
    
    return self;
}

@end
