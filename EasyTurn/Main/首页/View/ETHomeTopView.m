//
//  ETHomeTopView.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/19.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETHomeTopView.h"
//#import "OTButton.h"
@interface ETHomeTopView ()
//@property (nonatomic, strong) UIButton *btnLocation;
//@property (nonatomic, strong) OTButton *btnLocationDown;
@property (nonatomic, strong) UIImageView *imagevLogo;
@property (nonatomic, strong) UILabel *laTitle;

@property (nonatomic, strong) UIView *vSearch;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UILabel *laSearch;
@end

@implementation ETHomeTopView

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
    vBackground.backgroundColor = kACColorWhite;
    [self addSubview:vBackground];
    [vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kStatusBarHeight + 65);
    }];
    
    
    
    _btnLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnLocation setBackgroundImage:[UIImage imageNamed:@"动态列表_定位"] forState:UIControlStateNormal];
    [vBackground addSubview:_btnLocation];
    [_btnLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight + 20);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(14,16);
    }];
    
    _btnLocationDown = [OTButton buttonWithType:UIButtonTypeCustom];
    _btnLocationDown.ot_styleWithImageViewAndLabelAlignment = OTButtonImageViewAndLabelAlignmentStyleImageViewRightAndLabelLeft;
    _btnLocationDown.ot_marginWithImageViewAndLabel = 3;
    [_btnLocationDown setTitle:@"北京" forState:UIControlStateNormal];
    [_btnLocationDown setTitleColor:kACColorBlack forState:UIControlStateNormal];
    [_btnLocationDown setImage:[UIImage imageNamed:@"首页_下拉"] forState:UIControlStateNormal];
    _btnLocationDown.titleLabel.font = kFontSize(15);
    [_btnLocationDown addTarget:self action:@selector(locationController) forControlEvents:UIControlEventTouchUpInside];
    [vBackground addSubview:_btnLocationDown];
    [_btnLocationDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnLocation);
        make.left.equalTo(self.btnLocation.mas_right).offset(8);
    }];
    
//    _imagevLogo = [[UIImageView alloc]init];
//    _imagevLogo.image = [UIImage imageNamed:@"首页_易转logo"];
//    [vBackground addSubview:_imagevLogo];
//    //适配全面屏
//        [_imagevLogo mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(kStatusBarHeight + 0);
//            make.centerX.equalTo(vBackground);
//        }];
//    
//    _laTitle = [[UILabel alloc]init];
//    _laTitle.text = @"一站式中小企业流转企服平台";
//    _laTitle.textColor = kACColorWhite;
//    _laTitle.font = kFontSize(15);
//    [vBackground addSubview:_laTitle];
//    [_laTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.imagevLogo.mas_bottom);
//        make.centerX.equalTo(vBackground);
//        make.height.mas_equalTo(15);
//    }];
        _vSearch = [[UIView alloc]init];
        _vSearch.backgroundColor = kACColorBackgroundGray;
        [_vSearch addCornerRadiusWithRadius:33/2.0f];
        [vBackground addSubview:_vSearch];
        [_vSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.btnLocation);
            make.left.mas_equalTo(90);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
        }];
    
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSearch)];
        [_vSearch addGestureRecognizer:tap];
    
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSearch setBackgroundImage:[UIImage imageNamed:@"首页_搜索"] forState:UIControlStateNormal];
        [_vSearch addSubview:_btnSearch];
        [_btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.vSearch);
            make.left.mas_equalTo(13);
        }];
    
        _laSearch = [[UILabel alloc]init];
        _laSearch.text = @"搜索所需流转资源及专项服务";
        _laSearch.textColor = kACColorRGB(153, 153, 153);
        _laSearch.font = kFontSize(14);
        [_vSearch addSubview:_laSearch];
        [_laSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.vSearch).mas_offset(2);
            make.left.equalTo(self.btnSearch.mas_right).offset(4);
        }];

}
-(void)locationController
{
    if (self.block) {
        self.block();
    }
}
-(void)onClickSearch
{
    if (self.block1) {
        self.block1();
    }
}
@end
