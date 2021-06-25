//
//  UITextViewTool.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/28.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITextViewTool;

@protocol UITextViewToolDelegate <NSObject>

- (void)toolTextViewDidChange:(NSString *)text;

@end

@interface UITextViewTool : UITextView

@property (nonatomic, weak) id<UITextViewToolDelegate>toolDelegate;

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, assign) NSInteger maxCount;

@end
