//
//  ETEnterpriseServiceTableViewCell.h
//  EasyTurn
//
//  Created by 王翔 on 2019/7/24.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETEnterpriseServiceTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *comImg;
@property(nonatomic,strong)UILabel *giveserviceLab;
@property(nonatomic,strong)UILabel *serviceLab;
@property(nonatomic,strong)UILabel *moneyLab;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UILabel *detailsLab;
@end

NS_ASSUME_NONNULL_END
