//
//  MsgInfo.h
//  EasyTurn
//
//  Created by 程立 on 2019/8/16.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+BGModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MsgInfo : NSObject
@property (nonatomic, strong) NSString* msgid;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* body;

@end

NS_ASSUME_NONNULL_END
