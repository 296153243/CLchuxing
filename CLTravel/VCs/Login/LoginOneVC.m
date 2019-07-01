//
//  LoginOneVC.m
//  CLDriver
//
//  Created by MOOSON_ on 2018/10/23.
//  Copyright © 2018年 MOOSON_. All rights reserved.
//

#import "LoginOneVC.h"
#import "RegistPhoneVC.h"
@interface LoginOneVC ()
@property (weak, nonatomic) IBOutlet UITextField *ibPhoneTf;
@property (weak, nonatomic) IBOutlet UITextField *ibPassWordTf;
@property(strong,nonatomic) UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UIButton *ibDriverBtn;
@property (weak, nonatomic) IBOutlet UIButton *ibMasterBtn;
@property (weak, nonatomic) IBOutlet UIButton *ibLoginBtn;

@end

@implementation LoginOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //使用自定义导航栏
    CLNavigationBar *bar = [CLNavigationBar showCLNavigationBarWithController:self];
    self.clNavBar = bar;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"Bank"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clNavBar.leftView = leftBtn;
    _ibPhoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    _ibDriverBtn.selected = YES;
    _markBtn = _ibDriverBtn;
    
    [self initUI];
    
}
-(void)initUI{
    [UIButton addBtnShadow:_ibLoginBtn];
   
}
-(void)leftBarButtonItemAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)passwordShowBtnClick:(UIButton *)sender {
  
    _ibPassWordTf.enabled = NO;
    _ibPassWordTf.secureTextEntry = sender.selected;
      sender.selected = !sender.selected;
    _ibPassWordTf.enabled  = YES;
    [_ibPassWordTf becomeFirstResponder];
  
   
}
- (IBAction)ibDriverBtnClick:(UIButton *)sender {
    
//    sender.selected = !sender.selected;
   
    if (_markBtn != sender) {
        sender.selected = YES;
        _markBtn.selected = NO;
        _markBtn = sender;
    }

}
- (IBAction)forgetPasswordClick:(id)sender {
    RegistPhoneVC *vc = [[RegistPhoneVC alloc]initWithNibName:@"RegistPhoneVC" bundle:nil];
    vc.messageStr = @"输入注册手机号码验证信息";
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
