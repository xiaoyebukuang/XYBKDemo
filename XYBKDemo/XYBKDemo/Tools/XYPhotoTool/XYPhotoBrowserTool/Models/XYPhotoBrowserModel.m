

//
//  XYPhotoBrowserModel.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoBrowserModel.h"

@implementation XYPhotoBrowserModel

- (instancetype)initWithObj:(id)imageObj {
    self = [super init];
    if (self) {
        self.photoObj = imageObj;
    }
    return self;
}
- (void)setPhotoObj:(id)photoObj {
    _photoObj = photoObj;
    if ([photoObj isKindOfClass:[NSURL class]]) {
        self.photoURL = photoObj;
    }else if ([photoObj isKindOfClass:[UIImage class]]){
        self.photoImage = photoObj;
    }else if ([photoObj isKindOfClass:[NSString class]]){
        self.photoURLStr = photoObj;
    }else {
        NSAssert(true == true, @"您传入的类型有问题");
    }
}

@end
