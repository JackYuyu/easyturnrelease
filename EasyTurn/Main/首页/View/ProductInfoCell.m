//
//  ProductInfoCell.m
//  CFOnlineShop
//
//  Created by app on 2019/5/31.
//  Copyright © 2019年 chenfeng. All rights reserved.
//

#import "ProductInfoCell.h"

@interface ProductInfoCell()

@end
@implementation ProductInfoCell

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
