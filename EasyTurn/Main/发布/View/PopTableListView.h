//
//  PopTableListView.h
//  PopView
//
//  Created by 李志超 on 2019/8/3.
//  Copyright © 2019年 李志超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopTableListViewDelegate <NSObject>

- (void)selectType:(NSString *)name type:(NSString *)type;

- (void)selectEffetiveTimeType:(NSString *)name type:(NSString *)type;

@end

@interface PopTableListView : UIView

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles imgNames:(NSArray <NSString *>*)imgNames type:(NSString *)type;

@property (nonatomic, weak) id <PopTableListViewDelegate> delegate;

@end
