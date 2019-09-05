//
//  ETunsTableViewCell.h
//  EasyTurn
//
//  Created by 王翔 on 2019/8/26.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETunsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLab;

@end

NS_ASSUME_NONNULL_END
