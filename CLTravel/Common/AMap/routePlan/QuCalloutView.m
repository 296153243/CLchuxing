//
//  CustomCalloutView.m
//  Category_demo2D
//
//  Created by xiaoming han on 13-5-22.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "QuCalloutView.h"
#import <QuartzCore/QuartzCore.h>

#define kArrorHeight 10

@interface QuCalloutView ()

@property (strong, nonatomic) UIView *navView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIButton *navBtn;
@property (strong, nonatomic) UILabel *navLabel;
@property (strong, nonatomic) UIImageView *navImageView;
@property (strong, nonatomic) UIButton *siteBtn;
@property (strong, nonatomic) UIView *lineView;

@end

@implementation QuCalloutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    //站点按钮
    UIButton *siteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [siteBtn setBackgroundColor:[UIColor clearColor]];
    [siteBtn addTarget:self action:@selector(siteClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:siteBtn];
    
    [siteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
        
    }];
    self.siteBtn = siteBtn;
    
    // 导航view
    UIView *navView = [[UIView alloc]init];
    [navView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:navView];
    
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.equalTo(self);
        make.width.mas_equalTo(54);
        make.height.mas_equalTo(65);
    }];
    
    self.navView = navView;
    
    //导航按钮
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navBtn setBackgroundColor:[UIColor clearColor]];
    [navBtn addTarget:self action:@selector(navClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:navBtn];
    
    [navBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(navView);
        
    }];
    self.navBtn = navBtn;
    
    //导航图标
    UIImageView *navImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"route_nav_icon"]];
    [self.navView addSubview:navImageView];
    
    [navImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(navView).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(navView);
        
    }];
    self.navImageView = navImageView;
    
    //导航文字
    UILabel *navLabel = [[UILabel alloc]init];
    [navLabel setTextAlignment:NSTextAlignmentCenter];
    [navLabel setTextColor:HEXCOLOR(@"0090FF")];
    [navLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [navLabel setText:@"去这里"];
    [self.navView addSubview:navLabel];
    
    [navLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(navView).offset(5);
        make.right.equalTo(navView).offset(-5);
        make.height.mas_offset(14);
        make.top.equalTo(navView).offset(37);
        
    }];
    self.navLabel = navLabel;
    
    //左侧线
    UIView *leftView = [[UIView alloc]init];
    [leftView setBackgroundColor:HEXCOLOR(@"dbdbdb")];
    [self.navView addSubview:leftView];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.navView);
        make.width.mas_equalTo(0.5f);
        make.height.mas_equalTo(36);
        make.centerY.mas_equalTo(self.navView);
    }];
    self.lineView = leftView;
   
    //标题文字
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setTextColor:HEXCOLOR(@"404040")];
    [titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [titleLabel setText:@"站点名称"];
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(66);
        make.height.mas_offset(18);
        make.top.equalTo(self).offset(11);
        
    }];
    self.titleLabel = titleLabel;
    
    // 添加副标题文字
    UILabel *subTitleLabel = [[UILabel alloc]init];
    [subTitleLabel setTextColor:HEXCOLOR(@"ff5c41")];
    [subTitleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [subTitleLabel setText:@"查看站点图片"];
    [self addSubview:subTitleLabel];
    
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(66);
        make.height.mas_offset(14);
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        
    }];
    self.subTitleLabel = subTitleLabel;
    self.subName = subTitleLabel.text;
    

}

- (void)setName:(NSString *)name
{
    _name = name;
    [self.titleLabel setText:name];
}

- (void)setShowNav:(BOOL)showNav
{
    _showNav = showNav;
    
    if (showNav) {
        
        [self.navView setHidden:NO];
 
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self).offset(12);
        }];
    }
    else{
        
        [self.navView setHidden:YES];

        [self.navView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self).offset(66);
        }];
         
    }
}

#pragma mark btnClickAction
- (void)navClickAction:(UIButton *)sender
{
    if (self.calloutBlock) {
        self.calloutBlock(2);
    }
}

- (void)siteClickAction:(UIButton *)sender
{
    if (self.calloutBlock) {
        self.calloutBlock(1);
    }
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];

    self.layer.shadowColor = [HEXCOLOR(@"dbdbdb") CGColor];
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.9].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 4.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
