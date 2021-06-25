//
//  XYAnimatedImageView.h
//  cwz51
//
//  Created by 陈晓 on 2020/11/5.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "FLAnimatedImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYAnimatedImageView : FLAnimatedImageView

@property (nonatomic, assign) BOOL downLoadSuc;

@property (nonatomic, copy) NSString *xy_imageUrlStr;

- (void)setXy_imageURL:(NSURL *)xy_imageURL;

@end

NS_ASSUME_NONNULL_END
