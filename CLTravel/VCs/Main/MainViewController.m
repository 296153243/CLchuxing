
//
//  MainViewController.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "MainViewController.h"
#import "MainChannelCell.h"
#import "MainBannerCell.h"
#import "MainBusRouteCell.h"
#import "MainNoneRouteCell.h"
#import "MainLeftCateCell.h"
#import "MainSiteSearchCell.h"
#import "MainRouteRecommandView.h"
#import "WXRegistViewController.h"
#import "JourneyViewController.h"
#import "CitySelectVC.h"
#import "MyWalletVC.h"
#import "RouteDetailVC.h"
#import "SettingVC.h"
#import "MessageVC.h"
#import "PayTheTicketVC.h"
#import "BuyTicketListVC.h"
#import "JPUSHService.h"
#import "MyInfoVC.h"
#import "VoiceSearchVC.h"
#import "StarSiteVC.h"
#import "EndSiteVC.h"
#import "LineSearchVC.h"
#import "VersionAlertView.h"

#define CATEGORYWIDTH 188

@interface MainViewController ()<AMapSearchDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutlet UIView *titleHeadView;
@property (weak, nonatomic) IBOutlet UIView *leftHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UILabel *leftNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftHeadImageView;
@property (weak, nonatomic) IBOutlet UIButton *ticketBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topLogoImageView;
@property (weak, nonatomic) IBOutlet UIButton *leftCityBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cityBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headimgTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ticketBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *bottomInputView;
@property (strong, nonatomic) UIButton *bgBlackBtn;
@property (strong, nonatomic) UIButton *messageBtn;
@property (strong, nonatomic) NSArray *leftArray;
@property (strong, nonatomic) MainRsp *mainRsp;
@property (assign, nonatomic) BOOL showStatusBar;
@property (assign, nonatomic) BOOL isShowLeft;
@property (assign, nonatomic) CGFloat startScrollOffset;
@property(nonatomic)NSInteger invertSelection;//记录是否进行了出发地目的地反选

@property (strong, nonatomic) IBOutlet UIView *bigSearchView;
@property (strong, nonatomic) UIVisualEffectView *blurEffectView;
@property (weak, nonatomic) IBOutlet UIButton *blurSearchBtn;
@property (weak, nonatomic) IBOutlet UIButton *blurExchangeBtn;
@property (weak, nonatomic) IBOutlet UITextField *blurStartTextField;
@property (weak, nonatomic) IBOutlet UITextField *blurEndTextField;
@property (weak, nonatomic) IBOutlet UIView *blurSearchView;
@property (weak, nonatomic) IBOutlet UITableView *blurSearchTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blurHeightConstraint;
@property (strong,nonatomic) AMapSearchAPI *mapSearcher;
@property (strong,nonatomic) NSMutableArray *mapAddressArray;

//scrollSearchView
@property (strong, nonatomic) IBOutlet UIView *scrollSearchView;
@property (weak, nonatomic) IBOutlet UIButton *scrollSearchBtn;
@property (weak, nonatomic) IBOutlet UIButton *scrollExchangeBtn;
@property (weak, nonatomic) IBOutlet UITextField *scrollStartTextField;
@property (weak, nonatomic) IBOutlet UITextField *scrollEndTextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenInvaildNotification:) name:TOKEN_INVAILD_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showVoiceNotification:) name:SHOW_VOICE_NOTIFICATION object:nil];
    
    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    self.quNavBar.titleView = self.titleHeadView;
    
    if (@available(iOS 11.0, *)) {
        self.mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
//    else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    self.cityBottomConstraint.constant = SCREEN_BOTTOM_MARGIN + 20;
    self.headimgTopConstraint.constant = SCREEN_STATUSBAR_HEIGHT - 20;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"main_person_icon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.quNavBar.leftView = leftBtn;
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"main_message_icon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.messageBtn = rightBtn;
    self.quNavBar.rightView = rightBtn;
    
    self.showStatusBar = YES;
    
    UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blackBtn setFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    blackBtn.alpha = 0.0f;
    [blackBtn addTarget:self action:@selector(categoryBackAction:) forControlEvents:UIControlEventTouchUpInside];
    blackBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackBtn];
    self.bgBlackBtn = blackBtn;
    
    //添加侧边栏
    [self.leftView setFrame:CGRectMake(-CATEGORYWIDTH,0,CATEGORYWIDTH,SCREEN_HEIGHT)];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.leftView addGestureRecognizer:panGesture];
    [self.view addSubview:self.leftView];
    
    
    [self.mainCollectionView setBackgroundColor:HEXCOLOR(@"f2f2f2")];
    
    UINib *shareNib = [UINib nibWithNibName:@"MainBannerCell" bundle:nil];
    [self.mainCollectionView registerNib:shareNib forCellWithReuseIdentifier:@"MainBannerCell"];
    
    UINib *channelNib = [UINib nibWithNibName:@"MainChannelCell" bundle:nil];
    [self.mainCollectionView registerNib:channelNib forCellWithReuseIdentifier:@"MainChannelCell"];

    UINib *goodsNib = [UINib nibWithNibName:@"MainBusRouteCell" bundle:nil];
    [self.mainCollectionView registerNib:goodsNib forCellWithReuseIdentifier:@"MainBusRouteCell"];
    
    UINib *noneNib = [UINib nibWithNibName:@"MainNoneRouteCell" bundle:nil];
    [self.mainCollectionView registerNib:noneNib forCellWithReuseIdentifier:@"MainNoneRouteCell"];
    
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"MainRouteRecommandView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainRouteRecommandView"];
    
    [self.leftTableView registerNib:[UINib nibWithNibName:@"MainLeftCateCell" bundle:nil] forCellReuseIdentifier:@"MainLeftCateCell"];
    
    [self.blurSearchTableView registerNib:[UINib nibWithNibName:@"MainSiteSearchCell" bundle:nil] forCellReuseIdentifier:@"MainSiteSearchCell"];
    
    NSArray *array = [LocalDataModel arrayForMainLeftCategory];
    self.leftArray = array;
    
    [self.leftHeadImageView.layer setMasksToBounds:YES];
    [self.leftHeadImageView setCornerRadius:self.leftHeadImageView.mj_w/2 AndBorder:0 borderColor:nil];
    
    self.leftHeaderView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
    [self.leftHeaderView addGestureRecognizer:tapGesture];
    
    [self.ticketBtn showShadowColorWithColor:HEXCOLOR(@"ff5c41") offset:CGSizeMake(0, 5) opacity:0.5 radius:3.0];
    
    NSString *uid = [PublicManager getLocalUserId];
    if (uid.length > 0) {
        [self autoLoginRequestWithId:uid];
    }
    
    //优先获取本地数据
    NSDictionary *localDictionary = [PublicManager getMainDataFromLocal];
    if (localDictionary) {

        MainRsp *rsp = [MainRsp mj_objectWithKeyValues:localDictionary];
        self.mainRsp = rsp;

        [self.mainCollectionView reloadData];

    }
  
    WS(weakSelf)
    [self.leftCityBtn setTitle:[NSString stringWithFormat:@"  %@市",[PublicManager shareManager].selectCityModel.cityName] forState:UIControlStateNormal];

    [self getUserLocation];

    
    self.mainCollectionView.mj_header = [QuRefreshHeader headerWithRefreshingBlock:^{
        // 进入刷新状态就会回调这个Block
        [weakSelf getUserLocation];
        
    }];
    
    //检查更新,7天后调用检查更新
    NSString *todayString = [NSString swithDate:[NSDate date] toFormatDate:@"yyyyMMdd"];
    NSString *sevenString = [PublicManager getVersionAlertDateFromLocal];
    if (sevenString.trim.length > 0) {
        
        if ([todayString isEqualToString:sevenString]) {
            [self requestAppVersionCheck];
        }
    }
    else{
        [self requestAppVersionCheck];
    }

    //获取引导图,wifi状态下请求接口
    [self monitorNetworkingWithWWANBlock:^{
        
    } wifiBlock:^{
        
        [self requestGuideImagePage];
    }];

    //添加渐变
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 130);
    [self.bottomView.layer addSublayer:gradientLayer];
    
    [self.bottomInputView showShadowColorWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.15] offset:CGSizeMake(0, 5) opacity:1 radius:5.0];
    [self.bottomInputView setCornerRadius:27.0f AndBorder:0 borderColor:nil];
    
    //地图检索初始化
    self.mapSearcher = [[AMapSearchAPI alloc] init];
    self.mapSearcher.delegate = self;

    if (![PublicManager shareManager].isShowVoice) {
        
        self.bottomInputView.alpha = 0;
        self.bottomView.alpha = 0;
        self.ticketBottomConstraint.constant = 20;
        
    }
    else{
        
        self.bottomInputView.alpha = 1;
        self.bottomView.alpha = 1;
        self.ticketBottomConstraint.constant = 75;
    }
    [self initScrollSearchView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (ACCOUNTINFO.isLogin) {
        
        if (ACCOUNTINFO.userInfo.headImg.length > 0) {
            [self.leftHeadImageView sd_setImageWithURL:[NSURL URLWithString:ACCOUNTINFO.userInfo.headImg] placeholderImage:[UIImage imageNamed:@"person_default_head"] options:SDWebImageRefreshCached];
        }
        
        [self.leftNameLabel setText:ACCOUNTINFO.userInfo.nickName];
        [self requestIsTicket];
        
        [self requestIsNewMsg];
    }
    else{
        [self.ticketBtn setHidden:YES];
        [self.messageBtn clearBadge];

    }
    
    if (!self.isShowLeft) {
        self.showStatusBar = YES;
    }
    else{
        self.showStatusBar = NO;
    }
    [self.mainCollectionView reloadData];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.showStatusBar = YES;
}

- (void)setStarTip:(AMapTip *)starTip
{
    _starTip = starTip;
    
    self.blurStartTextField.text = starTip.name;
    self.scrollStartTextField.text = starTip.name;
 
    MainBannerCell *cell = (MainBannerCell *)[self.mainCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    cell.startTextField.text = starTip.name;
}

- (void)setEndTip:(AMapTip *)endTip
{
    _endTip = endTip;
    
    self.blurEndTextField.text = endTip.name;
    self.scrollEndTextField.text = endTip.name;
    
    MainBannerCell *cell = (MainBannerCell *)[self.mainCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    cell.endTextField.text = endTip.name;
}

- (UIVisualEffectView *)blurEffectView
{
    if (!_blurEffectView) {
        UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurEffectView = [[UIVisualEffectView alloc]initWithEffect:beffect];
        _blurEffectView.frame = self.view.frame;
        [self.view addSubview:_blurEffectView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blurEffectTapAction:)];
        [gesture setDelegate:self];
        [self.bigSearchView addGestureRecognizer:gesture];
        
        [self.bigSearchView setFrame:_blurEffectView.frame];
        [_blurEffectView.contentView addSubview:self.bigSearchView];
        
        [self initBlurEffectSearchView];
    
    }
    return _blurEffectView;
}

- (void)initBlurEffectSearchView
{

    [self.blurSearchView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.blurSearchBtn showShadowColorWithColor:HEXCOLOR(@"ff5c41") offset:CGSizeMake(0, 3) opacity:0.5 radius:3.0];
    
    self.blurStartTextField.borderStyle = UITextBorderStyleNone;
    self.blurEndTextField.borderStyle = UITextBorderStyleNone;

    [self.blurSearchTableView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
}

- (void)initScrollSearchView
{
    
    [self.scrollSearchView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.scrollSearchBtn showShadowColorWithColor:HEXCOLOR(@"ff5c41") offset:CGSizeMake(0, 3) opacity:0.5 radius:3.0];
    [self.scrollSearchView showShadowColorWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.15] offset:CGSizeMake(0, 5) opacity:1 radius:5.0];
    
    self.scrollStartTextField.borderStyle = UITextBorderStyleNone;
    self.scrollEndTextField.borderStyle = UITextBorderStyleNone;

}

- (NSMutableArray *)mapAddressArray
{
    if (!_mapAddressArray) {
        _mapAddressArray = [[NSMutableArray alloc]init];
    }
    return _mapAddressArray;
}

- (void)setShowStatusBar:(BOOL)showStatusBar
{
    _showStatusBar = showStatusBar;
    
    if (showStatusBar) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
    else{
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

- (void)showMessageRedBadgeWithIsNew:(NSInteger)isNew
{
    if (isNew == 1) {
        
        [self.messageBtn showBadge];
        
        [self.messageBtn setBadgeBgColor:HEXCOLOR(@"ff5c41")];
        [self.messageBtn setBadgeCenterOffset:CGPointMake(-15, 15)];
        
    }
    else{
        [self.messageBtn clearBadge];
    
    }
}

#pragma mark Request
- (void)getUserLocation
{
    WS(weakSelf)
   
    [[QuLocationManager shareManager]startUpdatingLocationWithSuccess:^(AMapLocationReGeocode *lbsLocation) {
        
        [weakSelf requestMainDataWithCityCode:[PublicManager shareManager].selectCityModel.cityCode];
        
    } fail:^{
        
        [weakSelf requestMainDataWithCityCode:[PublicManager shareManager].selectCityModel.cityCode];
        
    }];
}

//自动登录
- (void)autoLoginRequestWithId:(NSString *)uid
{
    
    AutoLoginReq *req = [[AutoLoginReq alloc]init];
    req.userId = uid;

    [NetWorkReqManager requestDataWithApiName:autoLand params:req response:^(NSDictionary *responseObject) {
        
        AutoLoginRsp *rsp = [AutoLoginRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            ACCOUNTINFO.isLogin = YES;
            ACCOUNTINFO.userInfo = rsp.data;
            
            [JPUSHService setAlias:rsp.data.alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
                if (iResCode == 0) {
                    
                }
            } seq:0];
            
            if (ACCOUNTINFO.userInfo.headImg.length > 0) {
           
                [self.leftHeadImageView sd_setImageWithURL:[NSURL URLWithString:ACCOUNTINFO.userInfo.headImg]placeholderImage:[UIImage imageNamed:@"person_default_head"] options:SDWebImageRefreshCached];
            }
            
            [self.leftNameLabel setText:ACCOUNTINFO.userInfo.nickName];
            
            [self requestIsTicket];
            
            [self requestIsNewMsg];
        }
        
        
    } errorResponse:^(NSString *error) {
        
    }];
}

- (void)requestMainDataWithCityCode:(NSString *)cityCode
{

    MainReq *req = [[MainReq alloc]init];
    req.cityCode = cityCode;
    
    if ([QuLocationManager shareManager].longitude.length > 0) {
        req.longitude = [QuLocationManager shareManager].longitude;
        req.lat = [QuLocationManager shareManager].latitude;
    }
    else{
        req.longitude = @"";
        req.lat = @"";
    }
    
    [NetWorkReqManager requestDataWithApiName:openCityData params:req response:^(NSDictionary *responseObject) {
 
        MainRsp *rsp = [MainRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            self.mainRsp = rsp;

            [self.mainCollectionView reloadData];            
            [self.mainCollectionView layoutIfNeeded];
            //将最新数据保存本地
            [PublicManager saveMainDataToLocalWithDictionary:responseObject];

        }
        else{
            [QuLoadingHUD dismiss:rsp.message];
        }
        [self.mainCollectionView.mj_header endRefreshing];
        
        
    } errorResponse:^(NSString *error) {
        
        [QuLoadingHUD dismiss:error];
        [self.mainCollectionView.mj_header endRefreshing];
        
    }];
    
}

- (void)requestIsTicket
{
    IsTicketReq *req = [[IsTicketReq alloc]init];
    req.userId = ACCOUNTINFO.userInfo.memberID;
    
    [NetWorkReqManager requestDataWithApiName:isTicket params:req response:^(NSDictionary *responseObject) {
        
        IsTicketRsp *rsp = [IsTicketRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            if (rsp.data == 1) {
                
                [self.ticketBtn setHidden:NO];
            }
            else{
                [self.ticketBtn setHidden:YES];
            }
        }
        
    } errorResponse:^(NSString *error) {
        
        
        
    }];
    
    
}

- (void)requestIsNewMsg
{
    IsTicketReq *req = [[IsTicketReq alloc]init];
    req.userId = ACCOUNTINFO.userInfo.memberID;
    
    [NetWorkReqManager requestDataWithApiName:isNewMsg params:req response:^(NSDictionary *responseObject) {
        
        IsTicketRsp *rsp = [IsTicketRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            [self showMessageRedBadgeWithIsNew:rsp.data];
        }
        
    } errorResponse:^(NSString *error) {
        
        
        
    }];
    
    
}


- (void)requestServiceUrl
{
    BaseRequest *req = [[BaseRequest alloc]init];
    
    [NetWorkReqManager requestDataWithApiName:getLink params:req response:^(NSDictionary *responseObject) {
    
        ServiceLinkRsp *rsp = [ServiceLinkRsp mj_objectWithKeyValues:responseObject];

        if (rsp.code == 1 && rsp.data.linkUrl.length > 0) {
  
            BaseWebViewController *vc = [[BaseWebViewController alloc]init];
            vc.url = rsp.data.linkUrl;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    } errorResponse:^(NSString *error) {
   
    }];
}

- (void)requestCompanyLineShowWithModel:(MainRouteModel *)model
{
    [QuLoadingHUD loading];
    
    CheckCompanyLineReq *req = [[CheckCompanyLineReq alloc]init];
    req.userId = ACCOUNTINFO.userInfo.memberID;
    req.lineId = model.lineId;

    [NetWorkReqManager requestDataWithApiName:checkSpecialLine params:req response:^(NSDictionary *responseObject) {
        
        [QuLoadingHUD dismiss];
        
        BaseResponse *rsp = [BaseResponse mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            RouteDetailVC *vc = [[RouteDetailVC alloc]initWithNibName:@"RouteDetailVC" bundle:nil];
            vc.routeId = model.flightId;
            vc.upId = model.onTrainId;
            vc.downId = model.downTrainId;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            [QuHudHelper qu_showMessage:@"该线路为企业线路，您不是该企业成员，无法查看购买该线路"];
        }

        
    } errorResponse:^(NSString *error) {
        
        [QuLoadingHUD dismiss:error];

        
    }];
    
}

- (void)requestAppVersionCheck
{

    CheckAppVersionReq *req = [[CheckAppVersionReq alloc]init];
    req.appVersion = CLIENT_VERSION;
    req.appName = @"1";
    
    [NetWorkReqManager requestDataWithApiName:checkVersion params:req response:^(NSDictionary *responseObject) {
  
        CheckAppVersionRsp *rsp = [CheckAppVersionRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 10003) {
  
            //需要更新
            VersionAlertView *alertView = [[VersionAlertView alloc]initWithAlertTitle:rsp.data.appTitle message:rsp.data.appInstruct cancelHandler:^{
                
                NSDate *sevenDate = [[NSDate date] hyb_dateAfterDay:7];
                NSString *sevenString = [NSString swithDate:sevenDate toFormatDate:@"yyyyMMdd"];
            
                [PublicManager saveVersionAlertDateToLocalWithDateString:sevenString];
                
            } confirmHandler:^{
              
                NSDate *sevenDate = [[NSDate date] hyb_dateAfterDay:7];
                NSString *sevenString = [NSString swithDate:sevenDate toFormatDate:@"yyyyMMdd"];
                
                [PublicManager saveVersionAlertDateToLocalWithDateString:sevenString];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_APP_CHECK]];
            }];
            [alertView show];

        }
        else if (rsp.code == 1){
            
            //不需要更新
            [PublicManager removeVersionAlertDate];
        }

    } errorResponse:^(NSString *error) {

    }];
    
}

- (NSString *)getGuideRequestDeviceType
{
    switch ([UIDevice deviceModel]) {
   
        case iPhone5:{
            return @"2";
        }
            break;
            
        case iPhone6:{
            return @"3";
        }
            break;
            
        case iPhone6Plus:{
            return @"4";
        }
            break;
            
        case iPhoneX:{
            return @"5";
        }
            break;

        default:
            break;
    }
    return @"1";
}

- (void)requestGuideImagePage
{
    
    GetBootPageReq *req = [[GetBootPageReq alloc]init];
    req.sizeType = [self getGuideRequestDeviceType];
    req.type = @"1";
    
    NSString *guideVersion = [PublicManager getGuideVersionFromLocal];
    if (guideVersion.trim.length > 0) {
        req.version = guideVersion;
    }
    else{
        req.version = @"";
    }

    [NetWorkReqManager requestDataWithApiName:getBootPage params:req response:^(NSDictionary *responseObject) {

        GetBootPageRsp *rsp = [GetBootPageRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 10003) {

            if (rsp.data.version.trim.length > 0) {
                [PublicManager saveGuideVersionToLocalWithVersion:rsp.data.version];
            }
            
            if (rsp.data.pagePicArr.count > 0) {
            
                for (NSString *imageUrl in rsp.data.pagePicArr) {
                    
                    [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                        
                    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                        if (image) {
                            
                            [[SDWebImageManager sharedManager].imageCache storeImage:image forKey:[imageUrl stringByAppendingString:rsp.data.version] toDisk:YES completion:^{
                                
                            }];
                        }
                    }];
                }
                [PublicManager saveGuideImageArrayToLocalWithVersion:rsp.data.pagePicArr];
                [PublicManager saveShowGuideToLocalWithShow:YES];
            }
        }
        
    } errorResponse:^(NSString *error) {
        
    }];
    
}

#pragma mark gestureRecognizer
//个人信息编辑
-(void)event:(UIPanGestureRecognizer *)ges{
    MyInfoVC *vc= [[MyInfoVC alloc]initWithNibName:@"MyInfoVC" bundle:nil];
    self.showStatusBar = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)blurEffectTapAction:(UIPanGestureRecognizer *)ges
{
    [self.blurEffectView setHidden:YES];
    [self.blurStartTextField resignFirstResponder];
    [self.blurEndTextField resignFirstResponder];

}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:gesture.view];;
    
    switch (gesture.state){
            
        case UIGestureRecognizerStateBegan:{
            
            [self.leftView setFrame:CGRectMake(0, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
            self.bgBlackBtn.alpha = 0.3f;
        }
            
            break;
            
        case UIGestureRecognizerStateChanged:{
            
            if(translation.x > 0){
                
                [self.leftView setFrame:CGRectMake(0, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
                self.bgBlackBtn.alpha = 0.3f;
                
            }
            else if(translation.x < 0){
                
                [self.leftView setFrame:CGRectMake(translation.x, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
                self.bgBlackBtn.alpha = 0.3f;
                
            }
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            
            if (self.leftView.frame.origin.x < -90){
                
                [UIView animateWithDuration:0.2 animations:^(){
                    [self.leftView setFrame:CGRectMake(-CATEGORYWIDTH, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
                    
                    self.bgBlackBtn.alpha = 0.0f;
                    
                    self.showStatusBar = YES;
                    self.isShowLeft = NO;
                    
                }completion:^(BOOL finished){
                    
                }];
            }
            else{
                
                [UIView animateWithDuration:0.2 animations:^(){
                    [self.leftView setFrame:CGRectMake(0, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
                    
                    self.bgBlackBtn.alpha = 0.3f;
                    
                    self.showStatusBar = NO;
                    self.isShowLeft = YES;
                    
                }completion:^(BOOL finished){
                    
                }];
            }
            
            [gesture setTranslation:CGPointMake(0, 0) inView:self.leftView];
            
            break;
        }
        default:
            break;
    }
    
}

#pragma mark Notification
- (void)tokenInvaildNotification:(NSNotification *)notify
{
    [self dismissLeftView];
}

- (void)showVoiceNotification:(NSNotification *)notify
{
    NSString *show = (NSString *)notify.object;

    if ([@"0" isEqualToString:show]) {
        
        self.bottomInputView.alpha = 0;
        self.bottomView.alpha = 0;
        self.ticketBottomConstraint.constant = 20;
        
    }
    else{
        
        self.bottomInputView.alpha = 1;
        self.bottomView.alpha = 1;
        self.ticketBottomConstraint.constant = 75;
    }

}

#pragma mark btnClickAction
- (IBAction)titleClickAction:(id)sender
{
    WS(weakSelf)
    CitySelectVC *vc = [[CitySelectVC alloc]initWithNibName:@"CitySelectVC" bundle:nil];
    vc.selectCityBlock = ^(QuCityModel *model) {
        
        [weakSelf.leftCityBtn setTitle:[NSString stringWithFormat:@"  %@",model.cityName] forState:UIControlStateNormal];
        [weakSelf requestMainDataWithCityCode:model.cityCode];
    };
    self.showStatusBar = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)leftBarButtonItemAction:(id)sender
{
    if (!ACCOUNTINFO.isLogin) {
        [self presentLoginWithComplection:nil];
        return;
    }
    
    [self showLeftView];
}

- (void)rightBarButtonItemAction:(id)sender
{
    if (!ACCOUNTINFO.isLogin) {
        [self presentLoginWithComplection:nil];
        return;
    }
    MessageVC *vc = [[MessageVC alloc]initWithNibName:@"MessageVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)categoryBackAction:(UIButton *)sender
{
    [self dismissLeftView];
}

- (IBAction)endStationClickAction:(UIButton *)sender
{

    if (self.starTip) {
        
        EndSiteVC *vc = [[EndSiteVC alloc]initWithNibName:@"EndSiteVC" bundle:nil];
        vc.starTip = self.starTip;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [QuHudHelper qu_showMessage:@"请输入起始地"];
    }
    
    [PublicManager trackALCustomHitBuildWithEventLabel:@"click_app_qyc_home1page_destination" controller:self];
}

- (IBAction)blurExchangeClickAction:(id)sender
{

    AMapTip *startTip = self.starTip;
    AMapTip *endTip = self.endTip;
    
    self.starTip = endTip;
    self.endTip = startTip;

}

- (IBAction)scrollExchangeClickAction:(id)sender
{

    AMapTip *startTip = self.starTip;
    AMapTip *endTip = self.endTip;
    self.starTip = endTip;
    self.endTip = startTip;

}
 - (IBAction)blurSearchClickAction:(UIButton *)sender
{
    if (!self.starTip) {
        [QuHudHelper qu_showMessage:@"请输入起始地"];
        return ;
    }
    if (!self.endTip) {
        [QuHudHelper qu_showMessage:@"请输入目的地"];
        return ;
    }
    if ([self.starTip.name isEqualToString:self.endTip.name]) {
        [QuHudHelper qu_showMessage:@"起始地和目的地不能相同"];
        return ;
    }
    [self blurEffectTapAction:nil];
    
    LineSearchVC *vc = [[LineSearchVC alloc]initWithNibName:@"LineSearchVC" bundle:nil];

    vc.starTip = self.starTip;
    vc.endTip = self.endTip;

    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)voiceClickAction:(UIButton *)sender
{
 
    VoiceSearchVC *vc = [[VoiceSearchVC alloc]initWithNibName:@"VoiceSearchVC" bundle:nil];
    
    if (self.starTip.name.length <= 0) {
        [QuHudHelper qu_showMessage:@"请输入起始地"];
        return;
    }
    vc.starTip = self.starTip;
    [self.navigationController pushViewController:vc animated:YES];
    
    [PublicManager trackALCustomHitBuildWithEventLabel:@"click_app_qyc_home1page_voice" controller:self];
}

- (void)showLeftView
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        
        self.leftView.frame = CGRectMake(0, 0, CATEGORYWIDTH, SCREEN_HEIGHT);
        self.bgBlackBtn.alpha = 0.3f;
        
        
    } completion:^(BOOL finished){
        
    }];
    self.showStatusBar = NO;
    self.isShowLeft = YES;
    
}

- (void)dismissLeftView
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        
        self.leftView.frame = CGRectMake(-CATEGORYWIDTH, 0, CATEGORYWIDTH, SCREEN_HEIGHT);
        self.bgBlackBtn.alpha = 0.0f;
        
    } completion:^(BOOL finished){
        
    }];
    
    self.showStatusBar = YES;
    self.isShowLeft = NO;
}
//扫码验票
- (IBAction)sweepCodeBtnClick:(id)sender {
    BuyTicketListVC *vc = [[BuyTicketListVC alloc]initWithNibName:@"BuyTicketListVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
 
    [PublicManager trackALCustomHitBuildWithEventLabel:@"click_app_qyc_home1page_tickets" controller:self];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.leftTableView) {
        return [self.leftArray count];
    }
    return [self.mapAddressArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftTableView) {
        return 54.0f;
    }
    return 60.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        
        MainLeftCateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainLeftCateCell"];
        
        LocalDataModel *listModel = self.leftArray[indexPath.row];
        cell.cateLabel.text = listModel.name;
        [cell.cateImageView setImage:[UIImage imageNamed:listModel.imageName]];
        
        
        return cell;
    }
    else{
        
        MainSiteSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainSiteSearchCell"];
   
        AMapTip *poi = [self.mapAddressArray objectAtIndex:[indexPath row]];
        [cell.nameLabel setText:poi.name];
        [cell.addressLabel setText:poi.address];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.leftTableView) {
        LocalDataModel *model = self.leftArray[indexPath.row];
        
        switch (model.sign) {
            case 0:{
                //行程
                if (!ACCOUNTINFO.isLogin) {
                    [self presentLoginWithComplection:nil];
                    return;
                }
                JourneyViewController *vc = [[JourneyViewController alloc]initWithNibName:@"JourneyViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
                
            case 1:{
                //钱包
                if (!ACCOUNTINFO.isLogin) {
                    [self presentLoginWithComplection:nil];
                    return;
                }
                MyWalletVC *vc = [[UIStoryboard storyboardWithName:@"PersonCenter" bundle:nil]instantiateViewControllerWithIdentifier:@"MyWalletVC"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 2:{
                //客服
                [self requestServiceUrl];
                
            }
                break;
                
            case 3:{
                //设置
                SettingVC *vc = [[UIStoryboard storyboardWithName:@"PersonCenter" bundle:nil]instantiateViewControllerWithIdentifier:@"SettingVC"];
                vc.loginoutBlock = ^{
                    
                    [self dismissLeftView];
                };
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }
                break;
                
            default:
                break;
        }
        
        self.showStatusBar = YES;
        

    }
    else{
        
        AMapTip *tip = [self.mapAddressArray objectAtIndex:[indexPath row]];
        
        if ([self.blurStartTextField isFirstResponder]) {
            
            [self.blurStartTextField setText:tip.name];
            self.starTip = tip;
        }
        else{
            [self.blurEndTextField setText:tip.name];
            self.endTip = tip;
        }
        [self.blurSearchTableView setHidden:YES];
        [self.mainCollectionView reloadData];
       
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UICollectionViewDatasource/UICollectionViewDelegate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSInteger count = 1;
    
    if (section == 0 || section == 1) {
        count = 1;
    }
    else{
        
        if (self.mainRsp.data1.count > 0) {
            count = self.mainRsp.data1.count;
        }
        else{
            count = 1;
        }
        
    }
    
    return count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 3;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    
    if (indexPath.section == 0) {
        static NSString *dIdentifier = @"MainBannerCell";
        __weak MainBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dIdentifier forIndexPath:indexPath];
        
        [cell addBannerWithData:self.mainRsp.banner clickBlock:^(MainBannerModel *itemModel) {
            
            NSString *jumpId = itemModel.bannerLink;
            [weakSelf jumpWithParams:jumpId];
            
            [PublicManager trackALCustomHitBuildWithEventLabel:@"click_app_qyc_home1page_banner" controller:self];
        }];
        
        cell.startTextField.text = self.starTip.name;
        cell.endTextField.text = self.endTip.name;
        
        //如果获取到用户位置
        if ([QuLocationManager shareManager].locationCityModel.cityCode > 0 && !self.starTip && !self.endTip) {
            cell.startTextField.text = [QuLocationManager shareManager].name;
            AMapTip *tip = [[AMapTip alloc]init];
            AMapGeoPoint *point = [[AMapGeoPoint alloc]init];
            point.longitude = [[QuLocationManager shareManager].longitude floatValue];
            point.latitude = [[QuLocationManager shareManager].latitude floatValue];
            tip.location = point;
            tip.name = [QuLocationManager shareManager].name;
            self.starTip = tip;
        }
        
        //如果查询过 自动查询上次匹配过的线路
        if ([[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@_AmapSiteSearch",ACCOUNTINFO.userInfo.memberID]]) {
            
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@_AmapSiteSearch",ACCOUNTINFO.userInfo.memberID]];
            
            StarAndEndMOdel *model =[[StarAndEndMOdel alloc]initWithDic:dic];
            
            if (self.endTip == nil) {
                //没有切换起始地目的地
                cell.startTextField.text = [NSString judgeIsEmptyWithString:model.starName]?@"":model.starName;
                cell.endTextField.text = [NSString judgeIsEmptyWithString:model.endName]?@"":model.endName;
                //起始站点Tip
                AMapTip *tip = [[AMapTip alloc]init];
                AMapGeoPoint *point = [[AMapGeoPoint alloc]init];
                tip.name = model.starName;
                point.longitude = [model.startLongitude floatValue];
                point.latitude = [model.startLat floatValue];
                tip.location = point;
                
                self.starTip = tip;
                
                //结束站点Tip
                AMapTip *endTip = [[AMapTip alloc]init];
                AMapGeoPoint *endPoint = [[AMapGeoPoint alloc]init];
                endTip.name = model.endName;
                endPoint.longitude = [model.endLongitude floatValue];
                endPoint.latitude = [model.endLat floatValue];
                endTip.location = endPoint;
                self.endTip = endTip;
                
            }
            
            
        }
        
        cell.routeSearchBlock = ^(NSString *start, NSString *end ,NSInteger invertSelection) {
            
            // [self goSearchSite:cell];//1.1.0.3 检索站点
            if (cell.startTextField.text.length <= 0) {
                [QuHudHelper qu_showMessage:@"请输入起始地"];
                return ;
            }
            if (cell.endTextField.text.length <= 0) {
                [QuHudHelper qu_showMessage:@"请输入目的地"];
                return ;
            }
            if ([self.starTip.name isEqualToString:_endTip.name]) {
                [QuHudHelper qu_showMessage:@"起始地和目的地不能相同"];
                return ;
            }
            LineSearchVC *vc = [[LineSearchVC alloc]initWithNibName:@"LineSearchVC" bundle:nil];
          
            //没有切换起始地目的地
            vc.starTip = self.starTip;
            vc.endTip = self.endTip;
    
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        cell.routeEditBlock  = ^(NSString *start, NSString *end,NSInteger from) {
       
            [weakSelf.blurEffectView setHidden:NO];
            [weakSelf.blurStartTextField setText:cell.startTextField.text];
            [weakSelf.blurEndTextField setText:cell.endTextField.text];
        
            if (from == 1) {
                //出发站点检索
                [weakSelf.blurStartTextField becomeFirstResponder];

            }else{
                
                [weakSelf.blurEndTextField becomeFirstResponder];

            }
         
            [PublicManager trackALCustomHitBuildWithEventLabel:@"click_app_qyc_home1page_searchview" controller:self];
        };
        
        cell.routeExchangeBlock = ^{
            
            AMapTip *startTip = weakSelf.starTip;
            AMapTip *endTip = weakSelf.endTip;
            
            weakSelf.starTip = endTip;
            weakSelf.endTip = startTip;
 
//            cell.startTextField.text = weakSelf.starTip.name;
//            cell.endTextField.text = weakSelf.endTip.name;


        };

        return cell;
    }
    else if (indexPath.section == 1){
        static NSString *bIdentifier = @"MainChannelCell";
        MainChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bIdentifier forIndexPath:indexPath];

//        if (self.mainRsp.isOpen == 0) {
            [cell.nameLabel setHidden:YES];
            [cell.iconImageView setHidden:YES];
//        }
//        else{
//            [cell.nameLabel setHidden:NO];
//            [cell.iconImageView setHidden:NO];
//        }

        
        return cell;
    }
    else {
        
        if (self.mainRsp.data1.count > 0) {
            
            static NSString *cIdentifier = @"MainBusRouteCell";
            MainBusRouteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cIdentifier forIndexPath:indexPath];
            
            MainRouteModel *model = [self.mainRsp.data1 objectAtIndex:indexPath.item];
            
            if ([@"4" isEqualToString:model.carType]) {
                [cell.carTypeLabel setText:@"通勤"];
            }
            else{
                [cell.carTypeLabel setText:@"摆渡"];
            }
            if (model.startSiteType == 1) {
                
                [cell.startCompanyImageView setHidden:NO];
            }
            else{
                [cell.startCompanyImageView setHidden:YES];
            }
            
            if (model.endSiteType == 1) {
                [cell.endCompanyImageView setHidden:NO];
            }
            else{
                [cell.endCompanyImageView setHidden:YES];
            }
            
            if (model.companyLineType == 1) {
                
                [cell.carTypeLabel setText:@"专线"];
            }
     
            [cell.timeLabel setText:[NSString stringWithFormat:@"运行时间 %@",model.flightDateStr]];
            [cell.upNameLabel setText:model.onTrainName];
            [cell.downNameLabel setText:model.downTrainName];
            
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:model.price];
            
            NSAttributedString *tempAttributeString = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
            [attributeString appendAttributedString:tempAttributeString];
            
            cell.priceLabel.attributedText = attributeString;
            
            return cell;
        }
        else{
            
            static NSString *cIdentifier = @"MainNoneRouteCell";
            MainNoneRouteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cIdentifier forIndexPath:indexPath];
            
            return cell;
        }
        
    }
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 2) {
            
            MainRouteRecommandView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainRouteRecommandView" forIndexPath:indexPath];
            
            if (self.mainRsp.data1.count > 0) {
            
                [headerView.nameLabel setText:@"巴士线路推荐"];
            }
            else{
                [headerView.nameLabel setText:@"暂无巴士推荐"];
            }
            
            reusableview = headerView;
        }
        
        
    }
    
    return reusableview;
}

//pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (self.mainRsp.banner.bannerList.count > 0) {
            
            if (self.mainRsp.banner.bannerThan > 0) {
                
                return CGSizeMake(SCREEN_SIZE.width, SCREEN_WIDTH * self.mainRsp.banner.bannerThan + 100);
            }
            else{
                return CGSizeMake(SCREEN_SIZE.width, ScreenWidthRatio * 130 + 100);
            }
            
        }
        else{
            return CGSizeMake(SCREEN_SIZE.width, ScreenWidthRatio * 0.1 + 130);
        }
    }
    else if (indexPath.section == 1){
        
        if (self.mainRsp.isOpen == 1) {

            return CGSizeMake(SCREEN_SIZE.width - 20, 0.1);

        }
        else{
            return CGSizeMake(SCREEN_SIZE.width - 20, 0.1);
        }
        
    }
    else {
        
        if (self.mainRsp.data1.count > 0) {
            
            return CGSizeMake(SCREEN_SIZE.width - 20, 105);
        }
        else{
            return CGSizeMake(SCREEN_SIZE.width, 480);
        }
    }
    
    return CGSizeMake(0, 0);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2){
        
        return UIEdgeInsetsMake(0, 10, 10, 10);
    }
    else if (section == 1){
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
    return 0;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 2 && self.mainRsp.data1.count == 0) {
 
        return CGSizeMake(SCREEN_SIZE.width, 20);

    }
    
    return CGSizeMake(0, 0);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        
        BaseWebViewController *vc = [[BaseWebViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2) {

        if (self.mainRsp.data1.count > 0) {
            MainRouteModel *model = [self.mainRsp.data1 objectAtIndex:indexPath.item];
            
            if (model.companyLineType == 0) {
                
                RouteDetailVC *vc = [[RouteDetailVC alloc]initWithNibName:@"RouteDetailVC" bundle:nil];
                vc.routeId = model.flightId;
                vc.upId = model.onTrainId;
                vc.downId = model.downTrainId;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
       
                if (!ACCOUNTINFO.isLogin) {
                    
                    [CHAlertView showCHAlertViewWithTitle:@"提示" message:@"该线路为企业线路，若您是企业员工请您登录后查看购买" cancleButtonTitle:@"暂不登录" okButtonTitle:@"立即登录" okClickHandle:^{
                        
                        [self presentLoginWithComplection:nil];
                        
                    } cancelClickHandle:^{
                        
                    }];
                    
                }
                else{
                    [self requestCompanyLineShowWithModel:model];
                }
                
               
            }

        }
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.mainCollectionView) {
        
        self.startScrollOffset = scrollView.contentOffset.y;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.mainCollectionView) {

        CGFloat yOffset  = scrollView.contentOffset.y;
        if ([PublicManager shareManager].isShowVoice) {
 
            if (yOffset > 0) {
                if (yOffset < self.startScrollOffset) {
                    
                    [UIView animateWithDuration:0.2f animations:^{
                        
                        self.bottomInputView.alpha = 1;
                        self.bottomView.alpha = 1;
                        self.ticketBottomConstraint.constant = 75;
                        [self.view layoutIfNeeded];
                    }];
                    
                }
                else {
                    
                    [UIView animateWithDuration:0.2f animations:^{
                        
                        self.bottomInputView.alpha = 0;
                        self.bottomView.alpha = 0;
                        self.ticketBottomConstraint.constant = 20;
                        
                        [self.view layoutIfNeeded];
                    }];
                    
                }
            }
            else{
                
                [UIView animateWithDuration:0.2f animations:^{
                    
                    self.bottomInputView.alpha = 1;
                    self.bottomView.alpha = 1;
                    self.ticketBottomConstraint.constant = 75;
                    [self.view layoutIfNeeded];
                }];
            }

        }
        
        CGFloat scrollOffset = 0;
        if (self.mainRsp.banner.bannerList.count > 0) {
            
            if (self.mainRsp.banner.bannerThan > 0) {
                
                scrollOffset = SCREEN_WIDTH * self.mainRsp.banner.bannerThan - 30;
                
            }
            else{
                
                scrollOffset = ScreenWidthRatio * 130 - 30;
            }
            
        }
        else{
            scrollOffset = 100;
        }
        
        if (yOffset >= scrollOffset) {

            [self.scrollSearchView setHidden:NO];

        }
        else{
            [self.scrollSearchView setHidden:YES];
        }

    }
}

#pragma mark UITextFieldDelegate
//地址正在编辑中
- (IBAction)addressTfValueChange:(UITextField *)sender {
 
    //配置搜索参数
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = sender.text;
    tips.city = [PublicManager shareManager].selectCityModel.cityName;
    tips.cityLimit = YES; //是否限制城市
    [self.mapSearcher AMapInputTipsSearch:tips];
  
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.scrollStartTextField) {
        [self.blurEffectView setHidden:NO];
        [self.blurStartTextField setText:self.scrollStartTextField.text];
        [self.blurEndTextField setText:self.scrollEndTextField.text];
      
        //出发站点检索
        [self.blurStartTextField becomeFirstResponder];
     
        [PublicManager trackALCustomHitBuildWithEventLabel:@"click_app_qyc_home1page_searchview" controller:self];
        
    }
    else if (textField == self.scrollEndTextField) {
        
        [self.blurEffectView setHidden:NO];
        [self.blurStartTextField setText:self.scrollStartTextField.text];
        [self.blurEndTextField setText:self.scrollEndTextField.text];
        //结束站点检索
        [self.blurEndTextField becomeFirstResponder];
        
        [PublicManager trackALCustomHitBuildWithEventLabel:@"click_app_qyc_home1page_searchview" controller:self];
    }
    
    
    return NO;
}

#pragma mark AMapSearchDelegate
/**
 * @brief 输入提示查询回调函数
 * @param request  发起的请求，具体字段参考 AMapInputTipsSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapInputTipsSearchResponse 。
 */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response{
    [self.mapAddressArray removeAllObjects];
    [self.mapAddressArray addObjectsFromArray:response.tips];
    
    if (response.tips.count > 0) {
        
        [self.blurSearchTableView setHidden:NO];
        
        if (response.tips.count >= 3) {
            
            self.blurHeightConstraint.constant = 180.0f;
        }
        else{
            self.blurHeightConstraint.constant = 60 * response.tips.count;
        }
        
    }
    else{
        [self.blurSearchTableView setHidden:YES];
    }

    [self.blurSearchTableView reloadData];
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
