//
//  XYGradientLabel.m
//  cwz51
//
//  Created by 陈晓 on 2020/11/25.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "XYGradientLabel.h"


@interface XYGradientLabel()

@property (nonatomic, strong) CATextLayer *textLayer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end

@implementation XYGradientLabel

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLayer.frame = self.bounds;
    self.gradientLayer.frame = self.bounds;
}
- (void)addGradientLabelWithTitle:(NSString *)title {
    [self.layer addSublayer:self.textLayer];
    [self.gradientLayer setMask:self.textLayer];
    [self.layer addSublayer:self.gradientLayer];
    self.textLayer.foregroundColor = self.textColor.CGColor;
    UIFont *font = self.font;
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef =CGFontCreateWithFontName(fontName);
    self.textLayer.font = fontRef;
    self.textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    self.textLayer.string = title;
}
- (CATextLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        _textLayer.alignmentMode = kCAAlignmentJustified;
        _textLayer.wrapped = YES;
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _textLayer;
}
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        [_gradientLayer setColors:[NSArray arrayWithObjects:
                                   (id)[[UIColor color_774510] CGColor],
                                   (id)[[UIColor color_CFA273] CGColor],
                                   (id)[[UIColor color_774510] CGColor],
                                   nil]];
        [_gradientLayer setLocations:[NSArray arrayWithObjects:
                                      [NSNumber numberWithFloat:0.0],
                                      [NSNumber numberWithFloat:0.5],
                                      [NSNumber numberWithFloat:1.0],
                                      nil]];
        [_gradientLayer setStartPoint:CGPointMake(0, 0)];
        [_gradientLayer setEndPoint:CGPointMake(1, 0)];
    }
    return _gradientLayer;
}
    

    
    
    


@end
