//
//  WrongSpeakBtn.m
//  iYJ
//
//  Created by yye on 17/3/4.
//  Copyright © 2017年 Welstone. All rights reserved.
//

#import "WrongSpeakBtn.h"
@interface WrongSpeakBtn()
@property (strong, nonatomic) UIView *showView;
@end
@implementation WrongSpeakBtn

-(void)awakeFromNib{
    [super awakeFromNib];
    //设置 字体颜色 和 字体大小
    self.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.showView.hidden = NO;
}
-(void)setQJselected:(BOOL)QJselected{
    _QJselected=QJselected;
    self.selected = QJselected;
    self.showView.hidden = !QJselected;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //布局一下 showView的 frame  宽度 self.titleLabel 的左右对其
    
    [self.showView setFrame:CGRectMake(10, self.frame.size.height-2.5, 20, 3)];
    self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
}

-(UIView *)showView{
    if(!_showView){
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        _showView.backgroundColor = [UIColor greenColor];
        [self addSubview:_showView];
    }
    return _showView;
}
@end
