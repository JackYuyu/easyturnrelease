//
//  FBRequestSearch.h
//  Fireball
//
//  Created by 任长平 on 2017/12/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "RequestPageInfo.h"

@interface FBRequestSearch : NSObject
///MenuType
@property(nonatomic, copy)NSString * MenuType;
///PageInfo
//@property(nonatomic, strong)RequestPageInfo *PageInfo;
///StrKey
@property(nonatomic, copy)NSString *StrKey;
///iType
@property(nonatomic, assign)NSInteger iType;

@end
