//
//  ChangePassWordVC.m
//  CLDriver
//
//  Created by MOOSON_ on 2018/10/24.
//  Copyright © 2018年 MOOSON_. All rights reserved.
//

#import "ChangePassWordVC.h"

@interface ChangePassWordVC ()
@property (weak, nonatomic) IBOutlet UILabel *ibMessageLab;
@property (weak, nonatomic) IBOutlet UIButton *ibLoginOrRegistBtn;
@end

@implementation ChangePassWordVC

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
    [UIButton addBtnShadow:_ibLoginOrRegistBtn];
  
}
-(void)leftBarButtonItemAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initUI{
    if (_messageStr) {
        _ibMessageLab.text = _messageStr;
    }
   
    
    
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
