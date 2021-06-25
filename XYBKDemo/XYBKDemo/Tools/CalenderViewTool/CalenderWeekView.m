//
//  CalenderWeekView.m
//  cwz51
//
//  Created by 陈晓 on 2019/6/5.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import "CalenderWeekView.h"

@implementation CalenderWeekView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor color_F8F8F8];
    }
    return self;
}
- (void)setWeekArray:(NSArray *)weekArray {
    _weekArray = weekArray;
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat count  = weekArray.count;
    CGFloat label_space = self.cellSpace;
    CGFloat label_y = 0;
    CGFloat label_x = label_space;
    CGFloat label_width = (self.width - 2*label_space)/count;
    CGFloat label_height = self.height;
    for (int i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(label_x, label_y, label_width, label_height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor     = [UIColor color_222222];
        label.font          = SYSTEM_FONT_12;
        label.text          = weekArray[i];
        [self addSubview:label];
        label_x += label_width;
    }
}

@end
