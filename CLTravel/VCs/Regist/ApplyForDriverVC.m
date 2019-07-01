//
//  ApplyForDriverVC.m
//  CLDriver
//
//  Created by MOOSON_ on 2018/10/24.
//  Copyright © 2018年 MOOSON_. All rights reserved.
//

#import "ApplyForDriverVC.h"
#import "ApplyForCell.h"
@interface ApplyForDriverVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ApplyForDriverVC

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
}
-(void)leftBarButtonItemAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//TODO:----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyForCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyForCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ApplyForCell" owner:nil options:nil][0];
    }
    switch (indexPath.row) {
        case 0:{
          cell = [[NSBundle mainBundle]loadNibNamed:@"ApplyForCell" owner:nil options:nil][0];
        }
            break;
        case 1:{
            cell = [[NSBundle mainBundle]loadNibNamed:@"ApplyForCell" owner:nil options:nil][1];
        }
            break;
        case 2:{
            cell = [[NSBundle mainBundle]loadNibNamed:@"ApplyForCell" owner:nil options:nil][2];
            cell.ibTitle.text = @"驾龄";

        }
            break;
        case 3:{
            cell = [[NSBundle mainBundle]loadNibNamed:@"ApplyForCell" owner:nil options:nil][2];
            cell.ibTitle.text = @"注册地";
            cell.ibTextLab.text = @"苏州市";
            
        }
            break;
        case 4:{
            cell = [[NSBundle mainBundle]loadNibNamed:@"ApplyForCell" owner:nil options:nil][1];
            cell.separatorInset = UIEdgeInsetsMake(0, 1500, 0, 0);
            cell.ibTitleLab.text = @"推荐人电话";
            cell.ibContentTf.placeholder =@"选填";
        }
            break;
        case 5:{
            cell = [[NSBundle mainBundle]loadNibNamed:@"ApplyForCell" owner:nil options:nil][3];
            cell.ibImgView.hidden = YES;
        }
            break;
        case 6:{
            cell = [[NSBundle mainBundle]loadNibNamed:@"ApplyForCell" owner:nil options:nil][4];
            [UIButton addBtnShadow:cell.ibCommitBtn];
        }
            break;
        default:
            break;
    }
    return cell;
    
}
//TODO:---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 113;
            break;
        case 5:
            return 381;
            break;
        case 6:
            return 317;
            break;
        default:{
            return 55;
        }
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
