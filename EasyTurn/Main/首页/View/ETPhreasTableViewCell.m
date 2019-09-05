//
//  ETPhreasTableViewCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/17.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETPhreasTableViewCell.h"

@implementation ETPhreasTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLab];
        [self addSubview:self.subtitleLab];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UILabel *)titleLab {
    if (!_titleLab) {
         _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 74, 21)];
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    return _titleLab;
}

- (UILabel *)subtitleLab {
    if (!_subtitleLab) {
        _subtitleLab=[[UILabel alloc]initWithFrame:CGRectMake(80,20, Screen_Width, 21)];
        _subtitleLab.font=[UIFont systemFontOfSize:15];
        _subtitleLab.textAlignment = NSTextAlignmentLeft;
        _subtitleLab.numberOfLines = 0;
        _subtitleLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    return _subtitleLab;
}
@end
