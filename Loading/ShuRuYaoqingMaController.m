//
//  ShuRuYaoqingMaController.m
//  AiYu
//
//  Created by ibokan on 14-10-20.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "ShuRuYaoqingMaController.h"
#import <AFNetworking/AFNetworking.h>

@interface ShuRuYaoqingMaController ()


@property (strong, nonatomic) IBOutlet UITextField *codelabel;
@property(strong,nonatomic)NSString * codeText;
@property(nonatomic,strong)NSString * access_token;
@property(nonatomic,strong)NSString * uid;
@property(strong,nonatomic)UIViewController *peiduichenggong;
@end

@implementation ShuRuYaoqingMaController


//验证邀请码，成功会获得对方uid
- (IBAction)tapYanzheng:(id)sender
{
    NSLog(@"GetCode++");
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *access_token=[user stringForKey:@"accessToken"];
    NSString *uid=[user stringForKey:@"uid"];
    
    NSDictionary * dic =@{@"access_token":access_token,@"uid":uid};
    
    NSLog(@"***************%@ %@",uid,access_token);
    
    NSString * codeString = [NSString stringWithFormat:@"http://lovemyqq.sinaapp.com/getCode.php"];
    
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];
    
    AFHTTPRequestOperation * op = [manager GET:codeString parameters:dic  success:^(AFHTTPRequestOperation *operation, NSData *  responseObject)
                                   {
                                       NSError * error;
                                       NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                                       //                                       NSLog(@"______________****_________________%@",dic);
                                       
                                       if (dic == nil)
                                       {
                                           NSLog(@"字典为空%@",[error localizedDescription]);
                                           return ;
                                       }
                                       NSString * str = dic[@"success"];
    //success的返回值:0正常获取code 1配对成功 3认证失败
                                       
                                       NSLog(@"success的返回值:0正常获取code 1配对成功 3认证失败^^^^^^^^^^%@",str);
                                       
                                       NSString *code=dic[@"code"];
                                       
                                       self.codeText=code;
                                       
                                       if ([str isEqualToString:@"0"])
                                       {
                                           NSLog(@"YanZhengCode++");
                                           NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
                                           self.codeText = [load stringForKey:@"code"];
                                           if ([self.codelabel.text  isEqualToString:self.codeText])
                                           {
                                               UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"不能自己匹配自己哦" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil];
                                               [alert show];
                                               
                                           }
                                           if (self.codelabel.text.length != 6)
                                           {
                                               UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"请输入验证码吧亲" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil];
                                               [alert show];
                                           }
                                           else
                                           {
                                               self.access_token = [load stringForKey:@"accessToken"];
                                               self.uid = [load stringForKey:@"uid"];
                                               //    NSLog(@"########%@!!!!!!!!!!!!!!!%@",self.access_token,self.uid);
                                               NSDictionary * dic = @{
                                                                      @"uid":self.uid,
                                                                      @"access_token":self.access_token,
                                                                      @"code":self.codelabel.text
                                                                      
                                                                      };
                                               NSLog(@"$$$$$$$$%@",dic);
                                               
                                               NSString * codeString = [NSString stringWithFormat:@"http://lovemyqq.sinaapp.com/setCode.php"];
                                               
                                               AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];
                                               AFHTTPRequestOperation * op = [manager POST:codeString parameters:dic success:^(AFHTTPRequestOperation *operation, NSData * responseObject)
                                                                              {
                                                                                  //返回值为success 0返回对方uid 1code过期 2认证失败
                                                                                  
                                                                                  NSError * error;
                                                                                  NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                                                                                  NSLog(@"返回值为success 0返回对方uid 1code过期 2认证失败****_________________%@",dic);
                                                                                  
                                                                                  if (dic == nil)
                                                                                  {
                                                                                      NSLog(@"字典为空%@",[error localizedDescription]);
                                                                                      return ;
                                                                                  }
                                                                                  
                                                                                  
                                                                                  if ([dic[@"success"] isEqualToString:@"0"])
                                                                                  {
                                                                                      NSString * otheruid = dic[@"uida"];
                                                                                      NSLog(@"验证邀请码成功返回对方的uid:%@",otheruid);
                                                                                      
                                                                                      NSUserDefaults * user = [NSUserDefaults standardUserDefaults];//将获得的对方的uid存起来
                                                                                      [user setObject:otheruid forKey:@"otheruid"];
                                                                                      [user synchronize];
                                                                                      
                                                                                      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                                      self.peiduichenggong = [storyboard instantiateViewControllerWithIdentifier:@"zhuyemian"];
                                                                                      self.window.rootViewController = self.peiduichenggong ;
                                                                                      
                                                                                      
                                                                                  }
                                                                                  if ([dic[@"success"] isEqualToString:@"1"])
                                                                                  {
                                                                                      UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"验证码已经过期了呀,重新获取一个吧" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                                                                                      [alert show];
                                                                                      
                                                                                      UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                                      self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"huoquyaoqingma"];
                                                                                  }
                                                                                  if ([dic[@"success"] isEqualToString:@"2"])
                                                                                  {
                                                                                      UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"邀请码不正确啊,重新输入一遍吧" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                                                                                      [alert show];
                                                                                      
                                                                                      UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                                      self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"tiyan"];
                                                                                      
                                                                                  }
                                                                                  
                                                                              }
                                                                                   failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                                                              {
                                                                                  UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"呀,网络异常,重新登陆一下吧" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                                                                                  [alert show];
                                                                                  
                                                                              }];
                                               
                                               op.responseSerializer=[AFHTTPResponseSerializer serializer];
                                               [op start];//开始请求数据
                                               
                                           }

                                       }
                                       if ([str isEqualToString:@"1"])
                                       {
                                           UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"您已配对成功,刷新页面,开始你的爱情之旅吧" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                                           [alert show];
                                           
                                       }
                                       if ([str isEqualToString:@"3"])
                                       {
                                           UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"网络异常,请重新登录" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                                           [alert show];
                                           

                                       }
                                       
                                       
                                       
                                   }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                   {
                                       NSLog(@"error = %@",error);
                                       
                                   }];
    
    
    
    op.responseSerializer=[AFHTTPResponseSerializer serializer];
    [op start];

    
    
    
    
    
    
    
    
    
    
    
    
    
}
#pragma mark 小语提示
//-(void)alertView:(NSString *)title msg:(NSString *)msg
//{
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    
//    [alert show];
//    
////    [self performSelector:@selector(disMissAlert:) withObject:alert afterDelay:2];
//}
#pragma mark 自动取消并跳转

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
