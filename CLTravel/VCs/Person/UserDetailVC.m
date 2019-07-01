//
//  UserDetailVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/11/6.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "UserDetailVC.h"
#import "UserTextSetCell.h"
#import "UserHeadSetCell.h"
#import "HDAlertView.h"

@interface UserDetailVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *setTableView;
@property (strong, nonatomic) NSMutableArray *setArray;
@property (nonatomic)UIImage *selectImg;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *sign;
@property(nonatomic)BOOL chooseSex;


@end

@implementation UserDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    self.quNavBar.title = @"编辑资料";
    [self.view setBackgroundColor:HEXCOLOR(@"f6f6f6")];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [rightBtn setTitleColor:HEXCOLOR(@"777777") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.quNavBar.rightView = rightBtn;
    
    self.setArray = [UserSetModel arrayForUserSet];
    
    [self.setTableView registerNib:[UINib nibWithNibName:@"UserHeadSetCell" bundle:nil] forCellReuseIdentifier:@"UserHeadSetCell"];
    
    [self.setTableView registerNib:[UINib nibWithNibName:@"UserTextSetCell" bundle:nil] forCellReuseIdentifier:@"UserTextSetCell"];
    
}

#pragma mark btnClickAction
- (void)rightBarButtonItemAction:(UIButton *)sender
{
    
     [self loadUpLoadImageRequestWithImageData:[PublicManager base64ImageDataString:_selectImg]];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.setArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.setArray[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 88.0f;
    }
    return 50.0f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10.0f;
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];

    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSArray *array = self.setArray[indexPath.section];
    UserSetModel *model = array[indexPath.row];
    if (indexPath.section == 0) {
        
        UserHeadSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserHeadSetCell"];
        
        if (_selectImg) {
            cell.headImageView.image = _selectImg;
        }
        else {
            
            if (ACCOUNTINFO.userInfo.headImg.length > 0) {
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:ACCOUNTINFO.userInfo.headImg]placeholderImage:[UIImage imageNamed:@"person_default_head"] options:SDWebImageRefreshCached];
                
            }

        }

        
        return cell;
    }
    else{
        
        UserTextSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTextSetCell"];
        cell.nameTextField.tag = indexPath.row;
        [cell.nameLabel setText:model.name];
        [cell.nameTextField setEnabled:YES];
        
        switch (indexPath.row) {
            case 0:{
                [cell.nameTextField setText:ACCOUNTINFO.userInfo.nickName];
            }
                break;
                
            case 1:{
                
                [cell.nameTextField setEnabled:NO];
                if ([@"0" isEqualToString:ACCOUNTINFO.userInfo.sex]) {
                    [cell.nameTextField setText:@"男"];
                }
                else{
                    [cell.nameTextField setText:@"女"];
                }
                
                if (_chooseSex) {
                    
                    if ([_sex integerValue]== 0) {
                        [cell.nameTextField setText:@"男"];
                    }
                    else{
                        [cell.nameTextField setText:@"女"];
                    }
                }
                
            }
                break;
                
            case 2:{
                [cell.nameTextField setText:ACCOUNTINFO.userInfo.sign];
            }
                break;
                
            default:
                break;
        }
        [cell.nameTextField addTarget:self action:@selector(nameTFchange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        HDAlertView *alertView = [HDAlertView showActionSheetWithTitle:@""];
        [alertView setDefaultButtonTitleColor:HEXCOLOR(@"404040")];
        [alertView setCancelButtonTitleColor:HEXCOLOR(@"777777")];
        
        
        [alertView addButtonWithTitle:@"我的相册" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
   
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];

        }];
        
        [alertView addButtonWithTitle:@"照片" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
            
            NSUInteger sourceType = 0;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
          
                sourceType = UIImagePickerControllerSourceTypeCamera;
            
            }
            else{
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = sourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }];
        
        [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeCancel handler:^(HDAlertView *alertView) {
            
        }];
        
        [alertView show];
    }
    else{
        
        if (indexPath.row == 0) {
            
     
        }
        else if (indexPath.row == 1){
            
            
            HDAlertView *alertView = [HDAlertView showActionSheetWithTitle:@""];
            [alertView setDefaultButtonTitleColor:HEXCOLOR(@"404040")];
            [alertView setCancelButtonTitleColor:HEXCOLOR(@"777777")];
    
            [alertView addButtonWithTitle:@"男" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
                _sex = @"0";
                _chooseSex = YES;
                NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:1 ];
                [self.setTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationNone];
          
            }];
            
            [alertView addButtonWithTitle:@"女" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
                _sex = @"1";
                _chooseSex = YES;
                NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:1 ];
                [self.setTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationNone];


            }];
            
            [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeCancel handler:^(HDAlertView *alertView) {
                
            }];
   
            [alertView show];
            
        }
        else{
   
            
        }
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImg = [info objectForKey:UIImagePickerControllerEditedImage];
    self.selectImg = photoImg;
    NSIndexSet *idxset = [NSIndexSet indexSetWithIndex:0];
    [self.setTableView reloadSections:idxset withRowAnimation:UITableViewRowAnimationNone];

    
}
- (void)nameTFchange:(UITextField *)sender{
    switch (sender.tag) {
        case 0:
            _nickName = sender.text;
            break;
        case 2:
            _sign = sender.text;
            break;
            
        default:
            break;
    }
}
- (void)loadUpLoadImageRequestWithImageData:(NSString *)imgData{
    
    [QuLoadingHUD loading];
    
    UserInfoUploadImgReq *req = [[UserInfoUploadImgReq alloc]init];
    req.userId = ACCOUNTINFO.userInfo.memberID;
    
    if (imgData) {
        req.file = imgData;
    }
  
    req.nickName = _nickName?_nickName:ACCOUNTINFO.userInfo.nickName;
    req.sign = _sign?_sign:ACCOUNTINFO.userInfo.sign;
    req.sex = _sex?_sex:ACCOUNTINFO.userInfo.sex;
 
    [NetWorkReqManager requestDataWithApiName:uploadImage params:req response:^(NSDictionary *responseObject) {
        
        [QuLoadingHUD dismiss];
        
        BaseResponse *rsp = [BaseResponse mj_objectWithKeyValues:responseObject];
        if (rsp.code == 1) {

            [self reloadUserInfo];
        };
        
    } errorResponse:^(NSString *error) {
        [QuLoadingHUD dismiss:error];
    }];
}

- (void)reloadUserInfo{
    GetPersonalInformationReq *req = [[GetPersonalInformationReq alloc]init];
    req.userId = ACCOUNTINFO.userInfo.memberID;
    [NetWorkReqManager requestDataWithApiName:getPersonalInformation params:req response:^(NSDictionary *responseObject) {
        GetPersonalInformationRsp *rsp = [GetPersonalInformationRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            ACCOUNTINFO.userInfo = rsp.data;
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    } errorResponse:^(NSString *error) {
        
    }];
}


@end
