//
//  PIPEITableViewController.m
//  AiYu
//
//  Created by ibokan on 14/10/27.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "PIPEITableViewController.h"
#import "Config.h"
#import <AFNetworking/AFNetworking.h>
#import "YaoqingViewController.h"
#import "TiYanViewController.h"
@interface PIPEITableViewController ()
//@property (strong, nonatomic) YaoqingViewController * yaoqingViewController;
//@property (strong, nonatomic) TiYanViewController *tiYanViewController;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *seximageview;
@property (strong, nonatomic) IBOutlet UIImageView *headImageview;
@property (strong, nonatomic) IBOutlet UILabel *telLabel;

@property (strong, nonatomic) AFHTTPRequestOperationManager * manager;
@end

@implementation PIPEITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[AFHTTPRequestOperationManager alloc]init];
    
//    NSDictionary * dic = @{@"access_token":@"",@"uid":@"",@"wantuid":@""};
//    AFHTTPRequestOperation * op = [self.manager POST:@"http://lovemyqq.sinaapp.com/getUser.php" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSDictionary * dic = arr[0];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
//    }];
//    op.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [op start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}
#pragma mark 解除关系
- (IBAction)tapjiechuguanxi:(UIButton *)sender
{
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"确定解除匹配关系么?" delegate:self cancelButtonTitle:@"开玩笑的" destructiveButtonTitle:@"解除关系" otherButtonTitles: nil];
    [sheet showInView:self.view];
    
    

}

#pragma mark actionSheet委托方法 解除匹配
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
        NSString * access_token = [load stringForKey:@"access_token"];
        NSString * uid = [load stringForKey:@"uid"];
        NSDictionary * dic = @{@"access_token":access_token,@"uid":uid};
        
        AFHTTPRequestOperation * op = [self.manager POST:@"http://lovemyqq.sinaapp.com/endRelation.php" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            ;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",[error localizedDescription]);
        }];
        op.responseSerializer = [AFHTTPResponseSerializer serializer];
        [op start];    }
}

#pragma mark 进入匹配控制器
-(void)enterRelationVC{
    YaoqingViewController *start = [[YaoqingViewController new]init];
    self.view.window.rootViewController = start;
}

#pragma mark 提示
-(void)alertView:(NSString *)title msg:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
    [self performSelector:@selector(disMissAlert:) withObject:alert afterDelay:2];
}

#pragma mark 自动取消并跳转
-(void)disMissAlert:(UIAlertView *)alert{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

#pragma mark 认证失败, 退出登录
- (void)exit{
    TiYanViewController *start = [[TiYanViewController new]init];
    self.view.window.rootViewController = start;
    [[AccountTool sharedAccountTool] signOut:[AccountTool sharedAccountTool].currentAccount];
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
