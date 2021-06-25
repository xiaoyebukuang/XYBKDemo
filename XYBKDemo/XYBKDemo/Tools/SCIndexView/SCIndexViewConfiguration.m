
#import "SCIndexViewConfiguration.h"

const NSUInteger SCIndexViewInvalidSection = NSUIntegerMax - 1;
const NSInteger SCIndexViewSearchSection = -1;

static inline UIColor *SCGetColor(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

@interface SCIndexViewConfiguration ()

@property (nonatomic, assign) SCIndexViewStyle indexViewStyle;  // 索引元素之间间隔距离

@end

@implementation SCIndexViewConfiguration

@synthesize indexViewStyle = _indexViewStyle;

+ (instancetype)configuration
{
    return [self configurationWithIndexViewStyle:SCIndexViewStyleDefault];
}

+ (instancetype)configurationWithIndexViewStyle:(SCIndexViewStyle)indexViewStyle
{
    UIColor *indicatorBackgroundColor, *indicatorTextColor;
    UIFont *indicatorTextFont;
    CGFloat indicatorHeight;
    switch (indexViewStyle) {
        case SCIndexViewStyleDefault:
        {
            indicatorBackgroundColor = [UIColor color_FF5400];
            indicatorTextColor = [UIColor color_FFFFFF];
            indicatorTextFont = [UIFont systemFontOfSize:14];
            indicatorHeight = 25;
        }
            break;
            
        case SCIndexViewStyleCenterToast:
        {
            indicatorBackgroundColor = SCGetColor(200, 200, 200, 0.8);
            indicatorTextColor = [UIColor whiteColor];
            indicatorTextFont = [UIFont systemFontOfSize:60];
            indicatorHeight = 120;
        }
            break;
            
        default:
            return nil;
            break;
    }
    
    return [self configurationWithIndexViewStyle:indexViewStyle
                        indicatorBackgroundColor:indicatorBackgroundColor
                              indicatorTextColor:indicatorTextColor
                               indicatorTextFont:indicatorTextFont
                                 indicatorHeight:indicatorHeight
                            indicatorRightMargin:25
                           indicatorCornerRadius:5
                        indexItemBackgroundColor:[UIColor clearColor]
                              indexItemTextColor:[UIColor color_222222]
                indexItemSelectedBackgroundColor:[UIColor clearColor]
                      indexItemSelectedTextColor:[UIColor color_FF712C]
                                 indexItemHeight:15
                            indexItemRightMargin:5
                                 indexItemsSpace:4];
}

+ (instancetype)configurationWithIndexViewStyle:(SCIndexViewStyle)indexViewStyle
                       indicatorBackgroundColor:(UIColor *)indicatorBackgroundColor
                             indicatorTextColor:(UIColor *)indicatorTextColor
                              indicatorTextFont:(UIFont *)indicatorTextFont
                                indicatorHeight:(CGFloat)indicatorHeight
                           indicatorRightMargin:(CGFloat)indicatorRightMargin
                          indicatorCornerRadius:(CGFloat)indicatorCornerRadius
                       indexItemBackgroundColor:(UIColor *)indexItemBackgroundColor
                             indexItemTextColor:(UIColor *)indexItemTextColor
               indexItemSelectedBackgroundColor:(UIColor *)indexItemSelectedBackgroundColor
                     indexItemSelectedTextColor:(UIColor *)indexItemSelectedTextColor
                                indexItemHeight:(CGFloat)indexItemHeight
                           indexItemRightMargin:(CGFloat)indexItemRightMargin
                                indexItemsSpace:(CGFloat)indexItemsSpace
{
    SCIndexViewConfiguration *configuration = [self new];
    if (!configuration) return nil;
    
    configuration.indexViewStyle = indexViewStyle;
    configuration.indicatorBackgroundColor = indicatorBackgroundColor;
    configuration.indicatorTextColor = indicatorTextColor;
    configuration.indicatorTextFont = indicatorTextFont;
    configuration.indicatorHeight = indicatorHeight;
    configuration.indicatorRightMargin = indicatorRightMargin;
    configuration.indicatorCornerRadius = indicatorCornerRadius;
    
    configuration.indexItemBackgroundColor = indexItemBackgroundColor;
    configuration.indexItemTextColor = indexItemTextColor;
    configuration.indexItemSelectedBackgroundColor = indexItemSelectedBackgroundColor;
    configuration.indexItemSelectedTextColor = indexItemSelectedTextColor;
    configuration.indexItemHeight = indexItemHeight;
    configuration.indexItemRightMargin = indexItemRightMargin;
    configuration.indexItemsSpace = indexItemsSpace;
    
    return configuration;
}

@end
