//
//  UIPanScrollView.m
//  cwz51
//
//  Created by 陈晓 on 2018/12/9.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIPanScrollView.h"

@implementation UIPanScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSInteger indexOff = ((NSInteger)point.x)%((NSInteger)self.width);
    if (indexOff > 0 && indexOff < 20) { // location.x为系统的某个点的x
        return nil;
    } else {
        return [super hitTest:point withEvent:event];
    }
}
@end
