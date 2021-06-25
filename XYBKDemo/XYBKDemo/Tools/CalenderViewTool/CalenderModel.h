//
//  CalenderModel.h
//  cwz51
//
//  Created by 陈晓 on 2019/6/5.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalenderModel : NSObject
///是否是日期
@property (nonatomic, assign) BOOL isDate;
///是否可选择
@property (nonatomic, assign) BOOL canSelected;
///年
@property (nonatomic, copy) NSString *year;
///月
@property (nonatomic, copy) NSString *month;
///日
@property (nonatomic, copy) NSString *day;
///时间
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *dateStr;
///展示的日期
@property (nonatomic, copy) NSString *showDay;
///是否选中
@property (nonatomic, assign) BOOL isSelected;
/** 颜色 */
///选中颜色
@property (nonatomic, strong) UIColor *selectedColor;
///正常颜色
@property (nonatomic, strong) UIColor *normalColor;
///选中背景颜色
@property (nonatomic, strong) UIColor *selectedBGColor;
///正常的背景颜色
@property (nonatomic, strong) UIColor *normalBGColor;

@property (nonatomic, assign) BOOL scrollToThere;

@end

NS_ASSUME_NONNULL_END
