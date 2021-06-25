//
//  NSTimer+NSWeakTimer.h
//  cwz51
//
//  Created by 陈晓 on 2021/4/29.
//  Copyright © 2021 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSTimerWeakObject : NSObject

@end

@interface NSTimer (NSWeakTimer)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)ti
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)yesOrNo;

@end

NS_ASSUME_NONNULL_END
