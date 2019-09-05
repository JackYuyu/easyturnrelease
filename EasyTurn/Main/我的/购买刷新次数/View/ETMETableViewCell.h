//
//  ETMETableViewCell.h
//  EasyTurn
//
//  Created by 王翔 on 2019/7/20.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETMETableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *comImg;
@property(nonatomic,strong)UILabel *comLab;
@property(nonatomic,strong)UILabel *sellLab;
@property(nonatomic,strong)UIImageView *locaImg;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UIButton *frishBtn;
@property(nonatomic,strong)UIButton *deleteBtn;
@end

NS_ASSUME_NONNULL_END
