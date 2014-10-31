//
//  chattingBackgroundImageTableViewController.m
//  AiYu
//
//  Created by ibokan on 14/10/27.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "chattingBackgroundImageTableViewController.h"
#import "Config.h"
#import <AFNetworking/AFNetworking.h>
@interface chattingBackgroundImageTableViewController ()
{
    UIImage * _userImage;
    NSString * Url;
}
@property (strong, nonatomic) UIImagePickerController * picker;
@property (strong, nonatomic) AFHTTPRequestOperationManager * manager;
@end

@implementation chattingBackgroundImageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.manager = [[AFHTTPRequestOperationManager alloc]init];
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapxiangceimagebutton:(UIButton *)sender
{
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册中选" otherButtonTitles:@"拍摄照片", nil];
    
    
    [sheet showInView:self.view];
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
    
    //NSData * imageData = UIImagePNGRepresentation(image);
    NSData * data = UIImagePNGRepresentation(image);
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
    NSData * imageData = UIImagePNGRepresentation(_userImage);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:imageData forKey:@"backgroundimage"];
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
//#pragma mark 裁剪照片
//-(UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size
//{
//    //创建一个bitmap的context
//    //并把他设置成当前的context
//    UIGraphicsBeginImageContext(size);
//    //绘制图片的大小
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    //从当前context中创建一个改变大小后的图片
//    UIImage *endImage=UIGraphicsGetImageFromCurrentImageContext();
//    //让当前的context出堆栈
//    UIGraphicsEndImageContext();
//    return endImage;
//}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
