//
//  FBBaseModel.h
//  Fireball
//
//  Created by 任长平 on 2017/12/25.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBBaseModel : NSObject
///"ID": 217,
@property(nonatomic, assign)NSInteger fb_id;
///"Text": "数字货币"
@property(nonatomic, copy)NSString *Text;
@end
