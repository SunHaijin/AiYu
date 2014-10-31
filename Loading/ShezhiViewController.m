//
//  ShezhiViewController.m
//  CEShi
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "ShezhiViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ShezhiViewController ()


@property(strong,nonatomic)NSData * userSexImageData;

@property (strong, nonatomic) IBOutlet UIButton *userimage;

@property (strong, nonatomic) IBOutlet UITextField *userNiCheng;
@property (strong, nonatomic) IBOutlet UIButton *userSexButton;
@property(strong,nonatomic)NSString * userSex;
@property (strong, nonatomic) IBOutlet UITextField *userTel;
@property (nonatomic,strong) UIImagePickerController*picker;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong)UIViewController * kaishipipei;
@property(nonatomic,strong)UIViewController * shezhi;
@property(nonatomic,strong)NSString * wbtoken;
@property(nonatomic,strong)NSString * uid;
@property(nonatomic,strong)NSString * imageURL;
@property(nonatomic,strong)NSString * name;


@property (strong, nonatomic) NSData *imageData;

@end

@implementation ShezhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//将正方形的图片变成圆形头像
    self.userimage.layer.cornerRadius = 60;
    self.userimage.imageView.layer.cornerRadius = 60;


    
    self.picker=[[UIImagePickerController alloc]init];
    self.picker.allowsEditing=YES;
    
    self.picker.delegate=self;


}
//选择性别的AlertView
- (IBAction)tapSelectSexButton:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"性别" message:@"男女的设置不一样的哦" delegate:self cancelButtonTitle:@"女" otherButtonTitles:@"男", nil];
    [alert show];
   
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
    
        UIImage * image1 = [UIImage imageNamed:@"woman.png"];
        [self.userSexButton setBackgroundImage:image1 forState:UIControlStateNormal];

        NSData * userSex = UIImagePNGRepresentation(image1);
        self.userSexImageData=userSex;
        self.userSex = @"0";

    }
    if (buttonIndex == 1)
    {
        UIImage * image1 = [UIImage imageNamed:@"man.png"];
        [self.userSexButton setBackgroundImage:image1 forState:UIControlStateNormal];
        
        NSData * userSex = UIImagePNGRepresentation(image1);
        self.userSexImageData=userSex;
        self.userSex = @"1";


        
     }
       }

//*************************关于打开相机或相册选取头像*********************************************************
- (IBAction)tapImageButton:(id)sender
{
//怎么解决?
    
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"选择照片来源" delegate:self  cancelButtonTitle:@"cancle" destructiveButtonTitle:nil otherButtonTitles:@"来自照片库",@"拍照", nil];
    
    [sheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        self.picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.picker animated:YES completion:^{
            ;
        }];
    }
    if (buttonIndex==1)
    {
        
        self.picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:self.picker animated:YES completion:^{
            ;
        }];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //从info字典参数中获取源图片
    UIImage*image=info[UIImagePickerControllerEditedImage];
    [self.userimage setImage:image forState:UIControlStateNormal];
   self.imageData = UIImagePNGRepresentation(image);
    
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString * path = [paths objectAtIndex:0];
    NSString * name = [NSString stringWithFormat:@"%ldimage.png",(long)[NSDate timeIntervalSinceReferenceDate]];
    path = [path stringByAppendingString:name];
    [self.imageData writeToFile:path atomically:YES];
    

    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
    
}
//************************************保存此页面信息并且存到nsuserdefults里面以传到设置里面********************************

- (IBAction)tapSave:(id)sender
{
    if ([self.userNiCheng.text isEqualToString:@""] || (self.userNiCheng.text==nil))
        
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"昵称不能为空哦" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        
    }
    
    else
        
    {
        
        AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]init];
        AFHTTPRequestOperation * op =[manager POST:@"http://lovemyqq.sinaapp.com/uploadfile.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                      {
                                          [formData appendPartWithFileData:self.imageData name:@"file" fileName:@"userImage" mimeType:@"png"];
                                          
                                          
                                      }
                                      
                                           success:^(AFHTTPRequestOperation *operation, id responseObject)
                                      {
                                          NSLog(@"图片上传成功");
                                          NSError * error;
                                          NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                                          self.imageURL = dic[@"fileUrl"];
                                          [self upLoad];

                                          
                                      }
                                           failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                      {
                                          NSLog(@"图片上传失败的原因%@",[error localizedDescription]);
                                      }];
        [self dismissViewControllerAnimated:YES completion:^{
            ;
        }];
        op.responseSerializer = [AFCompoundResponseSerializer serializer];
        [op start];
    }


        
    
    
}

- (void) upLoad
{
    NSString * codeString = @"http://lovemyqq.sinaapp.com/setUser.php";
    NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
    self.uid=[load stringForKey:@"uid"];
    self.wbtoken=[load stringForKey:@"accessToken"];
    self.imageURL = [load stringForKey:@"imageURL"];
    NSDictionary *dic=@{
                        @"access_token":self.wbtoken,
                        @"uid":self.uid,
                        @"name":self.userNiCheng.text,
                        @"sex":self.userSex,
                        @"tel":self.userTel.text,
                        @"userImage":self.imageURL
                        };
    
    NSLog(@"============%@",dic);
    
    AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc] init];
    AFHTTPRequestOperation *op = [manger GET:codeString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *list = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"-------++%@", list);
        
        if ([[list[1] objectForKey:@"success"] isEqualToString:@"0"])
        {
            NSDictionary *dict = list[0];
            NSUserDefaults *userDefauts = [NSUserDefaults standardUserDefaults];
            [userDefauts setValue:dict[@"name"] forKey:@"name"];
            [userDefauts setValue:dict[@"sex"] forKey:@"sex"];
            [userDefauts setValue:dict[@"tel"] forKey:@"tel"];
            [userDefauts setValue:dict[@"userImage"] forKey:@"userImage"];

            
            
        }
        
        //上传成功进入新的界面
        UIStoryboard * s = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        UITableViewController * vc = [s instantiateViewControllerWithIdentifier:@"kaishijinrupipei"];
        //    [vc setValue:p forKey:@"p"];
        
        self.view.window.rootViewController = vc;
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }] ;
    
    
    
    
    
    
    //此处上传个人信息到服务器,上传成功才会返回success的三个值,以后判断进入哪个界面
    
    //        AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];
    //        AFHTTPRequestOperation *op = [manager GET:codeString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
    //        {
    //            NSLog(@"上传信息成功");
    //
    //            NSLog(@"***上传个人信息情况==%@",responseObject);
    //
    //           //返回值为0 0代表成功   user 用户数据字典,包含用户所有数据信息
    //
    //            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小语提醒" message:@"信息已经保存,可以去设置里面修改,下面可以点击下一步开始你们的爱语之旅吧" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil, nil];
    //            [alert show];
    //
    //
    //
    //          //上传成功进入新的界面
    //            UIStoryboard * s = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //
    //            UITableViewController * vc = [s instantiateViewControllerWithIdentifier:@"kaishijinrupipei"];
    //            //    [vc setValue:p forKey:@"p"];
    //
    //            [self.navigationController pushViewController:vc animated:YES];
    //
    //
    //
    //        }
    //             failure:^(AFHTTPRequestOperation *operation, NSError *error)
    //        {
    //         //返回值为1 1表示失败
    //            NSLog(@"上传信息失败");
    //            NSLog(@"***上传信息失败,打印输出出错的原因或者位置%@",[error localizedDescription]);
    //
    //        }];
    op.responseSerializer = [AFCompoundResponseSerializer serializer];
    [op start];
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}



//点击页面任意位置收回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (IBAction)KaishiPipei:(id)sender
{
//保存个人信息,然后点击下一步开始进入匹配界面
//    UIStoryboard * s = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    
//    UITableViewController * vc = [s instantiateViewControllerWithIdentifier:@"kaishijinrupipei"];
////    [vc setValue:p forKey:@"p"];
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    
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
