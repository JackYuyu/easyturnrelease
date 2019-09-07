//
//  MyOrderCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/6.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.paybtn.clipsToBounds=YES;
    self.paybtn.layer.cornerRadius=2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
