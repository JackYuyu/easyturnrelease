//
//  ETManageTableViewCell.h
//  EasyTurn
//
//  Created by 王翔 on 2019/8/24.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETManageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *hosnLab;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;

@end

NS_ASSUME_NONNULL_END
