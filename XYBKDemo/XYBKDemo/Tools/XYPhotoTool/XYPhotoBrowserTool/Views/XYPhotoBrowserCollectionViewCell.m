//
//  XYPhotoBrowserCollectionViewCell.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoBrowserCollectionViewCell.h"

@implementation XYPhotoBrowserCollectionViewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self.contentView addSubview:self.photoBrowserScrollView];
}
- (void)reloadViewWithPhotosArr:(NSArray *)photosArr andIndexPath:(NSInteger)row {
    self.photoBrowserScrollView.model = photosArr[row];
}
#pragma mark -- setup
- (XYPhotoBrowserScrollView *)photoBrowserScrollView {
    if (!_photoBrowserScrollView) {
        _photoBrowserScrollView = [[XYPhotoBrowserScrollView alloc] initWithFrame:self.bounds];
        _photoBrowserScrollView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0,*)) {
            _photoBrowserScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _photoBrowserScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _photoBrowserScrollView;
}

@end
