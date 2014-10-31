
/*
 存放应用相关的配置
 */

#define kAppKey @"945135489"
#define kAppSecret @"622dab429b292c82dd448dfcff8fb0ed"
#define kRedirectURL @"http://www.bokanedu.com"

//参数名
#define kAccessToken @"access_token"
#define kUID @"uid"
#define kOtherUid @"otheruid"
#define kName @"name"
#define kSex @"sex"
#define kUserImage @"userImage"
#define kTel @"tel"
#define kRelation @"relation"
#define kDeviceToken @"deviecToken"
#define kBackgroundImage @"backgroundimage"
#define kFile @"file"
#define kLock @"lock"
#define I @"i"
#define kPassword @"password"
#define kPage @"page"
#define kSize @"size"
#define kTool @"tool"
#define kWantuid @"wantuid"
#define kJID @"jid"

#define kCode @"code"
#define kUida @"uida"
#define kContent @"content"
#define kImage @"image"
#define kSuccess @"success"

// 获取code地址
#define kCodeURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code", kAppKey, kRedirectURL]

// 获取AccessToken地址
#define kAccessTokenURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=", kAppKey,kAppSecret,kRedirectURL]

// 公共请求地址
#define kBaseURL @"http://lovemyqq.sinaapp.com/"

//上传资料地址
#define kUploadImage @"http://lovemyqq.sinaapp.com/uploadimage.php"
#define kSetUserInfo @"http://lovemyqq.sinaapp.com/setUser.php"
#define kPostState @"http://lovemyqq.sinaapp.com/postState.php"
#define kGetState @"http://lovemyqq.sinaapp.com/getStateList.php"


#import "AccountTool.h"
//Zone
//导航栏高度
#define kNavHeight 44
//内容宽度
#define kContentWidth 240
//内容字体
#define kContentFontSize 13
//获取状态条数
#define kGetStatusListSize @"10"
//屏幕高度
#define kScreen_height [[UIScreen mainScreen] bounds].size.height
//参数
#define kLoveParaAccessToken @"access_token"
#define kLoveParaUID @"uid"
#define kLoveParaContent @"content"
#define kLoveParaImage @"image"
#define kLoveParaImageCount @"imagecount"
#define kLoveParaLatitude @"latitude"
#define kLoveParaLongitude @"longitude"
#define kLoveParaAddress @"address"
#define kLoveParaSuccess @"success"
#define kLoveParaPage @"page"
#define kLoveParaSize @"size"
#define kLoveParaStateID @"stateid"
#define kLoveParaImageURL @"imageUrl"
#define kLoveParaWantuid @"wantuid"
#define kLoveParaUserImage @"userImage"
#define kLoveParaBackImage @"backgroundimage"



//接口
#define kLovePostStateURL @"http://lovemyqq.sinaapp.com/postState.php"
#define kLoveGetStateURL @"http://lovemyqq.sinaapp.com/getState.php"
#define kLovePostComment @"http://lovemyqq.sinaapp.com/postComment.php"
#define kLoveUploadImage @"http://lovemyqq.sinaapp.com/uploadimage.php"
#define kLoveGetUser @"http://lovemyqq.sinaapp.com/getUser.php"
#define kLovePostComment @"http://lovemyqq.sinaapp.com/postComment.php"
#define kLoveRemoveStatus @"http://lovemyqq.sinaapp.com/removeState.php"
#define kLoveRemoveComment @"http://lovemyqq.sinaapp.com/removeComment.php"
