//
//  CalenderView.h
//  cwz51
//
//  Created by 陈晓 on 2019/6/5.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CalenderViewDelegate <NSObject>

- (void)selectDateWithDateStr:(NSString *)selectDateStr;

@end

@interface CalenderView : UIView

@property (nonatomic, weak)id<CalenderViewDelegate>delegate;

/**
 初始化
 
 @param frame frame
 @param startDay 开始月份日期 格式：2018-1-17
 @param endDay 结束月份日期 格式：2019-1-17
 @return nil
 */
- (instancetype)initWithFrame:(CGRect)frame startDay:(NSString *)startDay endDay:(NSString *)endDay;

/** 选中的时间 */
@property (nonatomic, copy) NSString *selectedDateStr;



@end

NS_ASSUME_NONNULL_END
