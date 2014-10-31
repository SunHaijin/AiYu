//
//  AppDelegate.h
//  AiYu
//
//  Created by ibokan on 14-10-15.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "TiYanViewController.h"




#define kAppKey         @"945135489"
#define kRedirectURI    @"https://api.weibo.com/oauth2/default.html"
//#define kRedirectURI    @"http://www.sina.com"



@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>


@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)NSString * wbtoken;
@property(strong,nonatomic)NSString * useruid;
@end

