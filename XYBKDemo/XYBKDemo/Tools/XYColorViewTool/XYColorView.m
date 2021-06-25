//
//  XYColorView.m
//  cwz51
//
//  Created by 陈晓 on 2020/11/13.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "XYColorView.h"

@interface XYColorView()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end


@implementation XYColorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
}

- (void)setColors:(NSArray *)colors {
    self.gradientLayer.colors = colors;
}
- (void)setLocations:(NSArray *)locations {
    self.gradientLayer.locations = locations;
}
- (void)setStartPoint:(CGPoint)startPoint {
    self.gradientLayer.startPoint = startPoint;
}
- (void)setEndPoint:(CGPoint)endPoint {
    self.gradientLayer.endPoint = endPoint;
}
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = CGRectZero;
    }
    return _gradientLayer;
}

@end
