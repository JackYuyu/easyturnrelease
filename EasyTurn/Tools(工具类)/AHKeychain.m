//
//  AHKeychain.m
//  AHKit
//
//  Created by Alan Miu on 15/10/29.
//  Copyright (c) 2015年 AutoHome. All rights reserved.
//

#import "AHKeychain.h"
#import <Security/Security.h>

@interface AHKeychain () {
    NSString *_identifier;
    NSString *_accessGroup;
}

@end

@implementation AHKeychain

- (id)initWithIdentifier:(NSString *)identifier {
    return [self initWithIdentifier:identifier accessGroup:nil];
}

- (id)initWithIdentifier:(NSString *)identifier accessGroup:(NSString *)accessGroup {
    if (self = [super init]) {
        
#if !TARGET_IPHONE_SIMULATOR
        // 模拟器无法签名不支持组
        _isSupportGroup = YES;
#endif
        
        NSLog(_isSupportGroup? @"支持" : @"不支持");
        
        _identifier = identifier;
        _accessGroup = accessGroup;
    }
    return self;
}

/**
 *  创建一个钥匙串项目
 *
 *  @return 钥匙串项目
 */
- (NSMutableDictionary *)createKeychainItem {
    
    NSMutableDictionary *keychainItem = [[NSMutableDictionary alloc] init];
    // 设置标示
    [keychainItem setObject:_identifier forKey:(__bridge id)kSecAttrAccount];
    // 设置类型
    [keychainItem setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    // 设置访问限制
    [keychainItem setObject:(__bridge id)kSecAttrAccessibleAlways forKey:(__bridge id)kSecAttrAccessible];
    // 设置组名
    if (_isSupportGroup && _accessGroup)
        [keychainItem setObject:_accessGroup forKey:(__bridge id)kSecAttrAccessGroup];
    
    return keychainItem;
}

/**
 *  读取数据
 *
 *  @return 数据 或 空
 */
- (id)load {
    NSMutableDictionary *keychainItem = [self createKeychainItem];
    // 设置返回值类型
    [keychainItem setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    // 设置查询条件
    [keychainItem setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    CFDataRef valueData = NULL;
    CFDictionaryRef cfquery = (CFDictionaryRef)CFBridgingRetain(keychainItem);
    OSStatus status = SecItemCopyMatching(cfquery, (CFTypeRef *)&valueData);
    CFRelease(cfquery);
    
    if (status == noErr) {
        @try {
            NSKeyedUnarchiver *keyedUnarchiver = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)(valueData)];
            CFRelease(valueData);
            return keyedUnarchiver;
        } @catch (NSException *exception) {} @finally {}
    }
    
    return nil;
}

/**
 *  保存数据
 *
 *  @param object 支持序列化的对象
 *
 *  @return 是否成功
 */
- (BOOL)save:(id)object {
    NSMutableDictionary *keychainItem = [self createKeychainItem];
    // 删除之前保存的数据
    SecItemDelete((__bridge CFDictionaryRef)keychainItem);
    // 保存新数据
    [keychainItem setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:(__bridge id)kSecValueData];
    return SecItemAdd((__bridge CFDictionaryRef)keychainItem, NULL);;
}

/**
 *  删除保存的 keyChain object
 *
 *  @return  是否成功
 */
- (BOOL)deleteItem {
    
    NSMutableDictionary *keychainItem = [self createKeychainItem];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)keychainItem);
    
    if (status == errSecSuccess) {
        return YES;
    } else {
        return NO;
    }
}


- (NSString *)keychainErrorToString:(OSStatus)error {
    NSString *message = [NSString stringWithFormat:@"%ld", (long)error];
    
    switch (error) {
        case errSecSuccess:
            message = @"成功";
            break;
            
        case errSecDuplicateItem:
            message = @"失败 item 已经存在";
            break;
            
        case errSecItemNotFound :
            message = @"失败 item 未找到";
            break;
            
        case errSecAuthFailed:
            message = @"失败 item 身份验证失败";
            break;
            
        default:
            break;
    }
    
    return message;
}


@end
