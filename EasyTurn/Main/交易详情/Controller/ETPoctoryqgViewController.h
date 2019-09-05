//
//  ETPoctoryqgViewController.h
//  布局
//
//  Created by 王翔 on 2019/8/29.
//  Copyright © 2019 王翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETPoctoryqgViewController : UIViewController
@property (nonatomic, strong) ETProductModel *product;
@property (nonatomic, copy) NSString *releaseId;
//+ (instancetype)saleDetailController:(NSDictionary *)detailInfo;
@end

NS_ASSUME_NONNULL_END
