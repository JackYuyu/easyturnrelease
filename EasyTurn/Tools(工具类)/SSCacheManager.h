//
//  SSCacheManager.h
//  SSJewelry
//
//  Created by sszb on 2018/11/19.
//  Copyright © 2018 Song. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 首次安装App或更新 */
#define kConfigIsInstallorUpdate  @"kConfigIsInstallorUpdate"

#define kCacheImageDir           @"Image"
#define kCacheDataDir            @"Data"
#define kCacheConfigDir          @"Config"

#define kConfigVersion           @"kConfigVersion"
#define kConfigAppState          @"kConfigAppState"         //app 是否从进入后台的标记 0 没有 1 进入过

#define kPushDeviceid            @"kPushDeviceid"
#define kToken                   @"kToken"

#ifndef kUpdateAppDate
#define kUpdateAppDate           @"kUpdateAppDate"
#endif

typedef NS_ENUM(NSUInteger, SSCacheDirType) {
    SSCacheDirTypeDocument,
    SSCacheDirTypeLibrary,
    SSCacheDirTypeCache,
};

@interface SSCacheManager : NSObject

/** 首次安装App或更新 */
+ (BOOL)isInstallorUpdate;
+ (void)setIsInstallorUpdate:(BOOL)flag;

#pragma mark - init

/** App 主 Cache 单例 */
+ (instancetype)sharedCacheManagerForApp;

#pragma mark - 基本参数
/** 当前版本号 */
- (NSString *)currentConfigVersion;
- (void)setConfigVersion:(NSString *)version;

#pragma mark - 清除 cookies
+ (BOOL)cleanWebCookies;

#pragma mark - 缓存读写 (getCacheDir路径)
/**
 是否存在缓存文件
 
 @param dirName 文件夹名称(多级拼接)
 @param fileName 文件名(自动 MD5)
 @return 文件全路径
 */
- (NSString *)isExistCacheWithDirName:(NSString *)dirName fileName:(NSString *)fileName;

/**
 是否存在缓存文件
 
 @param dirName 文件夹名称(多级拼接)
 @return 文件夹全路径
 */
- (NSString *)isExistCacheDirWithDirName:(NSString *)dirName;

/**
 读取缓存文件
 
 @param dirName 文件夹名称(多级拼接)
 @param fileName 文件名(自动 MD5)
 @return 文件数据
 */
- (NSData *)loadCacheWithDirName:(NSString *)dirName fileName:(NSString *)fileName;

/**
 获取缓存的字典
 
 @param dirName 文件夹名称(多级拼接)
 @param fileName 文件名(自动 MD5)
 @return 文件字典数据
 */
- (NSDictionary *)loadCacheDictionaryWithDirName:(NSString *)dirName fileName:(NSString *)fileName;

/**
 保存缓存
 
 @param dirName 文件夹名称(多级拼接)
 @param fileName 文件名(自动 MD5)
 @param data 文件数据
 @return 是否成功
 */
- (BOOL)saveCacheWithDirName:(NSString *)dirName fileName:(NSString *)fileName data:(NSData *)data;

/**
 保存字典到缓存文件
 
 @param dirName 文件夹名称(多级拼接)
 @param fileName 文件名(自动 MD5)
 @param dataDict 文件字典数据
 @return 是否成功
 */
- (BOOL)saveCacheWithDirName:(NSString *)dirName fileName:(NSString *)fileName dictionary:(NSDictionary *)dataDict;

/**
 清除指定目录下的全部缓存
 
 @param dirName 文件夹名称(多级拼接)
 @return 是否成功
 */
- (BOOL)clearAllCacheWithDirName:(NSString *)dirName;

/**
 清除指定类型的缓存
 
 @param dirName 文件夹名称(多级拼接)
 @param fileName 文件名(自动 MD5)
 @return 是否成功
 */
- (BOOL)clearCacheFileWithDirName:(NSString *)dirName fileName:(NSString *)fileName;

/**
 移动文件到另一个位置(重命名)
 
 @param dirName 原文件文件夹名称(多级拼接)
 @param fileName 原文件名(自动 MD5)
 @param toDirName 目标文件夹名称(多级拼接)
 @param toFileName 目标文件(自动 MD5)
 @return 是否成功
 */
- (BOOL)moveCacheFileWithDirName:(NSString *)dirName fileName:(NSString *)fileName toDirName:(NSString *)toDirName toFileName:(NSString *)toFileName;

/**
 创建文件夹
 
 @param dirName 文件夹名称(多级拼接)
 @return 是否成功
 */
- (BOOL)createCacheDirWithDirName:(NSString *)dirName;

/**
 在 cache 内创建一个空文件
 默认文件名 MD5
 
 @param dirName 文件夹名称(可以多级拼接)
 @param fileName 文件名(自动 MD5)
 @return 是否成功
 */
- (BOOL)createCacheFileWithDirName:(NSString *)dirName fileName:(NSString *)fileName;

#pragma mark - 缓存目录 (getCacheDir)

/**
 获取缓存文件路径
 
 @param dirName 文件所在文件夹(多级拼接)
 @param fileName 文件名称
 @return 文件全路径
 */
- (NSString *)getCacheFilePathWithDirName:(NSString *)dirName fileName:(NSString *)fileName;

/**
 获取缓存目录路径
 
 @param dirName 文件夹名称(可拼接多级文件夹)
 @return 文件夹所在 cache 的全路径
 */
- (NSString *)getCacheDirPathWithDirName:(NSString *)dirName;

#pragma mark - 文件读写 (系统基础路径)

/**
 是否存在文件
 
 @param filePath 文件全路径
 @return 文件全路径
 */
- (NSString *)isExistAtFilePath:(NSString *)filePath;

/**
 是否存在目录
 
 @param dirPath 目录全路径
 @return 目录全路径
 */
- (NSString *)isExistAtDirPath:(NSString *)dirPath;

/**
 删除指定文件
 
 @param dirPath 目录全路径
 @param fileName 文件名
 @return 是否成功
 */
- (BOOL)clearFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName;

/**
 删除指定文件夹
 
 @param dirPath 文件夹全路径
 @return 是否成功
 */
- (BOOL)clearDirPath:(NSString *)dirPath;


/**
 加载文件
 
 @param dirPath 文件夹全路径
 @param fileName 文件名
 @return 文件内容
 */
- (NSData *)loadFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName;

/**
 加载文件
 
 @param dirPath 文件夹全路径
 @param fileName 文件名
 @return 文件字典内容
 */
- (NSDictionary *)loadFileDictionaryWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName;

/**
 保存文件
 
 @param dirPath 文件夹全路径
 @param fileName 文件名
 @param data 文件数据
 @return 是否成功
 */
- (BOOL)saveFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName data:(NSData *)data;

/**
 保存字典文件
 
 @param dirPath 文件夹全路径
 @param fileName 文件名
 @param dataDict 文件字典数据
 @return 是否成功
 */
- (BOOL)saveFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName dictionary:(NSDictionary *)dataDict;

/**
 创建文件夹
 
 @param dirPath 文件夹全路径
 @return 是否成功
 */
- (BOOL)createDirWithDirPath:(NSString *)dirPath;


/**
 创建文件
 
 @param dirPath 文件夹全路径
 @param fileName 文件名
 @return 是否成功
 */
- (BOOL)createFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName;

/**
 移动指定文件到另一个指定位置
 (可以作为重命名方法)
 
 @param dirPath 原文件所在目录全路径
 @param fileName 原文件名
 @param toDirPath 目标文件的目录全路径
 @param toFileName 目标文件名
 @return 是否成功
 */
- (BOOL)moveFileWithDirPath:(NSString *)dirPath fileName:(NSString *)fileName toDirPath:(NSString *)toDirPath toFileName:(NSString *)toFileName;

/**
 判断是否是文件
 
 @param strPath 全路径
 @return 是否是文件
 */
- (BOOL)isFileAtPath:(NSString *)strPath;

/**
 判断是否是文件夹
 
 @param strPath 全路径
 @return 是否是文件夹
 */
- (BOOL)isDirectoryAtPath:(NSString *)strPath;
@end

NS_ASSUME_NONNULL_END
