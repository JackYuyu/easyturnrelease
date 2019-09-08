//
//  ETEnterpriseServicesBusinessScopeModel.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETEnterpriseServicesBusinessScopeModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSArray<ETEnterpriseServicesBusinessScopeModel *> *list;
#pragma mark - 自定义字段
@property (nonatomic, assign) BOOL isOpen;// 是否打开 (对组)
@property (nonatomic, assign) BOOL isSelected;//是否选中(对cell)
@property (nonatomic, assign) CGFloat cellheight;
@end

NS_ASSUME_NONNULL_END
