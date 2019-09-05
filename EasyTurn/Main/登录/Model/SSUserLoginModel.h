//
//  SSUserLoginModel.h
//  SSJewelry
//
//  Created by sszb on 2018/11/19.
//  Copyright © 2018 Song. All rights reserved.
//

#import "STBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^checkLogin)(BOOL success, UserInfoModel *mUser, NSError *error);

@interface SSUserLoginModel : STBaseModel

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *ssoToken;
#pragma mark - 保存用户信息（用户名和密码）到钥匙串
/**
 *  获取用户身份验证model
 *
 *  @return 用户身份验证model
 */
//+ (SSUserLoginModel *)loadLoginInfo;

/**
 *  保存用户身份验证信息
 *
 *  @param username 用户名
 *  @param password 密码
 *
 *  @return 是否成功
 */
+ (BOOL)saveLoginInfoWithUserName:(NSString *)username password:(NSString *)password;

/**
 *  保存用户身份验证信息
 *
 *  @param ssoToken 登录令牌
 *
 *  @return 是否成功
 */
//+ (BOOL)saveLoginInfoWithUserName:(NSString *)ssoToken;

/**
 *  删除保存的用户身份验证信息
 *
 *  @return 是否成功
 */
+ (BOOL)deleteLoginInfo;

#pragma mark - 验证7天免登陆 接口
+ (void)checkLoginForSevenDaysFree:(checkLogin)block;

@end

NS_ASSUME_NONNULL_END
