//
//  RegistPhoneVC.m
//  CLDriver
//
//  Created by MOOSON_ on 2018/10/23.
//  Copyright © 2018年 MOOSON_. All rights reserved.
//

#import "RegistPhoneVC.h"
#import "RegistCodeVC.h"
@interface RegistPhoneVC ()
@property (weak, nonatomic) IBOutlet UIButton *ibNextBtn;
@property (weak, nonatomic) IBOutlet UITextField *ibPhoneTf;
@property (weak, nonatomic) IBOutlet UILabel *ibTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *ibMessageLab;

@end

@implementation RegistPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //使用自定义导航栏
    CLNavigationBar *bar = [CLNavigationBar showCLNavigationBarWithController:self];
    self.clNavBar = bar;
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"Bank"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clNavBar.leftView = leftBtn;
    [self initUI];
  
}
-(void)leftBarButtonItemAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initUI{
   
    if (_messageStr) {
        _ibMessageLab.text = _messageStr;
    }
    
    _ibNextBtn.clipsToBounds = YES;
    _ibNextBtn.layer.cornerRadius = 5;
    _ibNextBtn.backgroundColor = [UIColor colorWithRed:73/255.0 green:95/255.0 blue:178/255.0 alpha:1];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(25,414.5,325,50);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:73/255.0 green:84/255.0 blue:117/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:70/255.0 green:78/255.0 blue:102/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:77/255.0 blue:101/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:78/255.0 green:87/255.0 blue:117/255.0 alpha:0.8].CGColor];
    gl.locations = @[@(0.0),@(0.0),@(0.5),@(1.0)];
    [_ibNextBtn.layer addSublayer:gl];
    
    
}
- (IBAction)ibNextBtnClick:(id)sender {
    //验证手机号码
//    if (_ibPhoneTf.text.length != 11) {
//
//        [QuHudHelper qu_showMessage:@"请输入正确的11位手机号码"];
//        return ;
//    }

    RegistCodeVC *vc = [[RegistCodeVC alloc]initWithNibName:@"RegistCodeVC" bundle:nil];
    vc.messageStr = _messageStr;
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
