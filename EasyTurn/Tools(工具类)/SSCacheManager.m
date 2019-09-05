//
//  SSCacheManager.m
//  SSJewelry
//
//  Created by sszb on 2018/11/19.
//  Copyright © 2018 Song. All rights reserved.
//

#import "SSCacheManager.h"
#import "NSString+AHKit.h"

@implementation SSCacheManager

#pragma mark - init
static SSCacheManager *appCacheManager = nil;
+ (instancetype)sharedCacheManagerForApp {
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        appCacheManager = [[SSCacheManager alloc] initCacheManagerForApp];
    });
    return appCacheManager;
}

- (instancetype)initCacheManagerForApp {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)init {
    NSAssert(nil, @"不要直接用 init, 使用 initCacheManagerForApp 或者 initCacheManagerForAppGroup: 来实例化");
    return nil;
}
/** 首次安装App或更新 */
+ (BOOL)isInstallorUpdate {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:kConfigIsInstallorUpdate];
}

+ (void)setIsInstallorUpdate:(BOOL)flag {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:flag forKey:kConfigIsInstallorUpdate];
    [userDefaults synchronize];
}

#pragma mark - 基本数据存储
/* 当前版本号 */
- (NSString *)currentConfigVersion{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:kConfigVersion];
}

- (void)setConfigVersion:(NSString *)version{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:version forKey:kConfigVersion];
    [userDefaults synchronize];
}

#pragma mark - 清除 cookies
+ (BOOL)cleanWebCookies {
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    return YES;
}


#pragma mark - 缓存管理 共用方法

#pragma mark - 缓存读写 (getCacheDir路径)

/**
 是否存在缓存文件
 */
- (NSString *)isExistCacheWithDirName:(NSString *)dirName fileName:(NSString *)fileName {
    
    NSString *filePath = [self getCacheFilePathWithDirName:dirName fileName:fileName];
    return [self isExistAtFilePath:filePath];
}

/**
 是否存在缓存文件夹
 */
- (NSString *)isExistCacheDirWithDirName:(NSString *)dirName {
    return [self isExistAtDirPath:[self getCacheDirPathWithDirName:dirName]];
}

/**
 读取缓存文件
 */
- (NSData *)loadCacheWithDirName:(NSString *)dirName fileName:(NSString *)fileName {
    NSString *filePath = [self isExistCacheWithDirName:dirName fileName:fileName];
    if (filePath && filePath.length > 0) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        return data;
    }
    return nil;
}

/**
 获取缓存的字典
 */
- (NSDictionary *)loadCacheDictionaryWithDirName:(NSString *)dirName fileName:(NSString *)fileName {
    NSString *filePath = [self isExistCacheWithDirName:dirName fileName:fileName];
    if (filePath && filePath.length > 0) {
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:filePath];
        return data;
    }
    return nil;
}

/**
 保存缓存
 */
- (BOOL)saveCacheWithDirName:(NSString *)dirName fileName:(NSString *)fileName data:(NSData *)data {
    NSString *dirPath = [self getCacheDirPathWithDirName:dirName];
    return [self saveFileWithDirPath:dirPath fileName:fileName.ak_md5 data:data];
}

/**
 保存字典到缓存文件
 */
- (BOOL)saveCacheWithDirName:(NSString *)dirName fileName:(NSString *)fileName dictionary:(NSDictionary *)dataDict {
    return [self saveFileWithDirPath:[self getCacheDirPathWithDirName:dirName] fileName:fileName.ak_md5 dictionary:dataDict];
}

/**
 清除指定目录下的全部缓存
 */
- (BOOL)clearAllCacheWithDirName:(NSString *)dirName {
    return [self clearDirPath:[self getCacheDirPathWithDirName:dirName]];
}

/**
 清除指定类型的缓存
 */
- (BOOL)clearCacheFileWithDirName:(NSString *)dirName fileName:(NSString *)fileName {
    return [self clearFileWithDirPath:[self getCacheDirPathWithDirName:dirName] fileName:fileName.ak_md5];
}

/**
 移动文件到另一个位置(重命名)
 */
- (BOOL)moveCacheFileWithDirName:(NSString *)dirName fileName:(NSString *)fileName toDirName:(NSString *)toDirName toFileName:(NSString *)toFileName {
    return [self moveFileWithDirPath:[self getCacheDirPathWithDirName:dirName]
                            fileName:fileName.ak_md5
                           toDirPath:[self getCacheDirPathWithDirName:toDirName]
                          toFileName:toFileName.ak_md5];
}

/**
 创建文件夹
 */
- (BOOL)createCacheDirWithDirName:(NSString *)dirName {
    return [self createDirWithDirPath:[self getCacheDirPathWithDirName:dirName]];
}

/**
 在 cache 内创建一个空文件
 */
- (BOOL)createCacheFileWithDirName:(NSString *)dirName fileName:(NSString *)fileName {
    return [self createFileWithDirPath:[self getCacheDirPathWithDirName:dirName] fileName:fileName.ak_md5];
}

#pragma mark - 缓存目录 (getCacheDir)

/**
 获取缓存文件路径
 */
- (NSString *)getCacheFilePathWithDirName:(NSString *)dirName fileName:(NSString *)fileName {
    NSString *filePath = [[self getCacheDirPathWithDirName:dirName] stringByAppendingPathComponent:fileName.ak_md5];
    return filePath;
}

/**
 获取缓存目录路径
 */
- (NSString *)getCacheDirPathWithDirName:(NSString *)dirName {
    return [self getCacheDirPathWithDirName:dirName dirType:SSCacheDirTypeCache];
}

/**
 文件夹(可拼接多级)到 type 对应的实际目录上: document, library, cache
 */
- (NSString *)getCacheDirPathWithDirName:(NSString *)dirName dirType:(SSCacheDirType)dirType {
    NSString *cachesPath = @"";

        switch (dirType) {
            case SSCacheDirTypeDocument:
                cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                break;
            case SSCacheDirTypeLibrary:
                cachesPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                break;
            case SSCacheDirTypeCache:
                cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                break;
        }
    
    //缓存目录路径
    NSString *dirPath = [cachesPath stringByAppendingPathComponent:dirName];
    return dirPath;
}

#pragma mark - 文件读写 (系统基础路径)

/**
 是否存在文件
 */
- (NSString *)isExistAtFilePath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    
    if (isExist) {
        return filePath;
    }
    
    return nil;
}

/**
 是否存在目录
 */
- (NSString *)isExistAtDirPath:(NSString *)dirPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL isExist = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    if (isExist) {
        return dirPath;
    }
    
    return nil;
}

/**
 删除指定文件
 */
- (BOOL)clearFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName {
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL isDone = [fileManager removeItemAtPath:filePath error:&error];
    return isDone;
}

/**
 删除指定文件夹
 */
- (BOOL)clearDirPath:(NSString *)dirPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL isDone = [fileManager removeItemAtPath:dirPath error:&error];
    return isDone;
}


/**
 加载文件
 */
- (NSData *)loadFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName {
    NSString *filePath = [self isExistAtFilePath:[dirPath stringByAppendingPathComponent:fileName]];
    if (filePath && filePath.length > 0) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        return data;
    }
    return nil;
}

/**
 加载字典文件
 */
- (NSDictionary *)loadFileDictionaryWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName {
    NSString *filePath = [self isExistAtFilePath:[dirPath stringByAppendingPathComponent:fileName]];
    if (filePath && filePath.length > 0) {
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:filePath];
        return data;
    }
    return nil;
}

/**
 保存文件
 */
- (BOOL)saveFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName data:(NSData *)data {
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL isExist = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    if (!isExist)
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return [data writeToFile:filePath atomically:YES];
}

/**
 保存字典文件
 */
- (BOOL)saveFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName dictionary:(NSDictionary *)dataDict {
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL isExist = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    if (!isExist)
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return [dataDict writeToFile:filePath atomically:YES];
}

/**
 创建文件夹
 */
- (BOOL)createDirWithDirPath:(NSString *)dirPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL isExist = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    if (!isExist) {
        return [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return YES;
}


/**
 创建文件
 */
- (BOOL)createFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName {
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL isDirExist = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    if (!isDirExist) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL isDirectory = NO;
    BOOL isFileExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (!isFileExist) {
        return [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    return YES;
}

/**
 移动指定文件到另一个指定位置
 (可以作为重命名方法)
 */
- (BOOL)moveFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName toDirPath:(NSString *)toDirPath toFileName:(NSString *)toFileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *sourcePath = [dirPath stringByAppendingPathComponent:fileName];
    NSString *targetPath = [toDirPath stringByAppendingPathComponent:toFileName];
    NSError *error;
    BOOL isDone = [fileManager moveItemAtPath:sourcePath toPath:targetPath error:&error];
    return isDone;
}

- (BOOL)isFileAtPath:(NSString *)strPath {
    return ![self isDirectoryAtPath:strPath];
}

- (BOOL)isDirectoryAtPath:(NSString *)strPath {
    if (!strPath.length) return NO;
    BOOL isDirectory;
    [[NSFileManager defaultManager] fileExistsAtPath:strPath isDirectory:&isDirectory];
    return isDirectory;
}
@end
