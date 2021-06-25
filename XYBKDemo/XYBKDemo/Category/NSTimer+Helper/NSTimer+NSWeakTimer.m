//
//  NSTimer+NSWeakTimer.m
//  cwz51
//
//  Created by 陈晓 on 2021/4/29.
//  Copyright © 2021 XYBK. All rights reserved.
//

#import "NSTimer+NSWeakTimer.h"

@interface NSTimerWeakObject()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;


@end

@implementation NSTimerWeakObject

- (void)fire:(NSTimer *)timer {
    if (self.target) {
        if ([self.target respondsToSelector:self.selector]) {
            [self.target performSelector:self.selector withObject:timer.userInfo];
        }
    } else {
        [self.timer invalidate];
    }
}
@end

@implementation NSTimer (NSWeakTimer)
+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)ti
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)yesOrNo {
    NSTimerWeakObject *object = [[NSTimerWeakObject alloc]init];
    object.target =aTarget;
    object.selector = aSelector;
    object.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:object selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
    return object.timer;
}
@end
