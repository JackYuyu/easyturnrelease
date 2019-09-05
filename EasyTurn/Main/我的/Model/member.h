//
//  member.h
//  EasyTurn
//
//  Created by 程立 on 2019/8/25.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface member : NSObject
@property(nonatomic,strong)NSString* uid;
@property(nonatomic,strong)NSString* portrait;
@property(nonatomic,strong)NSString* company;
@property(nonatomic,strong)NSString* auroraName;
@property(nonatomic,strong)NSString* name;


@property(nonatomic,strong)NSString* realName;
@property(nonatomic,strong)NSString* isCheckedId;
@property(nonatomic,strong)NSString* userId;
@property(nonatomic,strong)NSString* image;
@property(nonatomic,strong)NSString* idCard;


@end

NS_ASSUME_NONNULL_END
