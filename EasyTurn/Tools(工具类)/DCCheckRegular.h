//
//  DCCheckRegular.h
//  CDDKit
//
//  Created by 陈甸甸 on 2017/10/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCCheckRegular : NSObject
#pragma 正则校验邮箱号
+ (BOOL)dc_checkMailInput:(NSString *)mail;
#pragma 正则校验手机号
+ (BOOL)dc_checkTelNumber:(NSString *) telNumber;
#pragma 车牌号验证
+ (BOOL)dc_checkCarNumber:(NSString *) CarNumber;
#pragma 正则校验昵称
+ (BOOL)dc_checkNickname:(NSString *) nickname;
#pragma 正则校验用户密码6-18位数字和字母组合
+ (BOOL)dc_checkPassword:(NSString *) password;
#pragma 正则校验用户身份证号
+ (BOOL)dc_checkUserIdCard: (NSString *) idCard;
#pragma 正则校验员工号,12位的数字
+ (BOOL)dc_checkEmployeeNumber : (NSString *) number;
#pragma 正则校验URL
+ (BOOL)dc_checkURL : (NSString *) url;
#pragma 正则校验以C开头的18位字符
+ (BOOL)dc_checkCtooNumberTo18:(NSString *) nickNumber;
#pragma 正则校验以C开头字符
+ (BOOL)dc_checkCtooNumber:(NSString *) nickNumber;
#pragma 正则校验银行卡号是否正确
+ (BOOL)dc_checkBankNumber:(NSString *) bankNumber;
#pragma 正则只能输入数字和字母
+ (BOOL)dc_checkTeshuZifuNumber:(NSString *) CheJiaNumber;
#pragma 校验合法金额
+ (BOOL)isValidateAmount:(NSString *)amount;

@end

