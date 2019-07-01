//
//  RegistCodeVC.m
//  CLDriver
//
//  Created by MOOSON_ on 2018/10/23.
//  Copyright © 2018年 MOOSON_. All rights reserved.
//

#import "RegistCodeVC.h"
#import "CaptchaTimerManager.h"
#import "CodeInputView.h"
#import "ChangePassWordVC.h"
#define CountTime 60
@interface RegistCodeVC ()
@property (weak, nonatomic) IBOutlet UIButton *ibNumberBtn;
@property (nonatomic,strong) NSTimer *timer; // 定时器
@property(nonatomic,copy) __block NSString *tringTimeStr;
@property(nonatomic,assign) __block int timeout;
@property (weak, nonatomic) IBOutlet UIButton *ibNextBtn;
@property(nonatomic,strong)CodeInputView * codeView;
@end

@implementation RegistCodeVC


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setShouldShowToolbarPlaceholder:NO];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
    [[IQKeyboardManager sharedManager] setShouldShowToolbarPlaceholder:YES];
    CaptchaTimerManager *manager = [CaptchaTimerManager sharedTimerManager];
    int temp = manager.timeout;
    if (temp >0) {
        _timeout= temp;//倒计时时间
        [self timerCountDown];
    }
    //验证码输入 View
    [self.view addSubview:self.codeView];
    
}
- (CodeInputView *)codeView {
    //    __weak typeof(self) selfWeak = self;
    if (!_codeView) {
        _codeView = [[CodeInputView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 80) inputType:4 selectCodeBlock:^(NSString * code) {
            NSLog(@"code === %@",code);
        }];
        _codeView.center = self.view.center;
    }
    return _codeView;
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timeout >0) {
        CaptchaTimerManager *manager = [CaptchaTimerManager sharedTimerManager];
        if (manager.timeout ==0) {
            manager.timeout =_timeout;
            [manager countDown];
        }
        _timeout = 0;//置为0，释放controller
    }
}

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
    _timeout = CountTime;
    [self timerCountDown];
    
    
}
-(void)leftBarButtonItemAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initUI{
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
    ChangePassWordVC *vc =[[ChangePassWordVC alloc]initWithNibName:@"ChangePassWordVC" bundle:nil];
    //忘记密码进入
    if (_messageStr) {
        vc.messageStr = @"请设置新的密码";
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)timerCountDown {
    //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(self->_timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self->_tringTimeStr = nil;
                [self->_ibNumberBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                self->_ibNumberBtn.enabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self->_tringTimeStr = [NSString stringWithFormat:@"%d s",self->_timeout];
                [self->_ibNumberBtn setTitle:self->_tringTimeStr forState:UIControlStateNormal];
                self->_ibNumberBtn.enabled = NO;
                self->_timeout--;
            });
        }
    });
    dispatch_resume(_timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
