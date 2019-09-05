//
//  JMColumnMenuCell.h
//  JMCollectionView
//
//  Created by 刘俊敏 on 2017/12/7.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JMColumnMenuModel.h"
#import "AticleMenu.h"

@interface JMColumnMenuCell : UICollectionViewCell

/** title */
@property (nonatomic, strong) UILabel *title;
/** closeBtn */
@property (nonatomic, strong) UIButton *closeBtn;
/** 数据模型 */
@property (nonatomic, strong) AticleMenu *model;

@end
