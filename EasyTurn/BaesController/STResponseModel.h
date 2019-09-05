//
//  STResponseModel
//  Stone
//
//  Created by GeWei on 2018/6/21.
//  Copyright © 2018年 song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STResponseModel : NSObject
/// code码
@property (nonatomic, assign) NSInteger code;
/// 正常为"success",失败会返回错误码描述
@property (nonatomic, strong) NSString *msg;
/// 返回数据
@property (nonatomic, strong) id data;
@end
