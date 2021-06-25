//
//  BaseWebviewViewController.h
//  changxiche
//
//  Created by 陈晓 on 2021/6/25.
//

#import "BaseMultiViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseWebviewViewController : BaseMultiViewController<WKNavigationDelegate,WKUIDelegate>
/** 伪装状态栏 */
@property (nonatomic, strong) UIView *stateView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL showStateView;
/** 进度条 */
@property (nonatomic, strong) UIView *progressView;
/** webView */
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong, nullable) WKWebView *payWebView;

/** 加载url */
@property (nonatomic, copy) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
