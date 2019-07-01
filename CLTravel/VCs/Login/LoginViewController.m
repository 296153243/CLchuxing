//
//  LoginViewController.m
//  CLDriver
//
//  Created by MOOSON_ on 2018/10/23.
//  Copyright © 2018年 MOOSON_. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginOneVC.h"
#import "RegistChooseRoleVC.h"
#import "ApplyForDriverVC.h"
#import "ApplyForMasterVC.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *ibLoginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    //使用自定义导航栏
    CLNavigationBar *bar = [CLNavigationBar showCLNavigationBarWithController:self];
    self.clNavBar = bar;
    
//    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [leftBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.quNavBar.leftView = leftBtn;
    
 
   
}
-(void)leftBarButtonItemAction:(UIButton *)sender{
    
}
- (IBAction)gogogoClick:(id)sender {
//    ApplyForDriverVC *vc = [[ApplyForDriverVC alloc]initWithNibName:@"ApplyForDriverVC" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    ApplyForMasterVC *vc = [[ApplyForMasterVC alloc]initWithNibName:@"ApplyForMasterVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)initUI{
    _ibLoginBtn.clipsToBounds = YES;
    _ibLoginBtn.layer.cornerRadius = 5;
    _ibLoginBtn.backgroundColor = [UIColor colorWithRed:73/255.0 green:95/255.0 blue:178/255.0 alpha:1];
    _ibLoginBtn.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor;
    _ibLoginBtn.layer.shadowOffset = CGSizeMake(0,3);
    _ibLoginBtn.layer.shadowOpacity = 1;
    _ibLoginBtn.layer.shadowRadius = 5;

    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(193.5,557.5,152.5,50);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:73/255.0 green:84/255.0 blue:117/255.0 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:70/255.0 green:78/255.0 blue:102/255.0 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:77/255.0 blue:101/255.0 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:78/255.0 green:87/255.0 blue:117/255.0 alpha:1].CGColor];
    gl.locations = @[@(0.0),@(0.0),@(0.5),@(1.0)];
    [_ibLoginBtn.layer addSublayer:gl];

}
- (IBAction)ibLoginBtnClick:(id)sender {
    LoginOneVC *vc= [[LoginOneVC alloc]initWithNibName:@"LoginOneVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)ibRegistBtnClick:(id)sender {
    RegistChooseRoleVC *vc = [[RegistChooseRoleVC alloc]initWithNibName:@"RegistChooseRoleVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
