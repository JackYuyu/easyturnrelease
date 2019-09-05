//
//  STHomeToolsItemModel.h
//  Stone
//
//  Created by GeWei on 2018/5/4.
//  Copyright © 2018年 song. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, STHomeToolsItemModelSchemePushType)  {
    
    STHomeToolsItemModelSchemePushTypePrepayment = 1,
    
    STHomeToolsItemModelSchemePushTypeDelivery = 2,
    
    STHomeToolsItemModelSchemePushTypeLoveCar = 3,
};

@interface OTDynamicGridModel : NSObject
@property (nonatomic, assign) STHomeToolsItemModelSchemePushType schemePushType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgName;
@end
