//
//  AticleMenu.h
//  Fireball
//
//  Created by 任长平 on 2017/12/2.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSObject+BGModel.h"

@interface AticleMenu : NSObject
///ID = 211;
@property(nonatomic, assign)int menuId;
///Text = "\U4e13\U8bbf";
@property(nonatomic, copy)NSString *Text;
@property(nonatomic, assign)int iType;

/** 是否允许删除 */
@property (nonatomic, assign) BOOL resident;

/** 是否选中 */
@property (nonatomic, assign) BOOL selected;
/** 是否显示加号 */
@property (nonatomic, assign) BOOL showAdd;

@property(nonatomic, assign)BOOL isEditing;
/** type */
//@property (nonatomic, assign) JMColumnMenuType type;

@end
