//
//  ETInvitationController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETInvitationController.h"
#import "ETMineViewModel.h"
@interface ETInvitationController ()
@property (nonatomic, strong) UIScrollView *scrollvBackground;
@property (nonatomic, strong) UILabel *laInvitationCode;
@end

@implementation ETInvitationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self wr_setNavBarTitleColor:kACColorBlackTypeface];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kACColorWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self wr_setNavBarTitleColor:kACColorWhite];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kACColorBlue_Theme];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_scrollvBackground setContentSize:CGSizeMake(Screen_Width, 637)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enableLeftBackButton];
    self.navigationItem.title = @"邀请好友";

    [self createSubViewsAndConstraints];
}
-(void)goDymic{
    if (self.model.userInfo.invitationCodeUtilMe) {
        _laInvitationCode.text = self.model.userInfo.invitationCodeUtilMe;
    }else {
        _laInvitationCode.text = @"暂无邀请码";
    }
}
#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    _scrollvBackground = [[UIScrollView alloc] init];
    _scrollvBackground.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollvBackground];
    [_scrollvBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIImageView *imagevBg = [[UIImageView alloc]init];
    imagevBg.image = [UIImage imageNamed:@"我的_邀请好友背景"];
    [_scrollvBackground addSubview:imagevBg];
    [imagevBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollvBackground);
        make.width.mas_equalTo(Screen_Width);
    }];
    
    UIImageView *imagevLogo = [[UIImageView alloc]init];
    imagevLogo.image = [UIImage imageNamed:@"我的_邀请好友_logo"];
    [_scrollvBackground addSubview:imagevLogo];
    [imagevLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(59);
        make.centerX.equalTo(self.scrollvBackground);
        make.size.mas_equalTo(CGSizeMake(304, 41));
    }];
    
    UIView *vInvitation = [[UIView alloc]init];
    [vInvitation addCornerRadiusWithRadius:4.0f];
    vInvitation.backgroundColor = kACColorWhite;
    [_scrollvBackground addSubview:vInvitation];
    [vInvitation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imagevLogo.mas_bottom).offset(32);
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *laTips = [[UILabel alloc]init];
    laTips.text = @"您的专属邀请码";
    laTips.textColor = kACColorRGB(153, 153, 153);
    laTips.font = kFontSize(12);
    [vInvitation addSubview:laTips];
    [laTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17);
        make.left.mas_equalTo(36);
        make.height.mas_equalTo(12);
    }];
    
    UILabel *laInvitationCode = [[UILabel alloc]init];
    _laInvitationCode = laInvitationCode;
    laInvitationCode.textColor = kACColorBlackTypeface;
    laInvitationCode.font = kFontSize(20);
    [vInvitation addSubview:laInvitationCode];
    [laInvitationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(laTips.mas_bottom).offset(11);
        make.centerX.equalTo(laTips);
        make.height.mas_equalTo(23);
    }];
    
    UIButton *btnCopy = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCopy setImage:[UIImage imageNamed:@"我的_邀请好友_复制"] forState:UIControlStateNormal];
    [vInvitation addSubview:btnCopy];
    [btnCopy addTarget:self action:@selector(onClickCopy) forControlEvents:UIControlEventTouchUpInside];
    [btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(laInvitationCode);
        make.left.equalTo(laTips.mas_right).offset(30);
        make.size.mas_equalTo(CGSizeMake(16, 17));
    }];
    
    UIView *vInvitationBox = [[UIView alloc]init];
    vInvitationBox.backgroundColor = kACColorRGB(253, 150, 29);
    [vInvitation addSubview:vInvitationBox];
    [vInvitationBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vInvitation);
        make.right.equalTo(vInvitation);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *laInvitationTitle = [[UILabel alloc]init];
    laInvitationTitle.numberOfLines = 0;
    laInvitationTitle.text = @"立即\n邀请";
    laInvitationTitle.textColor = kACColorWhite;
    laInvitationTitle.font = kFontSize(20);
    laInvitationTitle.userInteractionEnabled=YES;
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goDymic)];
    [laInvitationTitle addGestureRecognizer:tap1];
    [vInvitationBox addSubview:laInvitationTitle];
    
    [laInvitationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(vInvitationBox);
        make.size.mas_equalTo(CGSizeMake(41, 48));
    }];
    
    UILabel *laInvitationJiLu = [[UILabel alloc]init];
    laInvitationJiLu.text = @"邀请记录";
    laInvitationJiLu.textColor = kACColorWhite;
    laInvitationJiLu.font = kFontSize(18);
    [_scrollvBackground addSubview:laInvitationJiLu];
    [laInvitationJiLu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vInvitationBox.mas_bottom).offset(30);
        make.centerX.equalTo(self.scrollvBackground);
        make.height.mas_equalTo(18);
    }];
    
    UIImageView *imagevLeft = [[UIImageView alloc]init];
    imagevLeft.image = [UIImage imageNamed:@"我的_邀请好友_左箭头"];
    [_scrollvBackground addSubview:imagevLeft];
    [imagevLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(laInvitationJiLu);
        make.right.equalTo(laInvitationJiLu.mas_left).offset(-23);
    }];
    
    UIImageView *imagevRight = [[UIImageView alloc]init];
    imagevRight.image = [UIImage imageNamed:@"我的_邀请好友_右箭头"];
    [_scrollvBackground addSubview:imagevRight];
    [imagevRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(laInvitationJiLu);
        make.left.equalTo(laInvitationJiLu.mas_right).offset(23);
    }];
    
    UIView *vInvitationJilu = [[UIView alloc]init];
    [vInvitationJilu addCornerRadiusWithRadius:4.0f];
    vInvitationJilu.backgroundColor = kACColorWhite;
    [_scrollvBackground addSubview:vInvitationJilu];
    [vInvitationJilu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(laInvitationJiLu.mas_bottom).offset(17);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(70);
    }];
    
    UILabel *laInvitationCount = [[UILabel alloc]init];
    laInvitationCount.text = @"1人";
    laInvitationCount.textColor = kACColorBlackTypeface;
    laInvitationCount.font = kFontSize(22);
    [vInvitationJilu addSubview:laInvitationCount];
    [laInvitationCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17);
        make.left.mas_equalTo(67);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *laInvitationCountTips = [[UILabel alloc]init];
    laInvitationCountTips.text = @"邀请数量";
    laInvitationCountTips.textColor = kACColorRGB(153, 153, 153);
    laInvitationCountTips.font = kFontSize(12);
    [vInvitationJilu addSubview:laInvitationCountTips];
    [laInvitationCountTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(laInvitationCount.mas_bottom).offset(11);
        make.centerX.equalTo(laInvitationCount);
        make.height.mas_equalTo(12);
    }];
    
    UIView *vInvitationCountLine = [[UIView alloc]init];
    vInvitationCountLine.backgroundColor = kACColorRGB(238, 238, 238);
    [vInvitationJilu addSubview:vInvitationCountLine];
    [vInvitationCountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kLinePixel);
        make.center.equalTo(vInvitationJilu);
        make.height.mas_equalTo(41);
    }];
    
    UILabel *laInvitationRefreshCount = [[UILabel alloc]init];
    laInvitationRefreshCount.text = @"10次";
    laInvitationRefreshCount.textColor = kACColorBlackTypeface;
    laInvitationRefreshCount.font = kFontSize(22);
    laInvitationRefreshCount.textAlignment = NSTextAlignmentRight;
    [vInvitationJilu addSubview:laInvitationRefreshCount];
    [laInvitationRefreshCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17);
        make.right.mas_equalTo(-70);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *laInvitationCRefreshTips = [[UILabel alloc]init];
    laInvitationCRefreshTips.text = @"获得刷新次数";
    laInvitationCRefreshTips.textColor = kACColorRGB(153, 153, 153);
    laInvitationCRefreshTips.font = kFontSize(12);
    [vInvitationJilu addSubview:laInvitationCRefreshTips];
    [laInvitationCRefreshTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(laInvitationRefreshCount.mas_bottom).offset(11);
        make.centerX.equalTo(laInvitationRefreshCount);
        make.height.mas_equalTo(12);
    }];
    
    UIView *vTipsBox = [[UIView alloc]init];
    [vTipsBox addCornerRadiusWithRadius:4.0f];
    vTipsBox.backgroundColor = kACColorRGB(255, 164, 46);
    [self.scrollvBackground addSubview:vTipsBox];
    [vTipsBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vInvitationJilu.mas_bottom).offset(30);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(225);
    }];
    
    UILabel *laInvitationGuiZe = [[UILabel alloc]init];
    laInvitationGuiZe.text = @"活动规则";
    laInvitationGuiZe.textColor = kACColorWhite;
    laInvitationGuiZe.font = kFontSize(18);
    [vTipsBox addSubview:laInvitationGuiZe];
    [laInvitationGuiZe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(23);
        make.centerX.equalTo(vTipsBox);
        make.height.mas_equalTo(18);
    }];
    
    UIImageView *imagevGuizeLeft = [[UIImageView alloc]init];
    imagevGuizeLeft.image = [UIImage imageNamed:@"我的_邀请好友_左箭头"];
    [vTipsBox addSubview:imagevGuizeLeft];
    [imagevGuizeLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(laInvitationGuiZe);
        make.right.equalTo(laInvitationGuiZe.mas_left).offset(-23);
    }];
    
    UIImageView *imagevGuizeRight = [[UIImageView alloc]init];
    imagevGuizeRight.image = [UIImage imageNamed:@"我的_邀请好友_右箭头"];
    [vTipsBox addSubview:imagevGuizeRight];
    [imagevGuizeRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(laInvitationGuiZe);
        make.left.equalTo(laInvitationGuiZe.mas_right).offset(23);
    }];
    
    UILabel *laInvitationGuiZeTitle = [[UILabel alloc]init];
    laInvitationGuiZeTitle.numberOfLines = 0;
    laInvitationGuiZeTitle.text = @"1、新用户注册登录成功后送7天会员，且每邀请一位新用户成功注册送30次刷新。\n2、用户通过邀请码邀请成功的新用户才计入邀请记录(获得免费刷新次数),可以分享邀请信息到好友及朋友圈，也可复制邀请码发送好友，被邀请者可在注册账号时填写。\n3、如果您有其他疑问，可通过“联系我们”与我们反馈。\n4、易转科技保留在法律规定范围内对上述规则进行解释的权利。";
    laInvitationGuiZeTitle.textColor = kACColorWhite;
    laInvitationGuiZeTitle.font = kFontSize(12);
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 6 - (laInvitationGuiZeTitle.font.lineHeight - laInvitationGuiZeTitle.font.pointSize);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    laInvitationGuiZeTitle.attributedText = [[NSAttributedString alloc] initWithString:laInvitationGuiZeTitle.text attributes:attributes];
    
    [vTipsBox addSubview:laInvitationGuiZeTitle];
    [laInvitationGuiZeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(laInvitationGuiZe.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(305);
        make.height.mas_equalTo(145);
    }];
    
    
}

- (void)onClickCopy {
    if (self.model.userInfo.invitationCodeUtilMe) {
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        [pab setString:self.model.userInfo.invitationCodeUtilMe];
        [MBProgressHUD showSuccess:@"邀请码已复制" toView:self.view];
    }
}
@end
