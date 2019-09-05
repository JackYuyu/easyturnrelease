//
//  SSUserLoginModel.m
//  SSJewelry
//
//  Created by sszb on 2018/11/19.
//  Copyright © 2018 Song. All rights reserved.
//

#import "SSUserLoginModel.h"
#import "AHKeychain.h"
#define kAPPAuth_Identifier       @"APPAuth_Identifier"
@implementation SSUserLoginModel
#pragma mark - 保存用户信息（用户名和密码）到钥匙串

+ (BOOL)saveLoginInfoWithUserName:(NSString *)username password:(NSString *)password {
    if (username.length == 0 || password.length == 0) {
        return NO;
    }
    SSUserLoginModel *mLogin = [[SSUserLoginModel alloc] init];
    mLogin.username = username;
    mLogin.password = password;
    
    AHKeychain *keyChain = [[AHKeychain alloc] initWithIdentifier:kAPPAuth_Identifier];
    return [keyChain save:mLogin.mj_keyValues];
}

+ (BOOL)saveLoginInfoWithUserName:(NSString *)ssoToken {
    if (ssoToken.length == 0) {
        return NO;
    }
    SSUserLoginModel *mLogin = [[SSUserLoginModel alloc] init];
    mLogin.ssoToken = ssoToken;
    
    AHKeychain *keyChain = [[AHKeychain alloc] initWithIdentifier:kAPPAuth_Identifier];
    return [keyChain save:mLogin.mj_keyValues];
}



+ (BOOL)deleteLoginInfo {
    AHKeychain *keyChain = [[AHKeychain alloc] initWithIdentifier:kAPPAuth_Identifier];
    return [keyChain deleteItem];
}

#pragma mark - 验证7天免登陆接口
+ (void)checkLoginForSevenDaysFree:(checkLogin)block {

}
@end
