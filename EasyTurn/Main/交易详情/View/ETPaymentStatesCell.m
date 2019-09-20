//
//  ETPaymentStatesCell.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/5.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETPaymentStatesCell.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WechatAuthSDK.h"
#import "WXApiObject.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "APAuthInfo.h"
#import "APRSASigner.h"
#import "UserInfoModel.h"
#import "SSPayUtils.h"
#define kOrderId @"OrderId"
@interface ETPaymentStatesCell()

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *labelSubTitle;
@property (nonatomic,strong) UIImageView *imvLine;
@property (nonatomic,strong) ETProductModel *model;
@end

@implementation ETPaymentStatesCell

+ (CGFloat)cellHeight{
    return 50;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat cellH = [ETPaymentStatesCell cellHeight];
        self.labelTitle = [[UILabel alloc] init];
        self.labelTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 15];
        self.labelTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self.contentView addSubview:self.labelTitle];
        self.labelTitle.frame = CGRectMake(15, 0, (Screen_Width-15*2-20)/2, cellH);
        
        self.labelSubTitle = [[UILabel alloc] init];
        self.labelSubTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 15];
        self.labelSubTitle.textAlignment = NSTextAlignmentRight;
        self.labelSubTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self.contentView addSubview:self.labelSubTitle];
        self.labelSubTitle.frame = CGRectMake(CGRectGetMaxX(self.labelTitle.frame)+20, 0, (Screen_Width-15*2-20)/2, cellH);
        
        self.imvLine = [[UIImageView alloc] init];
        self.imvLine.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        [self.contentView addSubview:self.imvLine];
    }
    return self;
}

- (void)resetWithTitle:(NSString *)title sub:(NSString *)sub indexPath:(NSIndexPath *)indexPath{
    self.labelTitle.text = title;
    if (indexPath.section == 0) {
        self.labelSubTitle.text = [NSString stringWithFormat:@"￥%@元",sub];
    }
    else{
        self.labelSubTitle.text = sub;
    }
    if (indexPath.section == 0) {
        self.labelSubTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 15];
        self.labelSubTitle.textColor = [UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
    }
    else{
        self.labelSubTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 13];
        self.labelSubTitle.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    }
    
    self.imvLine.hidden = NO;
    if (indexPath.section <= 1) {
        self.imvLine.frame = CGRectMake(15, CGRectGetMaxY(self.labelTitle.frame)-1, Screen_Width-15*2, 1);
    }
    else{
        self.imvLine.hidden = YES;
    }
}

+ (instancetype)paymentStatesCell:(UITableView *)tableView title:(NSString *)title sub:(NSString *)sub indexPath:(NSIndexPath *)indexPath{
    ETPaymentStatesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETPaymentStatesCell"];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ETPaymentStatesCell"];
    }
    [cell resetWithTitle:title sub:sub indexPath:indexPath];
    return cell;
}
@end


@interface ETPaymentStatesPriceCell()

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *labelSubTitle;
//@property (nonatomic,strong) UIButton *btnPay;
@property (nonatomic,strong) UIImageView *imvLine;
@property (nonatomic,strong) NSString* orderid;
@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,strong) UIButton * wxBtn;
@property (nonatomic,strong) UIButton * zfbBtn;
@property (nonatomic,assign) int paytype;
@property (nonatomic,strong) NSString* aliprice;

@end

@implementation ETPaymentStatesPriceCell

+ (CGFloat)cellHeight{
    return 90;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat cellH = [ETPaymentStatesPriceCell cellHeight];
        self.labelTitle = [[UILabel alloc] init];
        self.labelTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 15];
        self.labelTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self.contentView addSubview:self.labelTitle];
        self.labelSubTitle.frame = CGRectMake(45, 0, (Screen_Width-15*2-20)/2, cellH);
        
        self.labelSubTitle = [[UILabel alloc] init];
        self.labelSubTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
        self.labelSubTitle.text = @"未支付";
        self.labelSubTitle.textAlignment = NSTextAlignmentRight;
        self.labelSubTitle.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        [self.contentView addSubview:self.labelSubTitle];
        self.labelSubTitle.frame = CGRectMake(CGRectGetMaxX(self.labelTitle.frame)+20, 0, (Screen_Width-15*2-20)/2, cellH);
        
        self.btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnPay.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 13];
        self.btnPay.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        self.btnPay.clipsToBounds = YES;
        [self.btnPay setTitle:@"去支付" forState:UIControlStateNormal];
        [self.btnPay setTitleColor:kACColorBlack forState:UIControlStateNormal];
        [self.contentView addSubview:self.btnPay];
        
        self.imvLine = [[UIImageView alloc] init];
        self.imvLine.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        [self.contentView addSubview:self.imvLine];
        
        self.labelSubTitle.frame = CGRectMake(Screen_Width-15-50, 15, 50, self.labelTitle.font.lineHeight);
        self.labelTitle.frame = CGRectMake(45, 15, CGRectGetMinX(self.labelSubTitle.frame)-45, self.labelTitle.font.lineHeight);
        self.btnPay.frame = CGRectMake(CGRectGetMinX(self.labelTitle.frame), CGRectGetMaxY(self.labelTitle.frame)+10, 60, 30);
        self.btnPay.layer.cornerRadius = 2.5;
        
        self.imvLine.frame = CGRectMake(15, cellH-1, Screen_Width-15*2, 1);
        
    }
    return self;
}

- (void)resetWithPrice:(NSString *)price indexPath:(NSIndexPath *)indexPath total:(NSInteger)total order:(ETProductModel*)orderid{
    NSString *temp = @"";
    if (indexPath.row == 1) {
        temp = @"第一期，买家付金额";
    }
    else if (indexPath.row == 2){
        temp = @"第二期，买家付金额";
    }
    else{
        temp = @"第三期，买家付金额";
    }
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:temp attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [title appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@元",orderid.price] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0]}]];
    self.labelTitle.attributedText = title;
    self.imvLine.hidden = YES;
    if (indexPath.row<total) {
        self.imvLine.hidden = NO;
    }
    
    self.aliprice=orderid.price;
    [self.btnPay addTarget:self action:@selector(paySelect) forControlEvents:UIControlEventTouchUpInside];
    //自己发的订单
//    UserInfoModel* user= [UserInfoModel loadUserInfoModel];
//    if ([user.uid isEqualToString:orderid.userId])
//    {
//        self.btnPay.enabled=NO;
//    }
    if ([orderid.status isEqualToString:@"0"]) {
        [self.btnPay setTitle:@"已支付" forState:UIControlStateNormal];
        self.labelSubTitle.text=@"已支付";
        self.btnPay.enabled=NO;
    }
    
    if (orderid.orderid) {
        self.orderid=orderid.orderid;
    }
}

+ (instancetype)paymentStatesPriceCell:(UITableView *)tableView price:(NSString *)price indexPath:(NSIndexPath *)indexPath total:(NSInteger)total order:(ETProductModel*)orderid{
    ETPaymentStatesPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETPaymentStatesPriceCell"];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ETPaymentStatesPriceCell"];
    }
    [cell resetWithPrice:price indexPath:indexPath total:total order:orderid];
    return cell;
}
-(void)paySelect
{
    [self shareView];
    [self shareViewController];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.maskTheView];
    [ [UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.shareView];
}

- (void)stagepay {

        UserInfoModel* info=[UserInfoModel loadUserInfoModel];
        if ([info.isChecked isEqualToString:@"4"]) {

            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请企业法人付款" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];            
            [alter show];
            return;
        }
        //调用第三方支付前,保存支付状态值
        [SSPayUtils shareUser].State = @"begin";
        [self clickImage];
        if (_paytype==1) {
            [self alipay];
        }
        NSMutableDictionary* dic=[NSMutableDictionary new];
        NSDictionary *params = @{
                                 @"id" : self.orderid,
                                 @"type" : @(_paytype)
                                 
                                 };
        [HttpTool get:[NSString stringWithFormat:@"pay/payBuyOrderId"] params:params success:^(id responseObj) {
            
            NSString* a=responseObj[@"data"][@"result"];
            //存储订单ID
            NSString* orderId = responseObj[@"data"][@"id"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:orderId forKey:kOrderId];
            [userDefaults synchronize];
            
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[a dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            //
            NSDictionary* d=[jsonDict copy];
            [self wechatPay:d];
            NSLog(@"");
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }

- (void)alipay {
    
    NSDictionary *params = @{
                             @"id" : self.orderid,
                             @"type" : @(_paytype)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/payBuyOrderId"] params:params success:^(id responseObj) {
        //存储订单ID
        NSString* orderId = responseObj[@"data"][@"id"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:orderId forKey:kOrderId];
        [userDefaults synchronize];
        
        NSString* payOrder = responseObj[@"data"][@"result"];
        [[AlipaySDK defaultService] payOrder:payOrder fromScheme:kAppScheme callback:^(NSDictionary *resultDic) {
            
        }];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

-(void)wechatPay:(NSDictionary*)d
{
//    [self.navigationController popViewControllerAnimated:NO];
    //    NSDictionary* d=[NSDictionary new];
    //    [[WXApiObject shareInstance]WXApiPayWithParam:d];
    NSString *res = [WXApiRequestHandler jumpToBizPay:d];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
    }
}



- (UIView *)maskTheView{
    if (!_maskTheView) {
        _maskTheView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskTheView.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5];
        //添加一个点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskClickGesture)];
        [_maskTheView addGestureRecognizer:tap];//让header去检测点击手势
    }
    return _maskTheView;
}

- (void)maskClickGesture {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
    
}

- (UIView *)shareView{
    if (!_shareView) {
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-303, Screen_Width,303)];
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView;
}
- (void)shareViewController {
    UIImageView *returnImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 23, 18, 18)];
    returnImage.image=[UIImage imageNamed:@"提现_关闭"];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [returnImage addGestureRecognizer:tapGesture];
    returnImage.userInteractionEnabled = YES;
    [_shareView addSubview:returnImage];
    
    UILabel *lab=[[UILabel alloc]init];
    lab.text=@"请选择支付方式";
    lab.font=[UIFont systemFontOfSize:15];
    lab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_shareView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(133);
        make.right.mas_equalTo(-133);
        make.height.mas_equalTo(21);
    }];
    
    UIView*topView=[[UIView alloc]init];
    topView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [_shareView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *wxImg=[[UIImageView alloc]init];
    wxImg.image=[UIImage imageNamed:@"提现_微信"];
    [_shareView addSubview:wxImg];
    [wxImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(75);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *wxLab=[[UILabel alloc]init];
    wxLab.text=@"微信账户";
    wxLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_shareView addSubview:wxLab];
    [wxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(79);
        make.left.mas_equalTo(57);
        make.size.mas_equalTo(CGSizeMake(119, 21));
    }];
    
    _wxBtn=[[UIButton alloc]init];
    [_wxBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_wxBtn setImage:[UIImage imageNamed:@"注册_选中"] forState:UIControlStateSelected];
    _wxBtn.tag=0;
    [_shareView addSubview:_wxBtn];
    [_wxBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(79);
        make.right.mas_equalTo(-13);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    UIView*centerView=[[UIView alloc]init];
    centerView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [_shareView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(119);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *zfbImg=[[UIImageView alloc]init];
    zfbImg.image=[UIImage imageNamed:@"提现_支付宝"];
    [_shareView addSubview:zfbImg];
    [zfbImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(135);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *zfbLab=[[UILabel alloc]init];
    zfbLab.text=@"支付宝账户";
    zfbLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_shareView addSubview:zfbLab];
    [zfbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(139);
        make.left.mas_equalTo(57);
        make.size.mas_equalTo(CGSizeMake(134, 21));
    }];
    
    _zfbBtn=[[UIButton alloc]init];
    [_zfbBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_zfbBtn setImage:[UIImage imageNamed:@"注册_选中"] forState:UIControlStateSelected];
    _zfbBtn.tag=1;
    [_shareView addSubview:_zfbBtn];
    [_zfbBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_zfbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(139);
        make.right.mas_equalTo(-13);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    UIView*botomView=[[UIView alloc]init];
    botomView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [_shareView addSubview:botomView];
    [botomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(179);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *goPayBtn = [[UIButton alloc]init];
    goPayBtn.backgroundColor= [UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
    [goPayBtn setTitle:@"去支付" forState:UIControlStateNormal];
    goPayBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    goPayBtn.layer.cornerRadius = 12;
    [goPayBtn addTarget:self action:@selector(stagepay) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:goPayBtn];
    
    [goPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(189);
        make.left.mas_equalTo(51);
        make.right.mas_equalTo(-51);
        make.height.mas_equalTo(39);
    }];
}

- (void)clickImage {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
}

-(void)titleBtnClick:(UIButton *)btn
{
    if (btn!= _wxBtn) {
        self.wxBtn.selected = NO;
        btn.selected = YES;
        self.wxBtn = btn;
    }else{
        self.wxBtn.selected = YES;
        _paytype=2;
    }
    if (btn!= _zfbBtn) {
        self.zfbBtn.selected = NO;
        btn.selected = YES;
        self.zfbBtn = btn;
    }else{
        self.zfbBtn.selected = YES;
        _paytype=1;
    }
    //支付方式
    if (btn.tag==0) {
        _paytype=2;
    }
    if (btn.tag==1) {
        _paytype=1;
    }
}

@end
