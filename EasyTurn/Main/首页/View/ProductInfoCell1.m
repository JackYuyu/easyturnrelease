//
//  ProductInfoCell.m
//  CFOnlineShop
//
//  Created by app on 2019/5/31.
//  Copyright © 2019年 chenfeng. All rights reserved.
//

#import "ProductInfoCell1.h"

@interface ProductInfoCell1()

@end
@implementation ProductInfoCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_tradeBtn setBackgroundColor:RGBCOLOR(236, 130, 65)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
