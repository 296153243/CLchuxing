//
//  BaseWebViewController.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/11.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "BaseWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "WebViewJavascriptBridge.h"

@interface BaseWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *progressProxy;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@property (strong, nonatomic) WebViewJavascriptBridge *ocjsWebBridge;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWebView];

    //使用自定义导航栏
    CLNavigationBar *bar = [CLNavigationBar showCLNavigationBarWithController:self];
    self.clNavBar = bar;
    self.clNavBar.title = @"加载中";
 
    [self initNJKProgressBar];

    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clNavBar.leftView = leftBtn;

    if (self.url.trim.length > 0) {
        [self loadWebViewUrl];
    }
    
    [self initWebViewJavascriptBridge];

}

- (void)initWebView
{
    UIWebView *webView = [[UIWebView alloc]init];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
    
    if ([self.url contains:@"diditaxi"]) {
        
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-44);
            make.bottom.left.right.equalTo(self.view);
  
        }];
        webView.scrollView.scrollEnabled = NO;
    }
    else{
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            
        }];
    }
    
    self.webView = webView;
   
}

- (void)initNJKProgressBar
{
    
    NJKWebViewProgress *progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    self.webView.delegate = progressProxy;
    progressProxy.webViewProxyDelegate = self;
    progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect barFrame = CGRectMake(0, self.clNavBar.frame.size.height - progressBarHeight, self.clNavBar.frame.size.width, progressBarHeight);
    NJKWebViewProgressView *progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    self.progressView = progressView;
    self.progressProxy = progressProxy;

    [self.clNavBar addSubview:progressView];
}

- (void)initWebViewJavascriptBridge
{
    [WebViewJavascriptBridge enableLogging];
    
    WebViewJavascriptBridge *bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [bridge setWebViewDelegate:self.progressProxy];
    
    [bridge registerHandler:@"loginAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [self loadAppLoginWithJsFunction];
        responseCallback(@"Response from loginAction");
    }];
    
    [bridge registerHandler:@"shareAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        QuShareModel *model = [QuShareModel mj_objectWithKeyValues:data];
        [self loadAppShareWithModel:model];
        responseCallback(@"Response from shareAction");
    }];
    
    self.ocjsWebBridge = bridge;
}

- (void)leftBarButtonItemAction:(UIButton *)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)loadWebViewUrl
{
    if (ACCOUNTINFO.isLogin) {
        
        if ([self.url rangeOfString:@"?"].location == NSNotFound) {
            self.url = [NSString stringWithFormat:@"%@?userId=%@",self.url,ACCOUNTINFO.userInfo.memberID];
        }
        else{
            self.url = [NSString stringWithFormat:@"%@&userId=%@",self.url,ACCOUNTINFO.userInfo.memberID];
        }
    }
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSLog(@"webView loadUrl:%@",url);
    [self.webView loadRequest:request];
    
//    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
//    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
//    [self.webView loadHTMLString:appHtml baseURL:baseURL];
    
}

//OC JS Function
- (void)loadAppShareWithModel:(QuShareModel *)model
{
    WS(weakSelf)
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSString *type in model.platform) {
        switch ([type integerValue]) {
            case 1:{
                [array addObject:@(SSDKPlatformTypeSinaWeibo)];
            }
                break;
                
            case 2:{
                [array addObject:@(SSDKPlatformSubTypeWechatSession)];
            }
                break;
                
            case 3:{
                [array addObject:@(SSDKPlatformSubTypeWechatTimeline)];
            }
                break;
                
            case 4:{
                [array addObject:@(SSDKPlatformSubTypeQQFriend)];
            }
                break;
                
            case 5:{
                [array addObject:@(SSDKPlatformSubTypeQZone)];
            }
                break;
                
            case 6:{
                [array addObject:@(SSDKPlatformTypeSMS)];
            }
                break;
                
            default:
                break;
        }
    }

    model.platforms = [NSArray arrayWithArray:array];
    [QuShareView showShareWithModel:model success:^{
        
        [QuHudHelper qu_showMessage:@"分享成功"];
        [weakSelf.ocjsWebBridge callHandler:@"shareComplete" data:@{ @"code":@"1" }];
        
    } fail:^{
        
        [QuHudHelper qu_showMessage:@"分享失败"];
    }];
}

- (void)loadAppLoginWithJsFunction
{
    WS(weakSelf)
    [self presentLoginWithComplection:^{
        
        NSString *userId = ACCOUNTINFO.userInfo.memberID;
        [weakSelf.ocjsWebBridge callHandler:@"loginComplete" data:@{ @"userId":userId }];
    }];
}


#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
//    NSString *urlString = [request.URL absoluteString];
//    NSString *lowerUrlString  = [urlString lowercaseString];
//
//    if ([lowerUrlString contains:@"sharesdk"]) {
//        return ![[ShareSDKJSBridge sharedBridge] captureRequest:request webView:webView];
//    }
    return YES;

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
   
    [self.clNavBar setTitle:[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
