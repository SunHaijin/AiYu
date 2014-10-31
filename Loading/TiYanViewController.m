//
//  TiYanViewController.m
//  CEShi
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "TiYanViewController.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"

#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"
@interface TiYanViewController ()
@property(nonatomic,strong)UIViewController * set;

@end

@implementation TiYanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [UIApplication sharedApplication]
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}
- (IBAction)TapSSO:(id)sender
{
    //发送消息流程为：点击发送消息按键----SDK会自动帮我们判断用户是否安装了新浪微博客户端--如果未安装弹出安装提示----如果安装直接跳转到sina微博客户端进行发送----发送成功后自动跳回原应用程序。
    //重要：如果程序发送完消息无法跳回原应用的话是因为在plist文件中没有配置URL Types， appKey在你的新浪开发者帐号里有。
    //授权，通过授权我们可以在用户未安装客户端的情况下关注指定微博。
    // 授权主要是为了得到：userID,accessToken，有了accessToken我们就可以访问新浪weibo的API了
    //response. userInfo对象就是我们要的东西
    
    
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"TiYanViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    //上面的代码会弹出一个授权窗口，用户可以输入用户名和密码，输入完成或者关闭窗口程序会自动调用AppDelegate类中的didReceiveWeiboResponse方法。
    //如果你的程序弹出授权窗口还没有等用户输入帐号密码就自动关闭了关马上调用了didReceiveWeiboResponse方法，这时返回的statusCode为-3，那么说明你应用授权失败了，此时需要设置你应用的 Bundle identifier
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.set = [storyboard instantiateViewControllerWithIdentifier:@"set"];
    
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
