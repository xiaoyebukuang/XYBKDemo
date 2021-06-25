//
//  BaseWebviewViewController.m
//  changxiche
//
//  Created by 陈晓 on 2021/6/25.
//

#import "BaseWebviewViewController.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "PayOrderModel.h"
@interface BaseWebviewViewController ()

@property (nonatomic, assign) BOOL prepareToPay;

@end

@implementation BaseWebviewViewController
- (void)dealloc {
    if (self.payWebView) {
        [self.payWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"URL"];
    if (@available(iOS 13.0, *)) {
       [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
       [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.layer.opacity = 1;
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progressView.layer.bounds = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 2);
        if ([change[@"new"] floatValue] == 1) {
            [self loadFinish];
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        self.titleLabel.text = self.webView.title;
        self.navigationItem.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"URL"]) {
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)loadFinish {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.progressView.layer.opacity = 0;
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.progressView.layer.bounds = CGRectMake(0, 0, 0, 2);
    });
}
- (void)applicationBecomeActive {
    if (self.prepareToPay) {
        self.prepareToPay = NO;
        [self.webView reload];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadUrlStringWithUrlString:self.urlString];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (void)setupUI {
    CGFloat state_height = self.showStateView?NAV_BAR_HEIGHT:0;
    self.stateView.hidden = !self.showStateView;
    [self.view addSubview:self.stateView];
    [self.stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.view);
        make.height.mas_equalTo(state_height);
    }];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.top.equalTo(self.stateView.mas_bottom);
    }];
    [self.view addSubview:self.progressView];
    self.progressView.top = state_height;
}
- (void)loadUrlStringWithUrlString:(NSString *)urlString {
    if (!urlString) {
        return;
    }
    urlString = [NSString getChineseCodingUrlWithUrlString:urlString];
    NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    [self.webView loadRequest:webRequest];
}
#pragma mark -- event
- (void)closeBtnEvent {
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark -- WKNavigationDelegate,WKUIDelegate
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (![self.webView canGoBack]) {
        WeakSelf;
//        [CommonInfoView showInfoViewSuperView:self.view commonInfoType:CommonInfoNetworkNone commonInfoBlock:^(CommonInfoView * _Nonnull infoView) {
//            [weakSelf.webView reload];
//        }];
    }
}
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if(!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"urlStr =================== %@",urlStr);
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
//    BOOL isExist = NO;
//    NSArray *jumpArray = @[@"tel:",
//                           @"itunes.apple.com://",
//                           @"apps.apple.com://",
//                           @"itms-apps://",
//                           @"itms-appss://",
//                           @"itunes.apple.com://",
//                           @"tbopen://",
//                           @"taobao://",
//                           @"openApp.jdMobile://",
//                           @"openapp.jdmobile://",
//                           @"baidumap://",
//                           @"iosamap://",
//                           @"qqmap://"];
//    for (NSString *schem in jumpArray) {
//        if ([urlStr containsString:schem]) {
//            isExist = YES;
//            break;;
//        }
//    }
//    if (isExist) {
//        [UIDevice openURLStr:urlStr];
//        actionPolicy = WKNavigationActionPolicyCancel;
//    } else {
//        /** 是否是微信订单 */
//        BOOL isWeixinOrder = NO;
//        if (self.payWebView != webView) {
//            isWeixinOrder = [PayOrderModel checkIsWeixinOrderWithUrlStr:urlStr];
//            if (isWeixinOrder) {
//                if (self.payWebView) {
//                    [self.payWebView removeObserver:self forKeyPath:@"estimatedProgress"];
//                    [self.payWebView removeFromSuperview];
//                    self.payWebView = nil;
//                }
//                self.payWebView = [[WKWebView alloc]init];
//                self.payWebView.navigationDelegate = self;
//                self.payWebView.UIDelegate = self;
//                [self.payWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//                [self.view addSubview:self.payWebView];
//                [PayOrderModel gotoWeixinPay:self.payWebView decidePolicyForNavigationAction:navigationAction urlStr:urlStr];
//            }
//        }
//        if (isWeixinOrder) {
//            actionPolicy = WKNavigationActionPolicyCancel;
//        }
//        /** 是否去支付 */
//        BOOL toPay = [PayOrderModel checkToPayOrderWithWebView:webView urlStr:urlStr];
//        if (toPay) {
//            self.prepareToPay = toPay;
//            actionPolicy = WKNavigationActionPolicyCancel;
//        }
//    }
    decisionHandler(actionPolicy);
}
#pragma mark -- setup
- (UIView *)stateView {
    if (!_stateView) {
        UIView *stateV = [[UIView alloc]init];
        stateV.backgroundColor = [UIColor color_FFFFFF];
        UIButton *closeBtn = [UIButton buttonWithImage:@"nav_close_btn"];
        [closeBtn addTarget:self action:@selector(closeBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        [stateV addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(stateV);
            make.top.equalTo(stateV).mas_offset(NAV_STA_HEIGHT);
            make.width.height.mas_equalTo(44);
        }];
        [stateV addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(stateV);
            make.centerY.equalTo(closeBtn);
        }];
        _stateView = stateV;
    }
    return _stateView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithTextColor:[UIColor color_222222] font:SYSTEM_FONT_B_18];
    }
    return _titleLabel;
}
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc]init];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.backgroundColor = [UIColor color_FFFFFF];
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        [_webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _webView;
}
- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, 0, 2)];
        _progressView.backgroundColor = [UIColor color_FF712C];
    }
    return _progressView;
}

@end
