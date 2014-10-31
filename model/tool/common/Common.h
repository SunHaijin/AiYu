
/*
 存放应用公用的一些配置
 */

//宏
#define iPhone5_OR_ABOVE ([UIScreen mainScreen].bounds.size.height == 568)
#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))


#define kTabBarHeight 38
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeitht [UIScreen mainScreen].bounds.size.height
#define kNavgationHeight ([[[UIDevice currentDevice] systemVersion] floatValue]>=7?64:44)


// 全局统一背景
//#define kGlobalBg [UIColor colorWithRed:221/255.0 green:222/255.0 blue:236/255.0 alpha:1]
