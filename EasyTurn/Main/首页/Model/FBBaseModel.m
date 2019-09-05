//
//  FBBaseModel.m
//  Fireball
//
//  Created by 任长平 on 2017/12/25.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "FBBaseModel.h"

@implementation FBBaseModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"fb_id":@"ID"};
}
@end
