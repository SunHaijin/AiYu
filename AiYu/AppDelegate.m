//
//  AppDelegate.m
//  AiYu
//
//  Created by ibokan on 14-10-15.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "AppDelegate.h"

#import "Account.h"

#import <AFNetworking.h>


//加入密码页面

@interface AppDelegate ()

@property (strong, nonatomic) UIViewController *shezhi;//第一次登陆设置用户信息的界面,此时应该一步步的重新来设置
@property (strong, nonatomic) UIViewController *tiyan;//开始登陆的界面
@property(strong,nonatomic)UIViewController *peiduichenggong;//配对成功正常使用的界面
@property(strong,nonatomic)UIViewController *shibai;
@end

@implementation AppDelegate

//点击

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //在AppDelegate中注册sdk, AppDelegate需要实现WeiboSDKDelegate
    //程序启动时,在代码中向微博终端注册你的 Appkey,如果首次 集成微博SDK,建议打开调试选项以便输出调试信息。

    
    
    [self login];
    
    
    
    
    
    
    

    [self.window makeKeyAndVisible];
    return YES;
    
    
}


- (void) login
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userDefaults objectForKey:@"uid"];
    NSString *token = [userDefaults objectForKey:@"accessToken"];
    if (uid && token)
    {
        //登录新浪接口获得uid和accesstoken之后开始登录app.
        NSString * codeString = [NSString stringWithFormat:@"http://lovemyqq.sinaapp.com/login.php"];
        
        NSDictionary *dic=@{@"access_token":token,@"uid":uid};
        
        
        AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];
        
        AFHTTPRequestOperation * op = [manager GET:codeString parameters:dic  success:^(AFHTTPRequestOperation *operation, NSData *  responseObject)
                                       {
                                           NSError * error;
                                           NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                                           NSLog(@" 0 登陆成功跳转正常使用界面（已配对成功）1 登陆成功跳转设置用户基本信息界面（对应场景为第一次登陆）2 登陆成功跳转到配对界面（用户基本信息已设置，还未配对） 3 登陆失败****_________________%@",dic);
                                           
                                           if (dic == nil)
                                           {
                                               NSLog(@"字典为空%@",[error localizedDescription]);
                                               return ;
                                           }
                                           NSString * str = dic[@"success"];//解析得到了云存储器的URL
                                           
                                           NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                                           [user  setObject:self.useruid forKey:@"uid"];
                                           [user setObject:self.wbtoken forKey:@"accessToken"];
                                           //                                           [user setObject:str forKey:@"success"];
                                           [user synchronize]; //存储到NSUserDefaults里面
                                           
                                           //                                           NSLog(@"登录界面之后登录爱语后台返回的参数是%@",str);
                                           //
                                           if ([str isEqualToString:@"0"])
                                           {
                                               //已配对成功跳转到正常使用界面
                                               
                                               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                               self.peiduichenggong = [storyboard instantiateViewControllerWithIdentifier:@"zhuyemian"];
                                               NSLog(@"PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                                               // self.window.rootViewController=self.peiduichenggong;
                                               
                                               self.window.rootViewController=self.peiduichenggong;
                                               
                                           }
                                           if ([str isEqualToString:@"1"])
                                           {
                                               //登陆成功跳转设置用户基本信息界面（对应场景为第一次登陆）
                                               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                               self.tiyan = [storyboard instantiateViewControllerWithIdentifier:@"Shezhi"];
                                               //                                               NSLog(@"KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
                                               
                                               NSLog(@"%@", self.window.rootViewController);
                                               self.window.rootViewController=self.tiyan;
                                               NSLog(@"%@", self.window.rootViewController);
                                               
                                           }
                                           if ([str isEqualToString:@"2"])
                                           {
                                               //登陆成功跳转到配对界面（用户基本信息已设置，还未配对）
                                               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                               self.peiduichenggong = [storyboard instantiateViewControllerWithIdentifier:@"kaishijinrupipei"];
                                               //                                               NSLog(@"uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
                                               self.window.rootViewController=self.peiduichenggong;
                                               
                                               
                                           }
                                           if  ([str isEqualToString:@"3"])
                                           {
                                               //登陆失败,跳转到体验界面
                                               //返回3是什么原因?
                                               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                               self.shibai = [storyboard instantiateViewControllerWithIdentifier:@"tiyan"];
                                               //                                               NSLog(@"hhhhhhhHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
                                               //NSLog(@"%@", self.window.rootViewController);
                                               self.window.rootViewController=self.shibai;
                                               
                                               
                                               
                                           }
                                           
                                       }
                                           failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                       {
                                           NSLog(@"error = %@",[error localizedDescription]);
                                           
                                       }];
        
        
        
        op.responseSerializer=[AFHTTPResponseSerializer serializer];
        [op start];
        
    }
    else
    {
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:kAppKey];
    }
    

}



//上面的代码会弹出一个授权窗口，用户可以输入用户名和密码，输入完成或者关闭窗口程序会自动调用AppDelegate类中的didReceiveWeiboResponse方法,也就是下面的方法。
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        
        
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        

    }
    
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    
    {
        
        
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
//        NSLog(@"新浪返回一个wbtoken%@",_wbtoken);
        self.useruid = [(WBAuthorizeResponse *)response userID];
//        NSLog(@"新浪返回一个useruid%@",_useruid);

//    NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
//    self.useruid = [load stringForKey:@"uid"];
//    self.wbtoken = [load stringForKey:@"accessToken"];
//        
//        
        
        //将获取到的信息存入到NSUserDefaults
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user  setObject:self.useruid forKey:@"uid"];
        [user setObject:self.wbtoken forKey:@"accessToken"];
        [user synchronize]; //存储到NSUserDefaults里面
        [self login];
    }
    
       
}


//实现AppDelegate.m的回调
//关于新浪微博的成功回调是写在该类中实现的,因为这里写入了self,如果需要别的类中实现也可以在这里进行修改
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    
//    NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
//    NSString * str = [load stringForKey:@"password"];
//    [self presentViewController   passcodeViewController animated:YES completion:nil];
        
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
