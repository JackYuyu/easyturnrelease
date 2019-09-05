//
//  ETHomeTopView.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/19.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETHomeTopView1.h"
//#import "OTButton.h"
@interface ETHomeTopView1 ()
//@property (nonatomic, strong) UIButton *btnLocation;
//@property (nonatomic, strong) OTButton *btnLocationDown;
@property (nonatomic, strong) UIImageView *imagevLogo;
@property (nonatomic, strong) UILabel *laTitle;
@end

@implementation ETHomeTopView1

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    
    UIView *vBackground = [[UIView alloc]init];
    vBackground.backgroundColor = kACColorBlue_Theme;
    [self addSubview:vBackground];
    [vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kStatusBarHeight + 65);
    }];
    
    _btnLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnLocation setBackgroundImage:[UIImage imageNamed:@"首页_定位"] forState:UIControlStateNormal];
    [vBackground addSubview:_btnLocation];
    [_btnLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight + 20);
        make.left.mas_equalTo(15);
    }];
    
    _btnLocationDown = [OTButton buttonWithType:UIButtonTypeCustom];
    _btnLocationDown.ot_styleWithImageViewAndLabelAlignment = OTButtonImageViewAndLabelAlignmentStyleImageViewRightAndLabelLeft;
    _btnLocationDown.ot_marginWithImageViewAndLabel = 3;
    [_btnLocationDown setTitle:@"北京" forState:UIControlStateNormal];
    [_btnLocationDown setTitleColor:kACColorWhite forState:UIControlStateNormal];
    [_btnLocationDown setImage:[UIImage imageNamed:@"首页_下拉"] forState:UIControlStateNormal];
    _btnLocationDown.titleLabel.font = kFontSize(13);
    [_btnLocationDown addTarget:self action:@selector(locationController) forControlEvents:UIControlEventTouchUpInside];
    [vBackground addSubview:_btnLocationDown];
    [_btnLocationDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnLocation);
        make.left.equalTo(self.btnLocation.mas_right).offset(6);
    }];
    
    _imagevLogo = [[UIImageView alloc]init];
    _imagevLogo.image = [UIImage imageNamed:@"首页_易转logo"];
    [vBackground addSubview:_imagevLogo];
    //适配全面屏
        [_imagevLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight + 0);
            make.centerX.equalTo(vBackground);
        }];
    
    _laTitle = [[UILabel alloc]init];
    _laTitle.text = @"一站式中小企业流转企服平台";
    _laTitle.textColor = kACColorWhite;
    _laTitle.font = kFontSize(15);
    [vBackground addSubview:_laTitle];
    [_laTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagevLogo.mas_bottom);
        make.centerX.equalTo(vBackground);
        make.height.mas_equalTo(15);
    }];
}
-(void)locationController
{
    if (self.block) {
        self.block();
    }
}
@end
