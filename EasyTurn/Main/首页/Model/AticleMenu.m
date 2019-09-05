//
//  AticleMenu.m
//  Fireball
//
//  Created by 任长平 on 2017/12/2.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "AticleMenu.h"

@implementation AticleMenu
- (instancetype)init{
    self = [super init];
    if (self) {
        self.resident = NO;
    }
    return self;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"menuId":@"ID"};
}
//如果需要指定“唯一约束”字段,就实现该函数,这里指定 userId 为“唯一约束”.
//+(NSString *)bg_uniqueKey{
//    return @"menuId";
//}

@end
