//
//  ETProductDetailVC.h
//  EasyTurn
//
//  Created by 王翔 on 2019/8/22.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACViewController.h"
#import "ETProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETProductDetailVC : ACViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *releaseId;
@property (nonatomic, strong) ETProductModel *product;
@end

NS_ASSUME_NONNULL_END
