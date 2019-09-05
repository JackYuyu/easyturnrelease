//
//  ETHomeModel.h
//  EasyTurn
//
//  Created by 程立 on 2019/7/19.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "STBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class AdListModel;
@interface ETHomeModel : STBaseModel
@property (nonatomic, strong) NSArray<AdListModel *> *adList;
/**
 轮播图
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestGetIndexBannerSuccess:(STBaseModelRequestSuccess)success
                             failure:(STBaseModelRequestFailure)failure;
@end

@interface AdListModel : STBaseModel

@property (nonatomic, copy) NSString *countDown;

@property (nonatomic, copy) NSString *baesId;

@property (nonatomic, copy) NSString *countdownTime;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *desc;

@end
NS_ASSUME_NONNULL_END
