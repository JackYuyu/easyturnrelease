//
//  SSJewelryCore.h
//  SSJewelry
//
//  Created by sszb on 2018/9/28.
//  Copyright © 2018 Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  获取屏幕物理高度
 */
#define Screen_Height [[UIScreen mainScreen]bounds].size.height
#define Screen_Width [[UIScreen mainScreen]bounds].size.width

/**
 *  判断手机型号
 */

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define kIsFullScreenIPhone (Screen_Height == 812.f || Screen_Height == 896.f)
#define kSafeAreaBottomH ((kIsFullScreenIPhone) ? (34) : (0))
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//获取导航栏高度
#define kNavigationBarHeight (44)
//获取状态栏高度
#define kStatusBarHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
//获取导航栏+状态栏高度
#define kNavBarHeight_StateBarH ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.0 : 64.0)
//获取Tabbar高度
#define kTabBarHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)
//等比例宽高
#define CALWIDTH(num) (Screen_Width/750)*num
#define CALHEIGHT(num) (Screen_Width/750)*num
//屏幕宽高比例系数
#define kScaleX [UIScreen mainScreen].bounds.size.width / 375
#define kScaleY [UIScreen mainScreen].bounds.size.height / 667
/** 字体 */
#define kFontSize(size)              [UIFont systemFontOfSize:(size)]
#define kBoldFontSize(size)          [UIFont boldSystemFontOfSize:(size)]


/** 颜色 */
#define kACColorRed                  [UIColor redColor]
#define kACColorClear                [UIColor clearColor]
#define kACColorWhite                [UIColor whiteColor]
#define kACColorWhiteWithAlpha(a)    [kACColorWhite colorWithAlphaComponent:(a)]
#define kACColorBlack                [UIColor blackColor]
#define kACColorBlackWithAlpha(a)    [kACColorBlack colorWithAlphaComponent:(a)]

#define kACColorRGBA(r, g, b, a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kACColorRGB(r, g, b)         kACColorRGBA((r), (g), (b), 1.0)
#define kACColorRandom               kACColorRGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define kACColorBlackTypeface      kACColorRGBA((51), (51), (51), 1.0)
#define kACColorBlack_R69_G68_B68_A1     kACColorRGBA((69), (68), (68), 1.0)
#define kACColorBackground_R245_G245_B245_A1      kACColorRGBA((245), (245), (245), 1.0)
#define kACColorBackground_R240_G240_B240_A1      kACColorRGBA((240), (240), (240), 1.0)
#define kACColorNavigation_R248_G248_B248_A1      kACColorRGBA((248), (248), (248), 1.0)
#define kACColorLine_R233_G233_B233_A1           kACColorRGBA((233), (233), (233), 1.0)
#define kACColorLine_R211_G211_B211_A1           kACColorRGBA((211), (211), (211), 1.0)
#define kACColorRed_R248_G88_B88_A1               kACColorRGBA((248), (88), (88), 1.0)
#define kACColorWhite1_R242_G242_B242_A1          kACColorRGBA((242), (242), (242), 1.0)
#define kACColorGray1_R25_G25_B25_A1              kACColorRGBA((25), (25), (25), 1.0)
#define kACColorGray2_R85_G85_B85_A1              kACColorRGBA((85), (85), (85), 1.0)
#define kACColorBlue1_R40_G115_B255_A1            kACColorRGBA((40), (115), (255), 1.0)
#define kACColorGray3_R146_G146_B146_A1           kACColorRGBA((146), (146), (146), 1.0)
#define kACColorGray4_R201_G201_B201_A1           kACColorRGBA((201), (201), (201), 1.0)
#define kACColorGray_R64_G64_B64_A1           kACColorRGBA((64), (64), (64), 1.0)
#define kACColorBlue_R85_G172_B238_A1             kACColorRGBA((85), (172), (238), 1.0)
#define kACColorBlue_R20_G138_B236_A1             kACColorRGBA((20), (138), (236), 1.0)
//aler弹框按钮Hight值 //吸底按钮 蓝色（按下）
#define kACColorBlue2_R2_G154_B255_A1             kACColorRGBA((2), (154), (255), 1.0)
#define kACColorOrange                            kACColorRGBA((254), (156), (2), 1.0)
#define kACColorGreen                             kACColorRGBA((1), (39), (15), 1.0)
#define kACColorBlue_Theme                       kACColorRGBA((47), (134), (257), 1.0)
#define kACColorR64_G64_B64_A1          kACColorRGBA((64), (64), (64), 1.0)
#define kACColorR96_G96_B96_A1          kACColorRGBA((96), (96), (96), 1.0)
#define kACColorBoxSeletedOrange_R254_G213_B184_A1          kACColorRGBA((245), (213), (184), 1.0)
#define kACColorBackgroundGray                    kACColorRGBA((240), (240), (240), 1.0)
/** 字体颜色 */
#define kACColorR32_G32_B32_A1          kACColorRGBA((32), (32), (32), 1.0)
#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFangSC-Regular"
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;
// pixel
#ifndef kLinePixel
#define kLinePixel (1.0 / [UIScreen mainScreen].scale)
#endif

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;

// 系统控件适配
//#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define TopHeight     (IPHONE_X?88:64)
#define TabbarHeight  (IPHONE_X?83:(49 + 6))
#define NavBarHeight   44
#define StatusBarHeight (IPHONE_X?44:20)
#define BottomSafeHeight (IPHONE_X?34:20)
#define BottomSafeHeightGap (IPHONE_X?34:0)
//测试环境打印Log,线上环境不打印Log
#ifndef AMLog
#if DEBUG
#define AMLog(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define AMLog(id, ...)
#endif
#endif
NS_ASSUME_NONNULL_BEGIN

//获取当前版本号
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//获取当前版本的biuld
#define BIULD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取当前设备的UDID
#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]
//获取appdelelgate
#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
//获取当前Window
#define KEYWINDOW  [UIApplication sharedApplication].keyWindow
//获取AppleID
#define APPLE_ID @"1455173336"
//首页搜索,保存历史记录
#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]

/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"

/******************      支付宝支付       *************/
#define kAliPayAppID @"2018030802338491"
#define kPartner @"2088821850114891"
#define kAppScheme @"EasyTurn" // 这个值 要和URL Schemes 里面一样

/******************      高德地图       *************/
static const NSString *APIKey = @"46bbcda544ff928deaeafbee6dc08669";

/******************      微信支付       *************/
#define kWXAppID @"wx17a60f764c12eb1e"
#define kWXAppSecret @"请输入你的参数"
//商户号，填写商户对应参数
#define kWXMchID          @"1500273292"
//商户API密钥，填写相应参数
#define kWXPartnerID      @"mxQjRuxUDWcctpGgh3xDJrx478ORwh90"
//支付结果回调页面
#define kWXNotifyURL      @"请输入你的参数"
//获取服务器端支付数据地址（商户自定义）
#define kWXSpURL          @"请输入你的参数"


#define kToastErrorServer404  @"您的页面走丢了"
#define kToastErrorServerNoErrorMessage @"系统繁忙,请稍后再试"
#define kToastErrotConnection @"抱歉, 出问题了, 我们正在修复~"
#define kToastLoading         @"正在为您努力加载中~"
#define kToastLoginDisable @"登录失效, 请重新登录"

#pragma mark - ON/OFF
// 线下环境/线上环境 0:线下 1:线上
#define HostStatus 0
// 线下 测试环境
//static NSString *const devHost_Http_App = @"http://premiere.ltd:8080";
// 线上 正式环境
static NSString *const devHost_Http_App = @"https://app.yz-vip.cn";
// 线上 测试环境
//static NSString *const devHost_Http_App = @"http://192.168.1.146:8183";

//alioss地址
#define alioss @"https://yizhuanvip.oss-cn-beijing.aliyuncs.com"
//
// 屏幕尺寸定义
#define KScreenBounds [UIScreen mainScreen].bounds
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
//#define WeakSelf __weak typeof(self) weakSelf = self

// Api Path

static NSString *const pathUser = @"/user";
static NSString *const pathClassification = @"/classification";
static NSString *const pathCart = @"/cart";
static NSString *const pathOrder = @"/order";
static NSString *const pathMyInformation = @"/myInformation";
static NSString *const pathAppaddress = @"/address";
static NSString *const pathApparea = @"/area";
static NSString *const pathPay = @"/pay";
static NSString *const pathNewsReport = @"/newsReport";
static NSString *const pathMessage = @"/message";
static NSString *const pathActivity = @"/activity";
static NSString *const pathInformation = @"/information";
static NSString *const pathSpike = @"/spike";
static NSString *const pathBroadcast = @"/broadcast";
static NSString *const pathRelease = @"/release";
@interface SSJewelryCore : NSObject

/* 是否有效点击 */
+ (BOOL)isValidClick;
+ (BOOL)isValidClick:(NSTimeInterval)intervalTime;

#pragma mark - 图片处理
/** 使用颜色生成图片 **/
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

+ (UIImage *)resizableImageWithColor:(UIColor *)color;

+ (UIImage *)resizableImageWithColor:(UIColor *)color initialSize:(CGSize)size resizeEdge:(UIEdgeInsets)edgeInsets;

#pragma mark - 字符串 size 计算
+ (CGSize)sizeOfString:(NSString *)str fittingSize:(CGSize)fittingSize font:(UIFont *)font;

+ (CGSize)sizeOfString:(NSString *)str fittingSize:(CGSize)fittingSize font:(UIFont *)font lineSpaces:(CGFloat)lineSpaces;

+ (CGSize)sizeOfAttributedString:(NSAttributedString *)str fittingSize:(CGSize)fittingSize;


#pragma mark - 判断字符串格式
/** 验证是否全为数字 **/
+ (BOOL)isValidateNumbers:(NSString *)numbers;

/** 验证是否合法的手机号 **/
+ (BOOL)isValidateMobile:(NSString *)mobile;

/** 验证密码6-8位数字和字母组合 **/
+ (BOOL)checkPassword:(NSString *) password;

/** 正则匹配昵称4-8位 **/
+ (BOOL) validateNickname:(NSString *)nickname;

typedef NS_ENUM(NSInteger, DatePickerFromStyle) {
    OtherModulesStyle,
    FromFemaleHouseStyle
};

@end

NS_ASSUME_NONNULL_END
