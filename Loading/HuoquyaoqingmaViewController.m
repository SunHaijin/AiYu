//
//  HuoquyaoqingmaViewController.m
//  CEShi
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "HuoquyaoqingmaViewController.h"
#import "AccountTool.h"
#import "Account.h"
#import "Common.h"
#import "Config.h"
#import <AFNetworking/AFNetworking.h>
#import <MessageUI/MessageUI.h>

@interface HuoquyaoqingmaViewController ()
@property (strong, nonatomic) IBOutlet UILabel *codeLabel;

@end

@implementation HuoquyaoqingmaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    
}
- (IBAction)tapHuoquYaoqingma:(id)sender
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
                                       //解析得到了云存储器的URL
                                       //success的返回值:0正常获取code 1配对成功 3认证失败
                                       
                                       NSLog(@"success的返回值:0正常获取code 1配对成功 3认证失败^^^^^^^^^^%@",str);
                                       
                                       NSString *code=dic[@"code"];
                                       
                                       self.codeLabel.text=code;
                                       NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                                       [user setObject:code forKey:@"code"];
                                       [user synchronize];
                                       
                                       
                                       
                                   }
                                            failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                   {
                                       NSLog(@"error = %@",error);
                                       
                                   }];
    
    
    
    op.responseSerializer=[AFHTTPResponseSerializer serializer];
    [op start];

    
    
}
//短信发送成功与否的回调提示
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSString * tipContent;
    switch (result)
    {
        case MessageComposeResultCancelled:
            //取消
            tipContent = @"已经取消";
            break;
         case MessageComposeResultSent:
            //发送
            tipContent = @"发送成功";
            break;
            case MessageComposeResultFailed:
            //失败
            tipContent = @"发送失败";
            break;
            
        default:
            break;
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提示" message:@"取消短信" delegate:nil cancelButtonTitle:@"是的" otherButtonTitles:nil];
    [alert show];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




- (IBAction)sendMesageToOtherOne:(id)sender
{
//    NSString *strUrl = [NSString stringWithFormat:@"亲爱的, 和我一起来玩爱语吧. 这是最棒的情侣应用, 我想和你一起玩. 配对邀请码: %@",self.codeLabel.text];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",strUrl]];
//    [[UIApplication sharedApplication] openURL:url];
    

    if ([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
        controller.recipients = [NSArray arrayWithObject:@"10086"];
        controller.body = [ NSString stringWithFormat:@"亲爱的, 和我一起来玩爱语吧. 这是最棒的情侣应用, 我想和你一起玩.邀请码是:%@",self.codeLabel.text] ;
        controller.messageComposeDelegate =self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers]lastObject]navigationItem]setTitle:@"爱语短信"];
        //修改短信标题
        
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"这个设备不能发短信,你可以悄悄告诉你的TA吧" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
    }
    
    
    
}



//点击刷新的时候进入主界面
- (IBAction)tapRefresh:(id)sender
{
    
    
    
    
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
