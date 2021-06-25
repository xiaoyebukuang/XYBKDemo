//
//  XYColorView.h
//  cwz51
//
//  Created by 陈晓 on 2020/11/13.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 渐变view */
@interface XYColorView : UIView

@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, strong) NSArray *locations;

@property (nonatomic) CGPoint startPoint;

@property (nonatomic) CGPoint endPoint;


@end

NS_ASSUME_NONNULL_END
