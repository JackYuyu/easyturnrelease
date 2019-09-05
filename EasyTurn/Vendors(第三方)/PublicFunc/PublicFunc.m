//
//  PublicFunc.m
//  DaDaAutoLease
//
//  Created by august on 14-9-19.
//  Copyright (c) 2014年 Logicsolutions.Inc. All rights reserved.
//

#import "PublicFunc.h"
#import <CommonCrypto/CommonDigest.h>

static PublicFunc *instance = nil;
@implementation PublicFunc

+ (PublicFunc *)shareInstance
{
    @synchronized(self)
    {
        if (!instance) {
            instance = [PublicFunc new];
        }
    }
    return instance;
}

+ (void)clearToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"token"];
    [defaults synchronize];
}

+ (void)saveToken: (NSString *)token
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:token forKey:@"token"];
    [defaults synchronize];
}

+ (NSString *)getToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey: @"token"];
    if (!token) {
        token = @"";
    }
    return token;
}

+ (NSString *)convertLongToDate:(long long)time {
    NSDate *date =  [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)convertLongToDate:(long long)time withFormat:(NSString*)format {
    NSDate *date =  [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

#pragma mark -  验证手机号合法性
BOOL isNumber (char ch) {
    if (!(ch >= '0' && ch <= '9')) {
        return FALSE;
    }
    return TRUE;
}

BOOL isLetter (char ch) {
    if ((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')) {
        return TRUE;
    }
    return FALSE;
}

+ (BOOL) isValidNumber:(NSString*)value {
    const char *cvalue = [value UTF8String];
    unsigned long len = strlen(cvalue);
    for (unsigned long i = 0; i < len; i++) {
        if(!isNumber(cvalue[i])){
            return FALSE;
        }
    }
    return TRUE;
}

+ (BOOL) isValidPhone:(NSString*)value {
    const char *cvalue = [value UTF8String];
    unsigned long  len = strlen(cvalue);
    if (len != 11) {
        return FALSE;
    }
    if (![PublicFunc isValidNumber:value])
    {
        return FALSE;
    }
    //    NSString *preString = [[NSString stringWithFormat:@"%@",value] substringToIndex:2];
    //    if ([preString isEqualToString:@"13"] ||
    //        [preString isEqualToString: @"15"] ||
    //        [preString isEqualToString: @"18"])
    //    {
    //        return TRUE;
    //    }
    //    else
    //    {
    //        return FALSE;
    //    }
    return TRUE;
}

+ (BOOL)isValidPasswordFormat:(NSString*)value {
    const char *cvalue = [value UTF8String];
    unsigned long len = strlen(cvalue);
    for (int i = 0; i < len; i++) {
        if(!isNumber(cvalue[i]) && !isLetter(cvalue[i])){
            return NO;
        }
    }
    return YES;
}

// Carl - chek userpassword
+ (BOOL)matchString:(NSString *)aString withRegular:(NSString *)regular error:(NSError **)error {
    NSRegularExpression *regularExp = [NSRegularExpression regularExpressionWithPattern:regular options:NSRegularExpressionDotMatchesLineSeparators error:error];
    if (regularExp) {
        NSTextCheckingResult *firstMatch = [regularExp firstMatchInString:aString options:0 range:NSMakeRange(0, [aString length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            
            NSString *result = [aString substringWithRange:resultRange];
            NSLog(@"%@", result);
            if ([result isEqualToString:aString]) {
                return YES;
            } else {
                return NO;
            }
        } else {
            NSLog(@"Match failed!");
            return NO;
        }
    } else {
        NSLog(@"Regular failed!");
        return NO;
    }
}

#pragma mark -- 提示信息框
+ (MBProgressHUD *)MBhud:(NSString *)labelText view:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    //    hud.label.text = labelText
    //    hud.label.numberOfLines = 0;
    //    // Move to bottm center.
    //    hud.offset = CGPointMake(0.f, 0.f);
    //
    //    [hud hideAnimated:YES afterDelay:1.5f];

//    hud.labelText = labelText;
    hud.detailsLabelText = labelText;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    hud.xOffset = 0.f;
    hud.yOffset = 0.f;
    [hud hide:YES afterDelay:1.5f];
    
    return hud;
}

+ (MBProgressHUD *)MBWaitHud:(NSString *)labelText view:(UIView *)view{
    MBProgressHUD *loadingView = [MBProgressHUD showHUDAddedTo:view animated:YES];;
    //    loadingView.label.text = labelText;
    loadingView.labelText = labelText;
    [view addSubview:loadingView];
    [loadingView setMode:MBProgressHUDModeIndeterminate];   //圆盘的扇形进度显示
    //    loadingView.taskInProgress = YES;
    
    [loadingView show:YES];
    
    return loadingView;
}

+ (MBProgressHUD *)MBCompleteHud:(NSString *)labelText view:(UIView *)view Success:(BOOL)suceess{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image;
    if (suceess) {
        image = [[UIImage imageNamed:@"chearmarkNew"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }else{
        image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.labelText = labelText;
    
    hud.tintColor = [UIColor whiteColor];
    
    [hud hide:YES afterDelay:1.5f];
    
    return hud;
}

+ (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"Preferred Language:%@", preferredLang);
    return preferredLang;
}

+ (CGSize)content:(NSString *)content font:(UIFont *)font maxSize:(CGSize)maxSize alignment:(NSTextAlignment)alignment linebreak:(NSLineBreakMode)lineBreak
{
    CGSize contentSize;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreak;
    paragraphStyle.alignment = alignment;
    NSDictionary * attributes = @{NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:paragraphStyle};
    contentSize = [content boundingRectWithSize:maxSize
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:attributes
                                        context:nil].size;
    
    return contentSize;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGFloat)textHeightFromString:(NSString *)textStr width:(CGFloat)width fontsize:(CGFloat)Size{
    //最好判断一下SDK 的版本
    //下面的方法是ios7 的
    /**
     *  根据字符串的内容 和固定的宽度来求高度
     @param size 给一个预设的大小 宽度写成固定的 高度写成float 的最大值
     @param option 第二哥参数用于设置 是否以段为基准 不以base line 为准
     第三个参数对文字进行设置
     @return 真实的大小
     */
    if (textStr.length == 0) {
        return  0;
    }
    
    float dev=[[[UIDevice currentDevice]systemVersion]floatValue];
    if (dev>=7.0) {
        NSDictionary *dict=@{
                             NSFontAttributeName: [UIFont systemFontOfSize:Size]
                             };
        
        CGRect frame=[textStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil];
        return frame.size.height;
        
    }else{
        //        CGSize size=[textStr sizeWithFont:[UIFont systemFontOfSize:Size] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
        CGRect ize = [textStr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Size]} context:nil];
        return ize.size.height;
    }
}

+ (CGFloat)textWidthFromString:(NSString *)textStr height:(CGFloat)height fontsize:(CGFloat)Size{
    //最好判断一下SDK 的版本
    //下面的方法是ios7 的
    /**
     *  根据字符串的内容 和固定的宽度来求高度
     @param size 给一个预设的大小 宽度写成固定的 高度写成float 的最大值
     @param option 第二哥参数用于设置 是否以段为基准 不以base line 为准
     第三个参数对文字进行设置
     @return 真实的大小
     */
    if (textStr.length == 0) {
        return  0;
    }
    
    float dev=[[[UIDevice currentDevice]systemVersion]floatValue];
    if (dev>=7.0) {
        NSDictionary *dict=@{
                             NSFontAttributeName: [UIFont systemFontOfSize:Size]
                             };
        
        CGRect frame=[textStr boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil];
        return frame.size.width;
        
    }else{
        //        CGSize size=[textStr sizeWithFont:[UIFont systemFontOfSize:Size] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
        CGRect ize = [textStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Size]} context:nil];
        return ize.size.width;
    }
}

+ (UIButton *)setButtonContentCenter:(UIButton *)btn heightSpace:(CGFloat)space{
    
    CGSize imgViewSize,titleSize,btnSize;
    
    UIEdgeInsets imageViewEdge,titleEdge;
    
    CGFloat heightSpace = space;
    
    //设置按钮内边距
    imgViewSize = btn.imageView.bounds.size;
    
    titleSize = btn.titleLabel.bounds.size;
    
    btnSize = btn.bounds.size;
    
    imageViewEdge = UIEdgeInsetsMake(heightSpace,0.0, btnSize.height -imgViewSize.height - heightSpace, - titleSize.width);
    
    [btn setImageEdgeInsets:imageViewEdge];
    
    titleEdge = UIEdgeInsetsMake(imgViewSize.height +heightSpace, - imgViewSize.width, 0.0, 0.0);
    
    [btn setTitleEdgeInsets:titleEdge];
    
    return btn;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

+ (UIButton *)creatButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name title:(NSString *)title distance:(NSInteger)distance titleFont:(NSInteger)font{
    
    UIButton *button = nil;
    if (name) {//创建图片按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置背景图片
        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        if (title) {
            //创建 图片 和 标题按钮
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:RGBACOLOR(120, 120, 120, 1) forState:UIControlStateNormal];
        }
    }else if(title){//创建标题按钮
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        button = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.frame = frame;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    CGSize textSize = [button.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:font] }];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + distance);
    button.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width-20, - (totalHeight - titleSize.height), -20);
    
    return button;
}

+ (NSString* )returnCurrentDay
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* str = [formatter stringFromDate:date];
    return [NSString stringWithFormat:@"%@-%@-%@",[[str componentsSeparatedByString:@"-"] objectAtIndex:0], [[str componentsSeparatedByString:@"-"] objectAtIndex:1],[[str componentsSeparatedByString:@"-"] objectAtIndex:2]];
}

+ (NSString* )returnLastDay
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate *lastDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* str = [formatter stringFromDate:lastDate];
    return [NSString stringWithFormat:@"%@-%@-%@",[[str componentsSeparatedByString:@"-"] objectAtIndex:0], [[str componentsSeparatedByString:@"-"] objectAtIndex:1],[[str componentsSeparatedByString:@"-"] objectAtIndex:2]];
}

//获取当前的小时时间
+(NSString*)getCurrentTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}

//获取当前的时间，精确到分钟
+(NSString*)getCurrentMinuteTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"HH:mm"];
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}

//获取当前的时间，精确到毫秒
+(NSString*)getCurrentSecondTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"HH:mm:ss:SSSS"];
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}

//获取当前时间戳
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}

//判断内容是否全部为空格 yes 全部为空格 no 不是
+ (BOOL)isEmpty:(NSString *) str {
    
    if(!str) {
        return true;
    }else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and next line characters (U+000A–U+000D,U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if([trimedString length] == 0) {
            return true;
            
        }else {
            return false;
        }
    }
}

//计算一个月的总天数
+ (NSInteger)daysInthisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return totaldaysInMonth.length;
}

+ (NSString *)subStringFromString:(NSString *)wholeString start:(NSString *)startString end:(NSString *)endString{
    
    NSRange startRange = [wholeString rangeOfString:startString];
    NSRange endRange = [wholeString rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [wholeString substringWithRange:range];
}

/**
 十进制转换十六进制
 
 @param decimal 十进制数
 @return 十六进制数
 */
+ (NSString *)getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    if (hex.length == 1) {
        hex = [NSString stringWithFormat:@"0%@",hex];
    }
    return hex;
}

+ (NSNumber *)numberHexString:(NSString *)aHexString
{
    // 为空,直接返回.
    if (nil == aHexString)
    {
        return nil;
    }
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    unsigned long long longlongValue;
    [scanner scanHexLongLong:&longlongValue];
    
    //将整数转换为NSNumber,存储到数组中,并返回.
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    
    return hexNumber;
}

+ (BOOL)isEmailAddress:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month{
    
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
}

+ (NSString *)returenNewArray:(NSArray *)BWW{
    
//    NSString *hourStrNew = [NSString string];
//    NSArray *hourArray = BWW;
//    for (NSString *str in hourArray) {
//
//        hourStrNew = [hourStrNew stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
//
//    }
//    if (hourStrNew.length>1) {
//        hourStrNew = [hourStrNew substringToIndex:[hourStrNew length] - 1];
//    }
//    NSArray *hourArrayNew = [hourStrNew componentsSeparatedByString:@","];
    
    //去除最大值和最小值
//    CGFloat maxValue = [[hourArrayNew valueForKeyPath:@"@max.floatValue"] floatValue];
//    CGFloat minValue = [[hourArrayNew valueForKeyPath:@"@min.floatValue"] floatValue];
//
//    NSMutableArray *newHourArray = [NSMutableArray array];
//    for (NSString *str in hourArrayNew) {
//        if ([str floatValue] != maxValue  && [str floatValue] != minValue) {
//            [newHourArray addObject:str];
//        }
//    }
    NSString *adValue = [BWW valueForKeyPath:@"@avg.floatValue"];
    
    NSString *adValueStr = [NSString stringWithFormat:@"%.1f",[adValue floatValue]];
    
    return adValueStr;
}

//表情符号的判断
+ (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

//计算两个日期之间的天数
+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate{
    
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //取两个日期对象的时间间隔：
    
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}

+(NSString*) getLocalAppVersion{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
}

+ (BOOL)validateNumberByRegExp:(NSString *)string {
    BOOL isValid = YES;
    NSUInteger len = string.length;
    if (len > 0) {
        NSString *numberRegex = @"^[0-9]*$";
        NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
        isValid = [numberPredicate evaluateWithObject:string];
    }
    return isValid;
}

+(NSData*)stringToByte:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}

+ (NSInteger)getSumOfDaysInMonth:(NSString *)year month:(NSString *)month{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@",year,month];
    
    NSDate * date = [formatter dateFromString:dateStr];

    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    return range.length;
}

//+ (NSString *)STLocalizedString:(NSString *)String{
//
//    if (![CURR_LANG hasPrefix:@"zh"])
//    {
//        NSString * path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
//        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
//        return [languageBundle localizedStringForKey:(String) value:@"" table:nil];
//    } else{
//        return NSLocalizedString(String, nil);
//    }
//}

//时间戳字符串1469193006001
+ (NSString *)timespToUTCFormat:(NSString *)timesp
{
    NSString *timeString = [timesp stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (timeString.length >= 10) {
        NSString *second = [timeString substringToIndex:10];
        NSString *milliscond = [timeString substringFromIndex:10];
        NSString * timeStampString = [NSString stringWithFormat:@"%@.%@",second,milliscond];
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        return dateString;
    }
    return @"";
}

+ (NSString *)instructionToFormat:(NSString *)string{
    
    NSString *newString = [NSString string];
    string = @"3,20,10,10,40";
    
    NSArray *array = [string componentsSeparatedByString:@","];
    
    //波形序号
    newString = [newString stringByAppendingString:[NSString stringWithFormat:@"3%@ 2C ",array[0]]];

    //脉宽
    newString = [newString stringByAppendingString:[NSString stringWithFormat:@"3%@ 3%@ 2C ",[array[1] substringToIndex:1],[array[1] substringFromIndex:1]]];
    
    //相同波形循坏间隔时间(单位10毫秒)
    newString = [newString stringByAppendingString:[NSString stringWithFormat:@"3%@ 3%@ 2C ",[array[2] substringToIndex:1],[array[2] substringFromIndex:1]]];
    
    //相同波形循坏数量
    if ([array[3] integerValue] <10) {
        newString = [newString stringByAppendingString:[NSString stringWithFormat:@"3%@ 2C ",array[3]]];
    }else{
        newString = [newString stringByAppendingString:[NSString stringWithFormat:@"3%@ 3%@ 2C ",[array[3] substringToIndex:1],[array[3] substringFromIndex:1]]];
    }
    
    //不同波形之间的间隔(单 位10毫秒)
    newString = [newString stringByAppendingString:[NSString stringWithFormat:@"3%@ 3%@ 2C 0D 0A",[array[4] substringToIndex:1],[array[4] substringFromIndex:1]]];
    

    return newString;
}

//将可能存在model数组转化为普通数组
+ (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
                
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
        
        return [array copy];
        
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        //字典
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
                
            } else {
                //model
                [dic setObject:[self dicFromObject:object] forKey:key];
            }
        }
        
        return [dic copy];
    }
    
    return [NSNull null];
}

+ (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if (value == nil) {
            //null
            //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
            
        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
    }
    
    return [dic copy];
}
    
    //时间戳转化为日期TimeStamp转NSDate转NSString
    + (NSString *)translateTimestampFormat:(NSString *)realtime {
        
        NSInteger time = [realtime integerValue] / 1000;
        NSNumber *timer = [NSNumber numberWithInteger:time];
        NSTimeInterval interval = [timer doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        //设置日期格式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd"];

        
        
        
        NSString *str = [formatter stringFromDate:date];
        return str;
        
    }
    
    + (NSString *)timespToUTCSSSFormat:(NSString *)timesp
    {
        NSString *timeString = [timesp stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (timeString.length >= 10) {
            NSString *second = [timeString substringToIndex:10];
            NSString *milliscond = [timeString substringFromIndex:10];
            NSString * timeStampString = [NSString stringWithFormat:@"%@.%@",second,milliscond];
            NSTimeInterval _interval=[timeStampString doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
            //        [dateFormatter setTimeZone:timeZone];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [dateFormatter stringFromDate:date];
            
            return dateString;
        }
        return @"";
    }

+ (NSString *)arabicNumberalsFromChineseNumberals:(NSString *)arabic{
    
    NSMutableDictionary * mdic =[[NSMutableDictionary alloc]init];
    
    [mdic setObject:[NSNumber numberWithInt:10000] forKey:@"万"];
    [mdic setObject:[NSNumber numberWithInt:1000] forKey:@"千"];
    [mdic setObject:[NSNumber numberWithInt:100] forKey:@"百"];
    [mdic setObject:[NSNumber numberWithInt:10] forKey:@"十"];
    
    [mdic setObject:[NSNumber numberWithInt:9] forKey:@"九"];
    [mdic setObject:[NSNumber numberWithInt:8] forKey:@"八"];
    [mdic setObject:[NSNumber numberWithInt:7] forKey:@"七"];
    [mdic setObject:[NSNumber numberWithInt:6] forKey:@"六"];
    [mdic setObject:[NSNumber numberWithInt:5] forKey:@"五"];
    [mdic setObject:[NSNumber numberWithInt:4] forKey:@"四"];
    [mdic setObject:[NSNumber numberWithInt:3] forKey:@"三"];
    [mdic setObject:[NSNumber numberWithInt:2] forKey:@"二"];
    [mdic setObject:[NSNumber numberWithInt:2] forKey:@"两"];
    [mdic setObject:[NSNumber numberWithInt:1] forKey:@"一"];
    [mdic setObject:[NSNumber numberWithInt:0] forKey:@"零"];

    BOOL flag=YES;//yes表示正数，no表示负数
    NSString * s=[arabic substringWithRange:NSMakeRange(0, 1)];
    if([s isEqualToString:@"负"]){
        flag=NO;
    }
    
    //added by zhichao.li on 中文中包含‘点’，不需处理
    if ([arabic rangeOfString:@"点"].location != NSNotFound) {
        flag=NO;
    }
    
    int i=0;
    if(!flag){
        i=1;
    }
    int sum=0;//和
    int num[20];//保存单个汉字信息数组
    for(int i=0;i<20;i++){//将其全部赋值为0
        num[i]=0;
    }
    int k=0;//用来记录数据的个数
    
    //如果是负数，正常的数据从第二个汉字开始，否则从第一个开始
    for(;i<[arabic length];i++){
        NSString * key=[arabic substringWithRange:NSMakeRange(i, 1)];
        int tmp=[[mdic valueForKey:key] intValue];
        num[k++]=tmp;
    }
    //将获得的所有数据进行拼装
    for(int i=0;i<k;i++){
        if(num[i]<10&&num[i+1]>=10){
            sum+=num[i]*num[i+1];
            i++;
        }else{
            sum+=num[i];
        }
    }
    NSMutableString * result=[[NSMutableString alloc]init];;
    if(flag){//如果正数
        NSLog(@"%d",sum);
        result=[NSMutableString stringWithFormat:@"%d",sum];
    }else{//如果负数
        NSLog(@"-%d",sum);
        result=[NSMutableString stringWithFormat:@"-%d",sum];
    }
    
    
    NSLog(@"%s  %@", __func__, result);
    return result;
}

+ (NSString *)arabicNumberalsFromEnglishNumberals:(NSString *)arabic{
    
    NSMutableDictionary * mdic =[[NSMutableDictionary alloc]init];

    [mdic setObject:[NSNumber numberWithInt:50] forKey:@"fifty"];
    
    [mdic setObject:[NSNumber numberWithInt:49] forKey:@"forty nine"];
    [mdic setObject:[NSNumber numberWithInt:48] forKey:@"forty eight"];
    [mdic setObject:[NSNumber numberWithInt:47] forKey:@"forty seven"];
    [mdic setObject:[NSNumber numberWithInt:46] forKey:@"forty six"];
    [mdic setObject:[NSNumber numberWithInt:45] forKey:@"forty five"];
    [mdic setObject:[NSNumber numberWithInt:44] forKey:@"forty four"];
    [mdic setObject:[NSNumber numberWithInt:43] forKey:@"forty three"];
    [mdic setObject:[NSNumber numberWithInt:42] forKey:@"forty two"];
    [mdic setObject:[NSNumber numberWithInt:41] forKey:@"forty one"];
    [mdic setObject:[NSNumber numberWithInt:40] forKey:@"forty"];
    
    [mdic setObject:[NSNumber numberWithInt:39] forKey:@"thirty nine"];
    [mdic setObject:[NSNumber numberWithInt:38] forKey:@"thirty eight"];
    [mdic setObject:[NSNumber numberWithInt:37] forKey:@"thirty seven"];
    [mdic setObject:[NSNumber numberWithInt:36] forKey:@"thirty six"];
    [mdic setObject:[NSNumber numberWithInt:35] forKey:@"thirty five"];
    [mdic setObject:[NSNumber numberWithInt:34] forKey:@"thirty four"];
    [mdic setObject:[NSNumber numberWithInt:33] forKey:@"thirty three"];
    [mdic setObject:[NSNumber numberWithInt:32] forKey:@"thirty two"];
    [mdic setObject:[NSNumber numberWithInt:31] forKey:@"thirty one"];
    [mdic setObject:[NSNumber numberWithInt:30] forKey:@"thirty"];
    
    [mdic setObject:[NSNumber numberWithInt:29] forKey:@"twenty nine"];
    [mdic setObject:[NSNumber numberWithInt:28] forKey:@"twenty eight"];
    [mdic setObject:[NSNumber numberWithInt:27] forKey:@"twenty seven"];
    [mdic setObject:[NSNumber numberWithInt:26] forKey:@"twenty six"];
    [mdic setObject:[NSNumber numberWithInt:25] forKey:@"twenty five"];
    [mdic setObject:[NSNumber numberWithInt:24] forKey:@"twenty four"];
    [mdic setObject:[NSNumber numberWithInt:23] forKey:@"twenty three"];
    [mdic setObject:[NSNumber numberWithInt:22] forKey:@"twenty two"];
    [mdic setObject:[NSNumber numberWithInt:21] forKey:@"twenty one"];
    [mdic setObject:[NSNumber numberWithInt:20] forKey:@"twenty"];
    
    [mdic setObject:[NSNumber numberWithInt:19] forKey:@"nineteen"];
    [mdic setObject:[NSNumber numberWithInt:18] forKey:@"eighteen"];
    [mdic setObject:[NSNumber numberWithInt:17] forKey:@"seventeen"];
    [mdic setObject:[NSNumber numberWithInt:16] forKey:@"sixteen"];
    [mdic setObject:[NSNumber numberWithInt:15] forKey:@"fifteen"];
    [mdic setObject:[NSNumber numberWithInt:14] forKey:@"fourteen"];
    [mdic setObject:[NSNumber numberWithInt:13] forKey:@"thirteen"];
    [mdic setObject:[NSNumber numberWithInt:12] forKey:@"twelve"];
    [mdic setObject:[NSNumber numberWithInt:11] forKey:@"eleven"];
    [mdic setObject:[NSNumber numberWithInt:10] forKey:@"ten"];
    
    [mdic setObject:[NSNumber numberWithInt:9] forKey:@"nine"];
    [mdic setObject:[NSNumber numberWithInt:8] forKey:@"eight"];
    [mdic setObject:[NSNumber numberWithInt:7] forKey:@"seven"];
    [mdic setObject:[NSNumber numberWithInt:6] forKey:@"six"];
    [mdic setObject:[NSNumber numberWithInt:5] forKey:@"five"];
    [mdic setObject:[NSNumber numberWithInt:4] forKey:@"four"];
    [mdic setObject:[NSNumber numberWithInt:3] forKey:@"three"];
    [mdic setObject:[NSNumber numberWithInt:2] forKey:@"two"];
    [mdic setObject:[NSNumber numberWithInt:1] forKey:@"one"];
    [mdic setObject:[NSNumber numberWithInt:0] forKey:@"zero"];

    NSString *result = [NSString stringWithFormat:@"%@",[mdic objectForKey:arabic]];
    
    return result;
}

+ (BOOL)isNumText:(NSString *)str{
    NSString * regex  = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch   = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

@end


