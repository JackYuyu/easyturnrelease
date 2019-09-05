//
//  LQCityPicker.h
//  LQToolKit-ObjectiveC
//
//  Created by 李志超 on 2019/8/3.
//  Copyright © 2019年 李志超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LQCityPickerHandler)(NSArray *objs, NSString *dsc);
typedef void(^LQCityPickerCancelHandler)(void);

@interface LQCityPicker : UIView

/** 是否自动显示选择结果 */
@property (assign, nonatomic)BOOL autoChange;

/** 动画时间间隔 默认 0.2s*/
@property (nonatomic, assign) NSTimeInterval interval;
//建议 NSFontAttributeName 和 NSForegroundColorAttributeName一同设置
/** 选择器文本内容字体属性,默认:蓝色,14号 */
@property (strong, nonatomic)NSDictionary *textAttributes;
/** 按钮标题字体属性,默认:蓝色,14号 */
@property (strong, nonatomic)NSDictionary *titleAttributes;

/**
 毛玻璃效果
 */
@property (nonatomic, assign) BOOL isBlur;

+ (instancetype)showInView:(UIView *)view datas:(NSArray *)datas didSelectWithBlock:(LQCityPickerHandler)block cancelBlock:(LQCityPickerCancelHandler)cancel ;

- (void)show ;
- (void)dismiss ;

- (void)loadDatas:(NSArray *)datas;
@end
