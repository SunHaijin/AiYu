//
//  ZhuxiaoController.m
//  AiYu
//
//  Created by ibokan on 14-10-20.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "ZhuxiaoController.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import <AFNetworking.h>


@interface ZhuxiaoController ()
@property(nonatomic,strong)UIViewController*tiyan;

@end

@implementation ZhuxiaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Zhuxiao:(id)sender
{
    
    //success返回值:0成功解除 1认证失败 2关系解除失败—你还没有情侣关系
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user removeObjectForKey:@"uid"];
    [user removeObjectForKey:@"accessToken"];
    
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    self.tiyan = [storyboard instantiateViewControllerWithIdentifier:@"tiyan"];
    self.view.window.rootViewController = self.tiyan;
    
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
