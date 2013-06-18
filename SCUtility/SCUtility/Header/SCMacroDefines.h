//
//  SCMacroDefines.h
//  SCUtility
//
//  Created by Jarry on 13-3-29.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#ifndef SCUtility_SCMacroDefines_h
#define SCUtility_SCMacroDefines_h

/**
 *  系统
 */
#define     IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]
#define     SYSTEM_VERSION      ([[UIDevice currentDevice] systemVersion])
#define     SYSTEM_LANGUAGE     ([[NSLocale preferredLanguages] objectAtIndex:0])

#define     SYSTEM_VERSION_EQUAL_TO(v)              ([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedSame)
#define     SYSTEM_VERSION_GREATER_THAN(v)          ([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedDescending)
#define     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define     SYSTEM_VERSION_LESS_THAN(v)             ([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedAscending)
#define     SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedDescending)

// 判断Retina屏幕
#define     isRetina            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhone5
#define     isIPhone5           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPad
#define     isPad               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// Release safe
#define     RELEASE_SAFELY(__POINTER)   { [__POINTER release]; __POINTER = nil; }
#define     INVALIDATE_TIMER(__TIMER)   { [__TIMER invalidate]; __TIMER = nil; } 

// ARC
#define     ARC_FEATURE         __has_feature(objc_arc)
#define     ARC_WEAK_FEATURE    __has_feature(objc_arc_weak)

#if ARC_WEAK_FEATURE
#define     ARC_WEAK            weak
#elif ARC_FEATURE
#define     ARC_WEAK            unsafe_unretained
#else
#define     ARC_WEAK            assign
#endif

#if ARC_FEATURE
#define     ARC_BRIDGE          __bridge
#else
#define     ARC_BRIDGE
#endif

// G－C－D
#define     BACK(block)         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define     MAIN(block)         dispatch_async(dispatch_get_main_queue(),block)

// 文件路径
#define     RESOURCE_PATH       [[NSBundle mainBundle] resourcePath]
#define     DOCUMENT_PATH       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define     RESOURCE_FILE(file) [RESOURCE_PATH stringByAppendingPathComponent:file]
#define     DOCUMENT_FILE(file) [DOCUMENT_PATH stringByAppendingPathComponent:file]
#define     ABS_FILE_PATH(file) [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(),file]

// APP 版本号
#define     APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

/**
 *  屏幕
 */
#define     SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define     SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
#define     BOUNDS_HEIGHT       SCREEN_HEIGHT-20.0f
#define     NAVIGATION_HEIGHT   44.0f

#define     SCREEN_STATUS_FRAME CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
#define     SCREEN_FRAME        CGRectMake(0, 0, SCREEN_WIDTH, BOUNDS_HEIGHT)
#define     CONTENT_FRAME       CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, BOUNDS_HEIGHT-NAVIGATION_HEIGHT)
#define     HEADER_FRAME        CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHT)
#define     HEADER_TITLE_FRAME  CGRectMake(50, 0, SCREEN_WIDTH-100, NAVIGATION_HEIGHT)

#define     kIPhone5Increase    (isIPhone5 ? 88 : 0)


/**
 *  颜色
 */
#define     RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define     RGBCOLOR(r,g,b)     RGBACOLOR(r,g,b,1.0)

#define     CLEAR_COLOR         [UIColor clearColor]
#define     RED_COLOR           [UIColor redColor]
#define     WHITE_COLOR         [UIColor whiteColor]
#define     BLACK_COLOR         [UIColor blackColor]
#define     GREEN_COLOR         [UIColor greenColor]
#define     BLUE_COLOR          [UIColor blueColor]
#define     GRAY_COLOR          [UIColor grayColor]
#define     LIGHTGRAY_COLOR     [UIColor lightGrayColor] 
#define     DARKGRAY_COLOR      [UIColor darkGrayColor]
#define     ORANGE_COLOR        [UIColor orangeColor]
#define     DARKTEXT_COLOR      [UIColor darkTextColor]

/**
 *  字体
 */
#define     FONTNAMEWITHSIZE(fontName,fontSize) [UIFont fontWithName:fontName size:fontSize]
#define     TNRFONTSIZE(X)          FONTNAMEWITHSIZE(@"Times New Roman",X)
#define     BOLDTNRFONTSIZE(X)      FONTNAMEWITHSIZE(@"TimesNewRomanPS-BoldMT",X)
#define     SYSTEMFONT(X)           [UIFont systemFontOfSize:X]
#define     BOLDSYSTEMFONT(X)       [UIFont boldSystemFontOfSize:X]
#define     ARIALFONTSIZE(X)        FONTNAMEWITHSIZE(@"Arial",X)
#define     BOLDARIALFONTSIZE(X)    FONTNAMEWITHSIZE(@"Arial Black",X)


/**
 *  Block Defines
 */
typedef void (^voidBlock)();
typedef void (^idBlock)( id content);
typedef void (^idBOOLBlock)( id content, BOOL direction);
typedef void (^idRangeBlock)( id content1, id content2);
typedef void (^idRange3Block)( id content1, id content2, id content3);
typedef void (^boolBlock)(BOOL finised);
typedef void (^intBlock)(int flag);
typedef void (^refreshContent)(NSString *name);
typedef void (^intIdBlock)(int type , id content);
typedef BOOL (^boolRetBlock)( id content);

/**
 *  Add this macro before each category implementation, so we don't have to use
 *  -all_load or -force_load to load object files from static libraries that only contain
 *  categories and no classes.
 *  See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 */
#define     FIX_CATEGORY_BUG(name)  @interface B5M_FIX_CATEGORY_BUG_##name @end \
                                    @implementation B5M_FIX_CATEGORY_BUG_##name @end

/**
 *  其他
 */

// String Format
#define     kIntToString(x)     [NSString stringWithFormat:@"%d", x]
#define     kBOOLToString(x)    [NSNumber numberWithBool:x]

#define     degreesToRadian(x)      (M_PI * (x) / 180.0)
#define     radianToDegrees(radian) (radian*180.0)/(M_PI)

// NSUserDefaults
#define     USER_DEFAULT        [NSUserDefaults standardUserDefaults]

// 读取本地图片, 和imageNamed一样，两个参数，前面一个是 文件名，后面一个是类型
#define     LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

#define     IMAGENAMED(file)    [UIImage imageNamed:file]

// Alert Dialog
#define     AlertContent(content) \
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" \
                                                            message:content \
                                                            delegate:nil   \
                                                    cancelButtonTitle:@"确定" \
                                                    otherButtonTitles:nil];  \
            [alert show];  \
            [alert release];

// TableView Row index marco
enum eTableViewRowIndex
{
    eTableViewRowIndex00 = 0,
    eTableViewRowIndex01 ,
    eTableViewRowIndex02 ,
    eTableViewRowIndex03 ,
    eTableViewRowIndex04 ,
    eTableViewRowIndex05 ,
    eTableViewRowIndex06 ,
    eTableViewRowIndex07 ,
    eTableViewRowIndex08 ,
    eTableViewRowIndex09 ,
    eTableViewRowIndex10
};

/**
 *
 * #if TARGET_OS_IPHONE         //iPhone Device
 *
 * #if TARGET_IPHONE_SIMULATOR  //iPhone Simulator
 *
 */

#endif
