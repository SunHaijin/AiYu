//
//  personInformationTableViewController.m
//  AiYu
//
//  Created by ibokan on 14/10/20.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "personInformationTableViewController.h"
#import "Config.h"
#import <AFNetworking/AFNetworking.h>
@interface personInformationTableViewController ()
{
    long int _currentIndex;
    NSArray *_data;
    
    NSString *_nameValue;
    NSString *_sexValue;
    NSString *_userImageValue;
    NSString *_telValue;
    UIImage *_sexImage;
    UIImage *_userImage;
    NSString * Url;
}

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sexImageView;
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *TelLabel;
@property (strong, nonatomic) UIImagePickerController * picker;
@property (strong, nonatomic) AFHTTPRequestOperationManager * manager;
@end

@implementation personInformationTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"11111111");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
    
    
    
    
    
    
    self.manager = [[AFHTTPRequestOperationManager alloc]init];
    //1. 初始化数据, 从本地账号读取
    //_data = [NSArray arrayWithObjects:@"昵称", @"性别", @"头像", @"电话", nil];
    //AccountTool *acc = [AccountTool sharedAccountTool].currentAccount;
    NSDictionary * dic = @{@"access_token":@"2.006ZC5CE0iEtXt78a6410d19jTfFMC",@"uid":@"3699813755"};
    AFHTTPRequestOperation * op1 = [self.manager POST:@"http://lovemyqq.sinaapp.com/login.php"   parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"a = %@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        NSLog(@"--------------");
    }];
    op1.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op1 start];
    AFHTTPRequestOperation * op = [self.manager POST:@"http://lovemyqq.sinaapp.com/getUser.php" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"///////%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]);
        NSArray * arr =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"****************%@",arr[0]);
        NSDictionary * dici = arr[0];
        Url = [NSString stringWithFormat:@"%@",dici[@"userImage"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"??????%@",[error localizedDescription]);
    }];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
    
    _nameValue = [load stringForKey:@"name"];
    self.nameLabel.text = _nameValue;
    NSLog(@"%@",kName);
    _sexValue = [load stringForKey:@"sex"];
    NSData * data = [load dataForKey:@"userImage"];
    
    _userImage = [UIImage imageWithData:data];
    self.headImageView.image = _userImage;
    _telValue = [load stringForKey:@"tel"];
    
    if ([_sexValue isEqualToString:@"男"]) {
        _sexImage =  [UIImage imageNamed:@"性别男"];
    } else {
        _sexImage =  [UIImage imageNamed:@"性别女"];
    }
    self.sexImageView.image = _sexImage;
    //_userImage = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
    //self.headImageView.image = [UIImage imageNamed:@"male.png"];
    self.headImageView.image = _userImage;
    self.TelLabel.text = _telValue;
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.allowsEditing = YES;
    self.picker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 修改昵称
    if (indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"设置昵称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert textFieldAtIndex:0].text = _nameValue;
        _currentIndex = indexPath.row + 100;
        self.nameLabel.text = _nameValue;
        [alert show];
    }
    
    //2. 修改性别
    if (indexPath.row == 1)
    {
        UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"设置性别" message:nil delegate:self cancelButtonTitle:@"男" otherButtonTitles:@"女", nil];
        _currentIndex = indexPath.row + 100;
        self.sexImageView.image = _sexImage;
        [alter show];
        
    }
    
    
    //3. 设置头像
    if (indexPath.row == 2)
    {
        UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册中选" otherButtonTitles:@"拍摄照片", nil];
        _currentIndex = indexPath.row + 100;
        
        [sheet showInView:self.view];
    }
    
    //4. 设置电话
    if (indexPath.row == 3)
    {
        UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"设置电话" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alter.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alter textFieldAtIndex:0].text = _telValue;
        _currentIndex = indexPath.row + 100;
        self.TelLabel.text = _telValue;
        [alter show];
    }
    
}

#pragma mark AlertVIew 委托方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //1. 获取alert文本,更改数据
    if (_currentIndex == 100) {
        NSString *name = [alertView textFieldAtIndex:0].text;
        if (buttonIndex == 1) {
            _nameValue = name;
            self.nameLabel.text = _nameValue;
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            [user setObject:_nameValue forKey:@"name"];
            
            [user synchronize];//完成存储
            
            
        }
    }
    
    if (_currentIndex == 101) {
        if (buttonIndex == 0) {
            _sexValue = @"男";
            _sexImage  = [UIImage imageNamed:@"性别男"];
            self.sexImageView.image = _sexImage;
        }
        if (buttonIndex == 1) {
            _sexValue = @"女";
            _sexImage  = [UIImage imageNamed:@"性别女"];
            self.sexImageView.image = _sexImage;
        }
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:_sexValue forKey:@"sex"];
        [user synchronize];//完成存储
        
    }
    
    if (_currentIndex == 103) {
        NSString *tel = [alertView textFieldAtIndex:0].text;
        if (buttonIndex == 1) {
            _telValue = tel;
            self.TelLabel.text = _telValue;
            
        }
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:_telValue forKey:@"tel"];
        [user synchronize];//完成存储
        
    }
    
}

#pragma mark - ActionSheet 委托方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //照片库
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //检查图片选取器是否存在，不存在创建并指定委托
        if (!self.picker)
        {
            self.picker=[[UIImagePickerController alloc]init];
            self.picker.delegate=self;
        }
        //设定获取来源为图片库
        self.picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:self.picker animated:YES completion:^{
            ;
        }];
    }
    if (buttonIndex == 1)
    {
        //拍照
        //检查图片选取器是否存在，不存在创建并指定委托
        if (!self.picker)
        {
            self.picker=[[UIImagePickerController alloc]init];
            self.picker.delegate=self;
        }
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设定图片的来源为摄像头
        self.picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        self.picker.allowsEditing=YES;
        //设定图片选取器的摄像头捕获模式
        self.picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
        [self presentViewController:self.picker animated:YES completion:^{
            ;
        }];
    }
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = info[UIImagePickerControllerEditedImage];
    _userImage = image;
    UIImage *smallImage=[self scaleToSize:image size:CGSizeMake(120, 120)];
    //NSData * imageData = UIImagePNGRepresentation(image);
    NSData * data = UIImagePNGRepresentation(smallImage);
    [self dismissViewControllerAnimated:YES completion:^{
        self.headImageView.image = _userImage;
    }];
    NSData * imageData = UIImagePNGRepresentation(_userImage);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:imageData forKey:@"userImage"];
    [user synchronize];
    NSDictionary * dic = @{@"access_token":@"2.006ZC5CE0iEtXt78a6410d19jTfFMC",@"uid":@"3699813755"};
    AFHTTPRequestOperation * op = [self.manager POST:@"http://lovemyqq.sinaapp.com/uploadfile.php" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        [formData appendPartWithFileData:data name:@"file" fileName:@"image" mimeType:@"png"];
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"0000000000000000000 a =  %@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]);
        NSDictionary * DIC =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Url = DIC[@"fileUrl"];
        NSLog(@"Url    =   %@",Url);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];

    
    
}
#pragma mark 裁剪照片
-(UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size
{
    //创建一个bitmap的context
    //并把他设置成当前的context
    UIGraphicsBeginImageContext(size);
    //绘制图片的大小
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //从当前context中创建一个改变大小后的图片
    UIImage *endImage=UIGraphicsGetImageFromCurrentImageContext();
    //让当前的context出堆栈
    UIGraphicsEndImageContext();
    return endImage;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}


-(void)viewWillDisappear:(BOOL)animated
{
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSDictionary * dic =@{@"access_token":@"2.006ZC5CE0iEtXt78a6410d19jTfFMC",@"uid":@"3699813755",@"name":_nameValue,@"sex":_sexValue,@"tel":_telValue,@"userimage":Url,@"backgroundimage":@"",@"deviceToken":@""};
    AFHTTPRequestOperation * op = [self.manager POST:@"http://lovemyqq.sinaapp.com/setUser.php"   parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"a = %@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        NSLog(@"--------------");
    }];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];



}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end


