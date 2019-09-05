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
@interface ETPaymentStatesCell()

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *labelSubTitle;
@property (nonatomic,strong) UIImageView *imvLine;
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
-(void)stagepay
{
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    if ([info.isChecked isEqualToString:@"4"]) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"员工不能支付" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
        return;
    }
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
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[a dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //
        NSDictionary* d=[jsonDict copy];
        [self wechatPay:d];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)alipay
{
    APOrderInfo* order = [APOrderInfo new];
    // NOTE: app_id设置
    NSString *appid = @"2019052665415366";
    order.app_id = appid;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"UTF-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    NSString *rsa2PrivateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCi1f2zFmPgjfOnw+d7kVCwgkHtf+CumRxkKRsNSBWktPQB/A0qdHuHfF5RoSWOzrtBHSzCDZjatgyPgoo2uhxAVB4bxrTLOIGULlsbxCC0rUEigNwSPssyn7zJLsUlXUfmxMMW26OUQ7s5sk8HWT7pDZi2jL6nUnyTbzLJO7//UgFrOe1Ngl7Fm+pwc8O7wHLqm+QX+uKs4hZ9JALW6SXGcEGzfmSH7kscVnM9DYuhQakn3gVhrbUq4GQj2bMl6B6KPlZR4OIPFlAJ87O9R6nAhThR3fJ+D9a55GgPgxbk9/Tiz3fOfte6r0wTwF3Skhl5F1fvWPNWEiO8BLtaSmqRAgMBAAECggEBAJINWfZtmLvq1qadIl1E45jN3JBHaKFyF3MHI4pwI2mOHGZDSxPPUpUdSgPxhBxo9K/cmS6cv4M8UlvN/GZF290fFbpYKgU085STV4i6C5PC6m8mIT4EMIGBoPTaDF4NItarmUhBTKFJdv6zHgs7Ux/54AWsi7zMUYxz6ptwCi/YUBWHt/+cVSYTSeN+Uve936KpPEste+QnUTO3qmxkK+p1dVdH2R/HjmEB6nc4o5YBRboAs9xTkTpS/Buol+DrE4sWUn68MK0mXYSO/Khq+ZzBG0BOfLmLflHS8XkdZO6dTo0AeEEsJEURpt32Kb5G8FZKS8aLUlekSqqU1aYtLYECgYEA4MS+s0hhR434GDMMqgv4YNMCoxxZj76QoLkMTmTXQX1Kdk6hfX2KPGkFRuU+d4dyuRYhC5t5yqtte621pAxou6At0DDxS1XqAOid0Gko0oNowzNYdQzR3aJTP7NJw0H/Aip9VvBr9vUuADxv+dfYqerFmZ+nr40rZ5ojhsRak7kCgYEAuXY8mBECKpZBocO0H0c9GCBAs8oj27m0IaOMNhHdG12wWz9i/Bp1RtW9AdUgLxUBXKuruLI7oF3Bz7jL7EmJ44lQEzPMkVxaavANIHe85R+2FktcyHH/uOAGjl1Ti0bp8bVR8KQUcIb5qX6JI3GokftXbBEALv+HUpQ2F/E7qZkCgYAckaVTkF2dBLSGDucLLh5R4EAzj0Tq+mPTqfGgfTzG/C/cvb3U/4H0j7y1+Clqc/LnB6MHoKloU0XFNJ0jztf5ETEBh1cEJlVp7Ccy+ErSBxXnybzyk8CRFTLTo+w6P0c0dUYdKM3wQ9Wm/geVkBPf9RFMp3he3eiocHUXihmhMQKBgE0l8CLZwGrywi6GeGEigzmMAR5JEg2O/G2Z2PONDssZeAkdHxH795kVxGAExjSPqldgWjike8VD+yFrn/iUxrVOI285dvloz3v4i51b8cnmHRq9EsWXFmdTWabTD7O6NgsEACf4OUBuBWEKcAW8fADt6vnbQJZMWYByguYGxWjRAoGBANxwqks45sPGzH6pi56hHD8jsVpUetZRhhc3Awr8814EQ6ULd9y10+fBGEVo3b2u/6P3n65CGkIpKKzYijDPiLX/crVKj+1eF9RsqPbX+uR2iALeptREQl5/DBWh1S8i254cfskzzlUYzdicuvooZBl3Dfe4kN+riYl2cXSnIs1s";
    
    NSString *rsaPrivateKey = nil;
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [self.aliprice floatValue]]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    //                id<DataSigner> signer =CreateRSADataSigner(privateKey);
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString!= nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
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


#pragma mark   ==============产生随机订单号==============
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
