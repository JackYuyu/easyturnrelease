//
//  ETAdimiTableViewCell.h
//  EasyTurn
//
//  Created by 王翔 on 2019/8/25.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETAdimiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *comLab;
@property (weak, nonatomic) IBOutlet UILabel *payLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *manyLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *yifuLab;
- (IBAction)yifuBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleLab;
- (IBAction)deleBtn:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
