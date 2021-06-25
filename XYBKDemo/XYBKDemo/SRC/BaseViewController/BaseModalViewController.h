//
//  BaseModalViewController.h
//  cwz51
//
//  Created by 陈晓 on 2020/11/10.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseModalViewController : BaseViewController

/** 点击背景是否消失，默认YES */
@property (nonatomic, assign) BOOL clickWillDismiss;
/** 背景 */
@property (nonatomic, strong) UIControl *backControl;

/** 将要推出视图 */
+ (void)preparePushVCWithVC:(UIViewController *)controller childViewController:(BaseModalViewController *)childViewController completion:(void (^ __nullable)(void))completion ;

- (void)pushVCWithAnimation:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;

- (void)popVCWithAnimation:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
