//
//  EaseSyetemListCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "EaseUserMeagessListCell.h"
#import "ETProductModel.h"
@interface EaseUserMeagessListCell ()
@property (nonatomic, strong) UILabel *laTitle;
@property (nonatomic, strong) UILabel *laSubTitle;
@property (nonatomic, strong) UILabel *laTime;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UILabel *laLook;
@property (nonatomic, strong) UIImageView *imagevJiantou;
@end

@implementation EaseUserMeagessListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kACColorWhite1_R242_G242_B242_A1;
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    
    UIView *bgview = [[UIView alloc]init];
    [bgview addCornerRadiusWithRadius:8.0f];
    bgview.backgroundColor = kACColorWhite;
    [self.contentView addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.equalTo(self.contentView);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [bgview addSubview:self.laTitle];
    [bgview addSubview:self.laSubTitle];
    [bgview addSubview:self.laTime];
    [bgview addSubview:self.vLine];
    [bgview addSubview:self.laLook];
    [bgview addSubview:self.imagevJiantou];
    
    [self.laTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(SCREEN_WIDTH-170);
    }];
    
    [self.laSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laTitle.mas_bottom).offset(9);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-5);
    }];
    
    [self.laTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.laTitle);
        make.right.mas_equalTo(-7);
        make.height.mas_equalTo(23);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laSubTitle.mas_bottom).offset(11);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kLinePixel);
    }];
    
    [self.laLook mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.vLine.mas_bottom).offset(7);
        make.left.mas_equalTo(12);
        make.bottom.mas_equalTo(-7);
    }];
    
    [self.imagevJiantou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.laLook);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(8, 14));
    }];
}

- (void)makeCellWithETProductModel:(ETProductModel *)model WithIndexPath:(NSIndexPath *)indexPath {
    _laTitle.text = [NSString stringWithFormat:@"%@发布了一条新的求购",model.userName];
    _laSubTitle.text = model.title;
    _laTime.text = model.createDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-DD'T'HH:mm:ss.sssZ"];
    NSDate *houtaiDate = [dateFormatter dateFromString:model.createDate];
    NSDateFormatter *dateFormattershow = [[NSDateFormatter alloc] init];
    [dateFormattershow setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormattershow stringFromDate:houtaiDate];
    NSString* createdate=[model.createDate stringByReplacingOccurrencesOfString:@".000+0000" withString:@""];
    createdate=[createdate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _laTime.text = createdate;
}

- (UILabel *)laTitle {
    if (!_laTitle) {
        _laTitle = [[UILabel alloc]init];
        _laTitle.text = @"小叮当发布了一条新的求购";
        _laTitle.textColor = kACColorBlackTypeface;
        _laTitle.font = kBoldFontSize(15);
    }
    return _laTitle;
}

- (UILabel *)laSubTitle {
    if (!_laSubTitle) {
        _laSubTitle = [[UILabel alloc]init];
        _laSubTitle.numberOfLines = 0;
        _laSubTitle.text = @"易转官方提示：本平台只作为信息流转平台，建议交易双方私下签订相关交易协议平台不承担任何风险。";
        _laSubTitle.textColor = kACColorRGB(153, 153, 153);
        _laSubTitle.font = kFontSize(13);
    }
    return _laSubTitle;
}

- (UILabel *)laTime {
    if (!_laTime) {
        _laTime = [[UILabel alloc]init];
        _laTime.text = @"2019-09-07 12:39";
        _laTime.textColor = kACColorRGB(102, 102, 102);;
        _laTime.font = kFontSize(12);
    }
    return _laTime;
}

- (UILabel *)laLook {
    if (!_laLook) {
        _laLook = [[UILabel alloc]init];
        _laLook.text = @"立即查看";
        _laLook.textColor = kACColorBlue_Theme;
        _laLook.font = kFontSize(13);
    }
    return _laLook;
}

- (UIView *)vLine {
    if (!_vLine) {
        _vLine = [[UIView alloc]init];
        _vLine.backgroundColor = kACColorWhite1_R242_G242_B242_A1;
    }
    return _vLine;
}

- (UIImageView *)imagevJiantou {
    if (!_imagevJiantou) {
        _imagevJiantou = [[UIImageView alloc]init];
        _imagevJiantou.image = [UIImage imageNamed:@"消息_进入箭头"];
    }
    return _imagevJiantou;
}

@end
