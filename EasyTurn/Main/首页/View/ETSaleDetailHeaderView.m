//
//  ETSaleDetailHeaderView.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/29.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETSaleDetailHeaderView.h"


@interface ETSaleDetailHeaderView ()

@property (nonatomic,copy) void (^clickBlock)(void);
@property (nonatomic,strong)UILabel* labelTitle;
@end

@implementation ETSaleDetailHeaderView

+ (instancetype)saleDetailHeaderView:(NSDictionary *)dict click:(nonnull void (^)(void))clickBlock{
    ETSaleDetailHeaderView *view = [[self alloc] init];
    view.clickBlock = clickBlock;
    [view constructSaleSubs:dict];
    return view;
}
+ (instancetype)serviceDetailHeaderView:(NSDictionary *)dict click:(void (^)(void))clickBlock{
    ETSaleDetailHeaderView *view = [[self alloc] init];
    view.clickBlock = clickBlock;
    [view constructSaleSubs1:dict];
    return view;
}

+ (instancetype)forBuyDetailHeaderView:(NSDictionary *)dict click:(void (^)(void))clickBlock{
    ETSaleDetailHeaderView *view = [[self alloc] init];
    view.clickBlock = clickBlock;
    [view constructSaleSubs2:dict];
    return view;
}


- (void)constructSaleSubs:(NSDictionary *)dict{
    
    self.backgroundColor = RGBCOLOR(242, 242, 242);
    
    UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sale_分组 2"]];
    imv.contentMode = UIViewContentModeScaleAspectFill;
    imv.clipsToBounds = YES;
    imv.frame = CGRectMake(0, 0, Screen_Width, kScaleX*205);
    [self addSubview:imv];
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.text = @"出售详情";
    [imv addSubview:self.labelTitle];
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imv);
        make.top.mas_equalTo(StatusBarHeight+7+7+7);
    }];
    
    UIView *viewClips = [[UIView alloc] initWithFrame:CGRectMake(15*kScaleX, 150*kScaleX, Screen_Width-15*kScaleX*2, 200)];
    viewClips.clipsToBounds = YES;
    viewClips.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewClips];
    
    imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sale_矩形"]];
    imv.contentMode = UIViewContentModeScaleAspectFill;
    imv.clipsToBounds = YES;
    imv.frame = CGRectMake(0, kScaleX*15, kScaleX*9, kScaleX*20);
    [viewClips addSubview:imv];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines=0;
    label.font = [UIFont systemFontOfSize:15*kScaleX weight:UIFontWeightMedium];
    
//    label.center = CGPointMake(label.center.x, imv.center.y);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBCOLOR(51, 51, 51);
    label.text = [MySingleton filterNull:dict[@"title"]];
    if (label.text.length>20) {
        label.textAlignment = NSTextAlignmentLeft;
    }
    [viewClips addSubview:label];
    label.frame = CGRectMake(kScaleX*45, imv.origin.y, viewClips.frame.size.width-kScaleX*45*2, [self textHeightWithText:label.text font:label.font maxW:viewClips.frame.size.width-kScaleX*45*2]);
    
    CGFloat yTemp = CGRectGetMaxY(label.frame);
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15*kScaleX weight:UIFontWeightMedium];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, yTemp+kScaleX*20, viewClips.frame.size.width, label.font.lineHeight);
    label.text = @"期望价格";
    label.textColor = RGBCOLOR(204, 204, 204);
    [viewClips addSubview:label];
    
    yTemp = CGRectGetMaxY(label.frame);
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:30*kScaleX weight:UIFontWeightMedium];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, yTemp+kScaleX*20, viewClips.frame.size.width, label.font.pointSize);
    NSString*str=[MySingleton filterNull:dict[@"price"]];
    double a=[str doubleValue];
    if (a>=10000.0) {
        label.text = [NSString stringWithFormat:@"¥%.3f万元",a/10000.0];
        label.text=[label.text stringByReplacingOccurrencesOfString:@".000" withString:@""];
    }
    else
    {
        float pp =[str floatValue];
        int myint=[str longLongValue];
        if ((pp-myint)>0) {
            NSString* ppp=[NSString stringWithFormat:@"¥%.2f元",pp];
            label.text = ppp;
        }
        else{
        NSString* ppp=[NSString stringWithFormat:@"¥%.3f元",pp];
            ppp=[ppp stringByReplacingOccurrencesOfString:@".000" withString:@""];
        label.text = ppp;
        }
    }
//    label.text = [NSString stringWithFormat:@"¥%.2f万",a/10000.0];
    label.textColor = RGBCOLOR(248, 124, 43);
    [viewClips addSubview:label];
    
    yTemp = CGRectGetMaxY(label.frame)+kScaleX*12*2;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"sale_分组 3"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, yTemp, 250*kScaleX, 40*kScaleX);
    btn.center = CGPointMake(label.center.x, btn.center.y);
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [viewClips addSubview:btn];
    
    yTemp = CGRectGetMaxY(btn.frame)+kScaleX*14;
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12*kScaleX weight:UIFontWeightMedium];
    label.text = @"提示：易转只作为商品信息发布平台，建议交易双方私下签订转让协议或服务协议，易转不承担任何交易风险。";
    label.textColor = [UIColor redColor];
    label.numberOfLines = 0;
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(viewClips.frame.size.width-15*kScaleX*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    label.frame = CGRectMake(15*kScaleX, yTemp, size.width, size.height);
    [viewClips addSubview:label];
    
    CGRect rect = viewClips.frame;
    rect.size.height = CGRectGetMaxY(label.frame)+15*kScaleX;
    viewClips.frame = rect;
    viewClips.layer.cornerRadius = 5*kScaleX;
    
    self.frame = CGRectMake(0, 0, Screen_Width, CGRectGetMaxY(viewClips.frame));
}

- (void)constructSaleSubs1:(NSDictionary *)dict{
    
    self.backgroundColor = RGBCOLOR(242, 242, 242);
    
    UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sale_分组 2"]];
    imv.contentMode = UIViewContentModeScaleAspectFill;
    imv.clipsToBounds = YES;
    imv.frame = CGRectMake(0, 0, Screen_Width, kScaleX*205);
    [self addSubview:imv];
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.text = @"服务详情";
    [imv addSubview:self.labelTitle];
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imv);
        make.top.mas_equalTo(StatusBarHeight+7+7+7);
    }];
    
    UIView *viewClips = [[UIView alloc] initWithFrame:CGRectMake(15*kScaleX, 150*kScaleX, Screen_Width-15*kScaleX*2, 200)];
    viewClips.clipsToBounds = YES;
    viewClips.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewClips];
    
    imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sale_矩形"]];
    imv.contentMode = UIViewContentModeScaleAspectFill;
    imv.clipsToBounds = YES;
    imv.frame = CGRectMake(0, kScaleX*15, kScaleX*9, kScaleX*20);
    [viewClips addSubview:imv];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines=0;
    label.font = [UIFont systemFontOfSize:15*kScaleX weight:UIFontWeightMedium];
    
//    label.center = CGPointMake(label.center.x, imv.center.y);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBCOLOR(51, 51, 51);
    label.text = [MySingleton filterNull:dict[@"title"]];
    if (label.text.length>20) {
        label.textAlignment = NSTextAlignmentLeft;
    }

    label.frame = CGRectMake(kScaleX*45, imv.origin.y, viewClips.frame.size.width-kScaleX*45*2, [self textHeightWithText:label.text font:label.font maxW:viewClips.frame.size.width-kScaleX*45*2]);
    [viewClips addSubview:label];
    
    CGFloat yTemp = CGRectGetMaxY(label.frame);
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15*kScaleX weight:UIFontWeightMedium];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, yTemp+kScaleX*20, viewClips.frame.size.width, label.font.lineHeight);
    label.text = @"期望价格";
    label.textColor = RGBCOLOR(204, 204, 204);
    [viewClips addSubview:label];
    
    yTemp = CGRectGetMaxY(label.frame);
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:30*kScaleX weight:UIFontWeightMedium];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, yTemp+kScaleX*20, viewClips.frame.size.width, label.font.pointSize);
    NSString*str=[MySingleton filterNull:dict[@"price"]];
    double a=[str doubleValue];
    if (a>=10000.0) {
        label.text = [NSString stringWithFormat:@"¥%.3f万元",a/10000.0];
        label.text=[label.text stringByReplacingOccurrencesOfString:@".000" withString:@""];
    }
    else
    {
        float pp =[str floatValue];
        int myint=[str longLongValue];
        if ((pp-myint)>0) {
            NSString* ppp=[NSString stringWithFormat:@"¥%.2f元",pp];
            label.text = ppp;
        }
        else{
            NSString* ppp=[NSString stringWithFormat:@"¥%.3f元",pp];
            ppp=[ppp stringByReplacingOccurrencesOfString:@".000" withString:@""];
            label.text = ppp;
        }
    }
    //    label.text = [NSString stringWithFormat:@"¥%.2f万",a/10000.0];
    label.textColor = RGBCOLOR(248, 124, 43);
    [viewClips addSubview:label];
    
    yTemp = CGRectGetMaxY(label.frame)+kScaleX*12*2;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"sale_分组 3"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, yTemp, 250*kScaleX, 40*kScaleX);
    btn.center = CGPointMake(label.center.x, btn.center.y);
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [viewClips addSubview:btn];
    
    yTemp = CGRectGetMaxY(btn.frame)+kScaleX*14;
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12*kScaleX weight:UIFontWeightMedium];
    label.text = @"提示：易转只作为商品信息发布平台，建议交易双方私下签订转让协议或服务协议，易转不承担任何交易风险。";
    label.textColor = [UIColor redColor];
    label.numberOfLines = 0;
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(viewClips.frame.size.width-15*kScaleX*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    label.frame = CGRectMake(15*kScaleX, yTemp, size.width, size.height);
    [viewClips addSubview:label];
    
    CGRect rect = viewClips.frame;
    rect.size.height = CGRectGetMaxY(label.frame)+15*kScaleX;
    viewClips.frame = rect;
    viewClips.layer.cornerRadius = 5*kScaleX;
    
    self.frame = CGRectMake(0, 0, Screen_Width, CGRectGetMaxY(viewClips.frame));
}

- (void)constructSaleSubs2:(NSDictionary *)dict{
    
    self.backgroundColor = RGBCOLOR(242, 242, 242);
    
    UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"求购详情 copy_分组 2"]];
    imv.contentMode = UIViewContentModeScaleAspectFill;
    imv.clipsToBounds = YES;
    imv.frame = CGRectMake(0, 0, Screen_Width, kScaleX*205);
    [self addSubview:imv];
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.text = @"求购详情";
    [imv addSubview:self.labelTitle];
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imv);
        make.top.mas_equalTo(StatusBarHeight+7+7+7);
    }];
    
    UIView *viewClips = [[UIView alloc] initWithFrame:CGRectMake(15*kScaleX, 150*kScaleX, Screen_Width-15*kScaleX*2, 200)];
    viewClips.clipsToBounds = YES;
    viewClips.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewClips];
    
    imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sale_矩形"]];
    imv.contentMode = UIViewContentModeScaleAspectFill;
    imv.clipsToBounds = YES;
    imv.frame = CGRectMake(0, kScaleX*15, kScaleX*9, kScaleX*20);
    [viewClips addSubview:imv];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines=0;
    label.font = [UIFont systemFontOfSize:15*kScaleX weight:UIFontWeightMedium];
    
    //    label.center = CGPointMake(label.center.x, imv.center.y);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBCOLOR(51, 51, 51);
    label.text = [MySingleton filterNull:dict[@"title"]];
    label.frame = CGRectMake(kScaleX*45, imv.origin.y, viewClips.frame.size.width-kScaleX*45*2, [self textHeightWithText:label.text font:label.font maxW:viewClips.frame.size.width-kScaleX*45*2]);
    [viewClips addSubview:label];
    
    CGFloat yTemp = CGRectGetMaxY(label.frame);
//    label = [[UILabel alloc] init];
//    label.font = [UIFont systemFontOfSize:15*kScaleX weight:UIFontWeightMedium];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.frame = CGRectMake(0, yTemp+kScaleX*20, viewClips.frame.size.width, label.font.lineHeight);
//    label.text = @"期望价格";
//    label.textColor = RGBCOLOR(204, 204, 204);
//    [viewClips addSubview:label];
    
    yTemp = CGRectGetMaxY(label.frame);
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16*kScaleX weight:UIFontWeightMedium];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake((viewClips.frame.size.width-120)/2, yTemp+kScaleX*20, 120, label.font.pointSize+20);
    
    NSString* temp = [MySingleton filterNull:dict[@"serviceId"]];
    if ([temp isEqualToString:@"0"]||!temp)
    {
        label.text=@"企业流转";
    }
    else
        label.text=@"企业服务";
//    NSString*str=[MySingleton filterNull:dict[@"price"]];
//    double a=[str doubleValue];
//    if (a>=10000.0) {
//        label.text = [NSString stringWithFormat:@"¥%.0f万元",a/10000.0];
//    }
//    else
//    {
//        float pp =[str floatValue];
//        int myint=[str longLongValue];
//        if ((pp-myint)>0) {
//            NSString* ppp=[NSString stringWithFormat:@"¥%.2f元",pp];
//            label.text = ppp;
//        }
//        else{
//            NSString* ppp=[NSString stringWithFormat:@"¥%.0f元",pp];
//            label.text = ppp;
//        }
//    }
    //    label.text = [NSString stringWithFormat:@"¥%.2f万",a/10000.0];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor=RGBCOLOR(40, 136, 242);
    label.layer.cornerRadius=3;
    label.layer.masksToBounds=YES;
    [viewClips addSubview:label];
    
//    yTemp = CGRectGetMaxY(label.frame)+kScaleX*12*2;
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:[UIImage imageNamed:@"sale_分组 3"] forState:UIControlStateNormal];
//    btn.frame = CGRectMake(0, yTemp, 250*kScaleX, 40*kScaleX);
//    btn.center = CGPointMake(label.center.x, btn.center.y);
//    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
//    [viewClips addSubview:btn];
    
    yTemp = CGRectGetMaxY(label.frame)+kScaleX*14;
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12*kScaleX weight:UIFontWeightMedium];
    label.text = @"提示：易转只作为商品信息发布平台，建议交易双方私下签订转让协议或服务协议，易转不承担任何交易风险。";
    label.textColor = [UIColor redColor];
    label.numberOfLines = 0;
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(viewClips.frame.size.width-15*kScaleX*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    label.frame = CGRectMake(15*kScaleX, yTemp, size.width, size.height);
    [viewClips addSubview:label];
    
    CGRect rect = viewClips.frame;
    rect.size.height = CGRectGetMaxY(label.frame)+15*kScaleX;
    viewClips.frame = rect;
    viewClips.layer.cornerRadius = 5*kScaleX;
    
    self.frame = CGRectMake(0, 0, Screen_Width, CGRectGetMaxY(viewClips.frame));
}

- (void)clickAction{
    if(self.clickBlock){
        self.clickBlock();
    }
}

- (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxWidth{
    NSString *temp = text;
    if (![MySingleton filterNull:temp]) {
        temp = @"";
    }
    CGSize size = [temp boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}

@end

@interface ETSaleCollectBtn : UIButton

@end

@implementation ETSaleCollectBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat left = (contentRect.size.width-19)/2;
    CGFloat top = 6;
    return CGRectMake(left, top, 19, 19);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat height = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium].lineHeight;
    return CGRectMake(0, contentRect.size.height-5-height, contentRect.size.width, height);
}

@end

@interface ETSaleTelBtn : UIButton

@end

@implementation ETSaleTelBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    NSString *title = [self titleForState:UIControlStateNormal];
    CGFloat left = 0;
    CGFloat top = (50-20)/2;
    UIFont *font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    if (title) {
        CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        left = (contentRect.size.width-size.width-6-20)/2;
    }
    return CGRectMake(left, top, 20, 18);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    NSString *title = [self titleForState:UIControlStateNormal];
    CGFloat left = 0;
    UIFont *font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    CGFloat top = (50-font.lineHeight)/2;
    CGSize size = CGSizeZero;
    if (title) {
        size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        left = (contentRect.size.width-size.width-6-20)/2;
        left = contentRect.size.width-size.width-left;
    }
    return CGRectMake(left, top, size.width, size.height);
}

@end

@interface ETSaleDetailBotToolView ()
@property (nonatomic,copy) void (^clickBlock)(NSInteger clickTag);

@property (nonatomic,strong) ETSaleCollectBtn *btnCollect;
@property (nonatomic,strong) ETSaleTelBtn *btnChat;
@property (nonatomic,strong) ETSaleTelBtn *btnTel;
@end

@implementation ETSaleDetailBotToolView

- (instancetype)init{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, Screen_Height-50-BottomSafeHeightGap, Screen_Width, 50);
        self.backgroundColor = [UIColor whiteColor];
        
        self.btnCollect = [ETSaleCollectBtn buttonWithType:UIButtonTypeCustom];
        [self.btnCollect setImage:[UIImage imageNamed:@"sale_已收藏"] forState:UIControlStateSelected];
        [self.btnCollect setImage:[UIImage imageNamed:@"sale_收藏"] forState:UIControlStateNormal];
        self.btnCollect.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.btnCollect setTitleColor:RGBCOLOR(195, 195, 195) forState:UIControlStateNormal];
        [self.btnCollect setTitleColor:RGBCOLOR(248, 124, 43) forState:UIControlStateNormal];
        [self.btnCollect setTitle:@"收藏" forState:UIControlStateNormal];
        [self.btnCollect setTitle:@"收藏" forState:UIControlStateSelected];
        self.btnCollect.frame = CGRectMake(Screen_Width/6-30, 0, 59*kScaleX, 50);
        [self.btnCollect addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnCollect];
        self.btnCollect.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.btnCollect.tag = 1;
        
        //
        self.btnChat = [ETSaleCollectBtn buttonWithType:UIButtonTypeCustom];
//        [self.btnChat setImage:[UIImage imageNamed:@"sale_聊天 copy"] forState:UIControlStateSelected];
        [self.btnChat setImage:[UIImage imageNamed:@"sale_聊天 copy"] forState:UIControlStateNormal];
        self.btnChat.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.btnChat setTitleColor:RGBCOLOR(195, 195, 195) forState:UIControlStateNormal];
        [self.btnChat setTitleColor:RGBCOLOR(248, 124, 43) forState:UIControlStateNormal];
        [self.btnChat setTitle:@"在线聊天" forState:UIControlStateNormal];
        [self.btnChat setTitle:@"收藏" forState:UIControlStateSelected];
        self.btnChat.frame = CGRectMake( Screen_Width/3+Screen_Width/6-79,0, 159*kScaleX, 50);
        [self.btnChat addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnChat];
        self.btnChat.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.btnChat.tag = 2;
        //
        
//        self.btnChat = [ETSaleTelBtn buttonWithType:UIButtonTypeCustom];
//        [self.btnChat setImage:[UIImage imageNamed:@"sale_聊天"] forState:UIControlStateNormal];
//        self.btnChat.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
//        self.btnChat.backgroundColor = RGBCOLOR(164, 199, 245);
//        [self.btnChat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.btnChat setTitle:@"在线聊天" forState:UIControlStateNormal];
//        self.btnChat.frame = CGRectMake(CGRectGetMaxX(self.btnCollect.frame), 0, 158*kScaleX, 50);
//        [self.btnChat addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.btnChat];
//        self.btnChat.tag = 2;
        
        self.btnTel = [ETSaleCollectBtn buttonWithType:UIButtonTypeCustom];
//        [self.btnTel setImage:[UIImage imageNamed:@"sale_已收藏"] forState:UIControlStateSelected];
        [self.btnTel setImage:[UIImage imageNamed:@"sale_电话 copy"] forState:UIControlStateNormal];
        self.btnTel.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.btnTel setTitleColor:RGBCOLOR(195, 195, 195) forState:UIControlStateNormal];
        [self.btnTel setTitleColor:RGBCOLOR(248, 124, 43) forState:UIControlStateNormal];
        [self.btnTel setTitle:@"拨打电话" forState:UIControlStateNormal];
        [self.btnTel setTitle:@"收藏" forState:UIControlStateSelected];
        self.btnTel.frame = CGRectMake(Screen_Width-Screen_Width/6-79,0, 159*kScaleX, 50);
        [self.btnTel addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnTel];
        self.btnTel.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.btnTel.tag = 3;
        
        
//        self.btnTel = [ETSaleTelBtn buttonWithType:UIButtonTypeCustom];
//        [self.btnTel setImage:[UIImage imageNamed:@"sale_电话"] forState:UIControlStateNormal];
//        self.btnTel.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
//        self.btnTel.backgroundColor = RGBCOLOR(47, 134, 251);
//        [self.btnTel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.btnTel setTitle:@"拨打电话" forState:UIControlStateNormal];
//        self.btnTel.frame = CGRectMake(CGRectGetMaxX(self.btnChat.frame), 0, 158*kScaleX, 50);
//        [self.btnTel addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.btnTel];
//        self.btnTel.tag = 3;
        
        UserInfoModel* info=[UserInfoModel loadUserInfoModel];
        if (!info.vip) {
            UIView* view=[[UIView alloc] init];
            view.backgroundColor=[UIColor redColor];
            UILabel* lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-20, 30)];
            lab.font=[UIFont systemFontOfSize:18];
            lab.textAlignment=UITextAlignmentCenter;
            lab.text=@"开通平台VIP,享受会员待遇";
            [lab setTextColor:[UIColor whiteColor]];
            [view addSubview:lab];
            UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            
                [view addGestureRecognizer:tapGesturRecognizer];
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self);
                make.width.height.mas_equalTo(self);
                make.bottom.mas_equalTo(self);
            }];
            
        }
    }
    return self;
}
-(void)tapAction:(id)tap
{
    if (self.blockvip) {
        self.blockvip();
    }
}
- (void)clickAction:(UIButton *)btn{
    if (self.clickBlock) {
        self.clickBlock(btn.tag);
    }
}

- (void)refreshIsCollected:(BOOL)isCollected{
    self.btnCollect.selected = isCollected;
}

+ (instancetype)detailBotToolView:(void (^)(NSInteger))clickBlock{
    ETSaleDetailBotToolView *view = [[self alloc] init];
    view.clickBlock = clickBlock;
    return view;
}
@end

@interface ETSaleAndServiceDetailCell ()

@property (nonatomic,strong) UIView *viewBack;
@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *labelSubTitle;
@property (nonatomic,strong) UIImageView *imvLine;
@property (nonatomic,strong) UIImageView *imvIndi;

@end

@implementation ETSaleAndServiceDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGBCOLOR(242, 242, 242);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.viewBack = [[UIView alloc] initWithFrame:CGRectMake(15*kScaleX, 0, Screen_Width-15*kScaleX*2, 10)];
        self.viewBack.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.viewBack];
        
        self.labelTitle = [[UILabel alloc] init];
        self.labelTitle.font = [UIFont systemFontOfSize:13];
        self.labelTitle.textColor = RGBCOLOR(51, 51, 51);
        self.labelTitle.frame = CGRectMake(CGRectGetMinX(self.viewBack.frame)+15*kScaleX, 10*kScaleX, self.viewBack.frame.size.width-15*kScaleX*2, self.labelTitle.font.lineHeight);
        [self.contentView addSubview:self.labelTitle];
        
        self.labelSubTitle = [[UILabel alloc] init];
        self.labelSubTitle.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        self.labelSubTitle.textColor = RGBCOLOR(51, 51, 51);
        [self.contentView addSubview:self.labelSubTitle];
        
        self.imvLine = [[UIImageView alloc] init];
        self.imvLine.backgroundColor = self.backgroundColor;
        [self.contentView addSubview:self.imvLine];
        
        self.imvIndi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sale_进入"]];
        [self.contentView addSubview:self.imvIndi];
    }
    return self;
}

- (void)resetDataWithDict:(NSDictionary *)dict{
    NSInteger radiusState = [dict[@"radiusState"] integerValue];
    NSInteger lines = [dict[@"lines"] integerValue];
    BOOL isBlue = [dict[@"isBlue"] boolValue];
    CGFloat subHeight = [dict[@"subHeight"] doubleValue];
//    if (lines == 1) {
//        subHeight = self.labelSubTitle.font.lineHeight;
//    }
//    if (lines > 1) {
//        subHeight = (self.labelSubTitle.font.lineHeight+5)*lines;
//    }
    //radiusState，0，表示上面有圆角，1，表示无圆角，2表示下面有圆角 3,表示右侧有箭头
    self.imvIndi.hidden = (radiusState<3);
    self.imvLine.hidden = (radiusState==2);
    self.labelSubTitle.numberOfLines = lines;
    self.labelSubTitle.textColor = isBlue?RGBCOLOR(47, 134, 251):RGBCOLOR(51, 51, 51);
    self.labelTitle.text = dict[@"title"];
    self.labelSubTitle.text = dict[@"subTitle"];
    self.labelSubTitle.frame = CGRectMake(CGRectGetMinX(self.labelTitle.frame), CGRectGetMaxY(self.labelTitle.frame)+10*kScaleX, self.labelTitle.frame.size.width, subHeight);
    
    CGRect rect = self.viewBack.frame;
    rect.size.height = CGRectGetMaxY(self.labelSubTitle.frame)+10*kScaleX+1;
    self.viewBack.layer.cornerRadius = radiusState!=1?5*kScaleX:0;
    if (radiusState == 0) {
        rect.size.height = rect.size.height+30;
        rect.origin.y = 0;
    }
    else if (radiusState == 2){
        rect.size.height = rect.size.height+30;
        rect.origin.y = -30;
    }
    self.viewBack.frame = rect;
    
}

+ (instancetype)saleAndServiceDetailCell:(UITableView *)tableView model:(NSDictionary *)dict{
    ETSaleAndServiceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETSaleAndServiceDetailCell"];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ETSaleAndServiceDetailCell"];
    }
    [cell resetDataWithDict:dict];
    return cell;
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.imvLine.frame = CGRectMake(CGRectGetMinX(self.viewBack.frame)+15*kScaleX, self.frame.size.height-1, self.labelTitle.frame.size.width, 1);
    self.imvIndi.frame = CGRectMake(CGRectGetMaxX(self.viewBack.frame)-15*kScaleX-6, (self.frame.size.height-16)/2, 6, 16);
}

+ (CGFloat)cellHeight{
    return 10*kScaleX+[UIFont systemFontOfSize:13].lineHeight+10*kScaleX+[UIFont systemFontOfSize:15 weight:UIFontWeightMedium].lineHeight+10*kScaleX+1;
}

+ (CGFloat)cellHeightLines:(NSString *)string{
    NSString *temp = [MySingleton filterNull:string];
    if (!temp) {
        temp = @"";
    }
    CGSize size = [temp boundingRectWithSize:CGSizeMake(Screen_Width-15*kScaleX*2*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]} context:nil].size;
    size.height = MAX(size.height, [UIFont systemFontOfSize:15 weight:UIFontWeightMedium].lineHeight);
    return 10*kScaleX+[UIFont systemFontOfSize:13].lineHeight+10*kScaleX+size.height+10*kScaleX+1;
}
@end
