//
//  ETProductModel.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/28.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETProductModel.h"

@implementation ETProductModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"orderid":@"id"};
    
}
+(NSArray *)bg_uniqueKeys{
    return @[@"touser"];
}
@end
