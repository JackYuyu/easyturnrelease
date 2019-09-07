//
//  MyOrderCell.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/6.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *title;

@property (nonatomic, strong) IBOutlet UILabel *orderno;
@property (nonatomic, strong) IBOutlet UILabel *date;
@property (nonatomic, strong) IBOutlet UILabel *status;

@property (nonatomic, strong) IBOutlet UILabel *payprice;
@property (nonatomic, strong) IBOutlet UIButton *paybtn;

@end

NS_ASSUME_NONNULL_END
