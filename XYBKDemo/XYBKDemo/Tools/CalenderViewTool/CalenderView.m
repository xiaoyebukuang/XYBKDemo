//
//  CalenderView.m
//  cwz51
//
//  Created by 陈晓 on 2019/6/5.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import "CalenderView.h"
#import "CalenderWeekView.h"
#import "CalenderModel.h"
#import "CalenderCollectionViewCell.h"
#import "CalenderHeaderView.h"
static NSString * const CalenderCollectionViewCellID = @"CalenderCollectionViewCellID";
static NSString * const CalenderHeaderViewID = @"CalenderHeaderViewID";
@interface CalenderView()<UICollectionViewDelegate, UICollectionViewDataSource>
/** 星期 */
@property (nonatomic, strong) CalenderWeekView *calenderWeekView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSIndexPath      *lastIndexPath;

/** 数据 */
///日期数组
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;
///星期数组，默认：[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]
@property (nonatomic, strong) NSArray *weekArray;

/** 时间格式 */
@property (nonatomic, assign) FormatType formatType;

/** 时间 格式yyyy-MM-dd */
///开始时间
@property (nonatomic, copy) NSString *startDay;
///结束时间
@property (nonatomic, copy) NSString *endDay;

/** 颜色 */
///激活的颜色
@property (nonatomic, strong) UIColor *actvityColor;
///未激活的颜色
@property (nonatomic, strong) UIColor *notActvityColor;
///选中的颜色
@property (nonatomic, strong) UIColor *selectedColor;
///选中的背景颜色
@property (nonatomic, strong) UIColor *selectedBGColor;
///正常背景颜色
@property (nonatomic, strong) UIColor *normalBGColor;
///额外处理的颜色
@property (nonatomic, strong) UIColor *specialColor;

/** 左右间隙 */
@property (nonatomic, assign) CGFloat cellSpace;

@end

@implementation CalenderView

- (instancetype)initWithFrame:(CGRect)frame startDay:(NSString *)startDay endDay:(NSString *)endDay {
    self = [super initWithFrame:frame];
    if (self) {
        self.cellSpace = 10;
        self.backgroundColor = [UIColor color_FFFFFF];
        self.weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        self.dataArray = [NSMutableArray array];
        self.sectionArray = [NSMutableArray array];
        self.formatType = FormatyyyyMd;
        self.startDay = startDay;
        self.endDay = endDay;
        self.actvityColor = [UIColor color_222222];
        self.notActvityColor = [UIColor color_999999];
        self.selectedColor = [UIColor color_FFFFFF];
        self.selectedBGColor = [UIColor color_FF5400];
        self.normalBGColor = [UIColor color_FFFFFF];
        self.specialColor = [UIColor color_FF5400];
        [self setupUI];
        [self buildSource];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.calenderWeekView];
    [self addSubview:self.collectionView];
}
- (void)buildSource {
    [MBProgressHUD showToView:self];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSCalendar *calendar = [NSDate getCalendar];
        NSDateFormatter *dateFormatter = [NSDate getDateFormatterWithFormatType:self.formatType];
        NSUInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute |NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth;
        
        NSDate *startDate =  [dateFormatter dateFromString:self.startDay];
        NSDateComponents *startComponents = [calendar components:unitFlags fromDate:startDate];
        
        NSDate *endDate =  [dateFormatter dateFromString:self.endDay];
        NSDateComponents *endComponents = [calendar components:unitFlags fromDate:endDate];
        
        NSDateFormatter *monthFormatter = [NSDate getDateFormatterWithFormatType:FormatYM];
        //总共月份
        NSInteger allMonth = (endComponents.year - startComponents.year)*12 + (endComponents.month - startComponents.month) + 1;
        for (int i = 0; i < allMonth; i++) {
            NSDateComponents *components = [[NSDateComponents alloc]init];
            NSInteger addYear = (startComponents.month + i - 1)/12;
            NSInteger month = (startComponents.month + i)%12;
            month = (month == 0?12:month);
            components.year = startComponents.year + addYear;
            components.month = month;
            components.day = 1;
            NSDate *date = [calendar dateFromComponents:components];
            NSString *sectionStr = [NSString stringWithFormat:@"%@",[monthFormatter stringFromDate:date]];
            [self.sectionArray addObject:sectionStr];
            //该月总共有几周
            NSInteger weeksInMonth = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date].length;
            //该月总共有几天
            NSInteger daysInMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
            //该月第一周有几天是空白的
            NSInteger firstWeekInMonth = [calendar components:unitFlags fromDate:date].weekday - 1;
            NSMutableArray *rowArray = [NSMutableArray array];
            for (int j = 0; j < weeksInMonth*7; j ++) {
                CalenderModel *model = [[CalenderModel alloc] init];
                model.year  = [NSString stringWithFormat:@"%ld",(long)components.year];
                model.month  = [NSString stringWithFormat:@"%ld",(long)components.month];
                if (j < firstWeekInMonth || j > daysInMonth + firstWeekInMonth - 1 ) {
                    model.showDay = @"";
                    model.isDate = NO;
                } else {
                    model.day = [NSString stringWithFormat:@"%d", (int)(j - firstWeekInMonth + 1)];
                    model.isDate = YES;
                    components.day = model.day.intValue;
                    NSDate *modelDate = [calendar dateFromComponents:components];
                    model.date = modelDate;
                    model.dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:modelDate]];
                    NSString *todayDateStr = [dateFormatter stringFromDate:[NSDate date]];
                    NSString *modelDateStr = [dateFormatter stringFromDate:modelDate];
                    NSDate *todayD = [dateFormatter dateFromString:todayDateStr];
                    NSDate *modelD = [dateFormatter dateFromString:modelDateStr];
                    NSDateComponents *compareCmps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:todayD toDate:modelD options:0];
                    BOOL isToday = NO;
                    BOOL colorChange = NO;
                    if (compareCmps.day == 0 && compareCmps.month == 0 && compareCmps.year == 0) {
                        isToday = YES;
                        model.showDay = @"今天";
                        colorChange = YES;
                    } else if (compareCmps.day == 1 && compareCmps.month == 0 && compareCmps.year == 0){
                        model.showDay = @"明天";
                        colorChange = YES;
                    } else if (compareCmps.day == 2 && compareCmps.month == 0 && compareCmps.year == 0) {
                        model.showDay = @"后天";
                        colorChange = YES;
                    } else {
                        model.showDay = model.day;
                    }
                    if (self.selectedDateStr == nil) {
                        model.isSelected = isToday;
                    } else {
                        NSDate *selectedDate = [dateFormatter dateFromString:self.selectedDateStr];
                        NSComparisonResult result = [selectedDate compare:modelDate];
                        if (result == NSOrderedSame) {
                            model.isSelected = YES;
                        }
                    }
                    model.scrollToThere = model.isSelected?YES:NO;
                    
                    NSDate *dateEndA = [dateFormatter dateFromString:self.endDay];
                    NSDate *dateEndB = [dateFormatter dateFromString:model.dateStr];
                    NSComparisonResult endResult = [dateEndA compare:dateEndB];
                    BOOL comp01 = (endResult == NSOrderedAscending?NO:YES);

                    NSDate *dateStartA = [dateFormatter dateFromString:model.dateStr];
                    NSDate *dateStartB = [dateFormatter dateFromString:self.startDay];
                    NSComparisonResult startResult = [dateStartA compare:dateStartB];
                    BOOL comp02 = (startResult == NSOrderedAscending?NO:YES);

                    if (comp01 && comp02) {
                        model.canSelected = YES;
                        if (colorChange) {
                            model.normalColor = self.specialColor;
                        } else {
                            model.normalColor = self.actvityColor;
                        }
                    } else {
                        model.canSelected = NO;
                        model.normalColor = self.notActvityColor;
                    }
                    model.selectedColor = self.selectedColor;
                    model.selectedBGColor = self.selectedBGColor;
                    model.normalBGColor = self.normalBGColor;
                    if (model.isSelected) {
                        self.lastIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    }
                }
                [rowArray addObject:model];
            }
            [self.dataArray addObject:rowArray];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self];
            NSInteger section = 0;
            for (int i = 0; i < self.dataArray.count; i ++) {
                NSArray *secArr = self.dataArray[i];
                for (int j = 0; j < secArr.count; j ++) {
                    CalenderModel *model = secArr[j];
                    if (model.scrollToThere) {
                        section = i;
                        break;
                    }
                }
            }
            [self.collectionView reloadData];
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        });
    });
    
}
#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *rowArray = self.dataArray[section];
    return rowArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalenderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CalenderCollectionViewCellID forIndexPath:indexPath];
    CalenderModel *calenderModel = self.dataArray[indexPath.section][indexPath.row];
    cell.calenderModel = calenderModel;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CalenderHeaderView *heardView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CalenderHeaderViewID forIndexPath:indexPath];
        heardView.yearAndMonthLabel.text = self.sectionArray[indexPath.section];
        return heardView;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CalenderModel *calenderModel = self.dataArray[indexPath.section][indexPath.item];
    if (!calenderModel.canSelected) {
        return;
    }
    if (indexPath == self.lastIndexPath) {
        return;
    }
    NSMutableArray *reloadArray = [NSMutableArray array];
    if (self.lastIndexPath) {
        CalenderModel *lastCalenderModel = self.dataArray[self.lastIndexPath.section][self.lastIndexPath.row];
        lastCalenderModel.isSelected = NO;
        [reloadArray addObject:self.lastIndexPath];
    }
    [reloadArray addObject:indexPath];
    calenderModel.isSelected = YES;
    self.lastIndexPath = indexPath;
    [self.collectionView reloadItemsAtIndexPaths:reloadArray];
    if ([self.delegate respondsToSelector:@selector(selectDateWithDateStr:)]) {
        [self.delegate selectDateWithDateStr:calenderModel.dateStr];
    }
}
/** 每个分区的内边距（上左下右） */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, self.cellSpace, 0, self.cellSpace);
}
#pragma mark -- setup
- (CalenderWeekView *)calenderWeekView {
    if (!_calenderWeekView) {
        _calenderWeekView = [[CalenderWeekView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 25)];
        _calenderWeekView.cellSpace = 10;
        _calenderWeekView.weekArray = self.weekArray;
    }
    return _calenderWeekView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        CGFloat item_width = (MAIN_SCREEN_WIDTH - self.cellSpace*2)/7;
        CGFloat item_height = 50;
        flowLayout.headerReferenceSize = CGSizeMake(MAIN_SCREEN_WIDTH, 30);
        flowLayout.itemSize = CGSizeMake(item_width, item_height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.calenderWeekView.height, self.width, NAV_CONTENT_HEIGHT - self.calenderWeekView.height) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.backgroundColor = [UIColor color_FFFFFF];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CalenderCollectionViewCell class] forCellWithReuseIdentifier:CalenderCollectionViewCellID];
        [_collectionView registerClass:[CalenderHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CalenderHeaderViewID];
    }
    return _collectionView;
}
@end
