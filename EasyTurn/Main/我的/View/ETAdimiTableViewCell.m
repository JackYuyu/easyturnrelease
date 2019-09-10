//
//  ETAdimiTableViewCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/25.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETAdimiTableViewCell.h"

@implementation ETAdimiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)yifuBtn:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag);
    }
}
- (IBAction)deleBtn:(UIButton *)sender {
    if (self.block1) {
        self.block1(sender.tag);
    }
}
@end
