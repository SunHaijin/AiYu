//
//  PasswordTableViewController.m
//  AiYu
//
//  Created by ibokan on 14/10/21.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "PasswordTableViewController.h"

@interface PasswordTableViewController ()
{
    NSString * str;
    NSString * i;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;
@property (strong, nonatomic) IBOutlet UIImageView *iamgeView3;


@end

@implementation PasswordTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
    NSString * I = [load stringForKey:@"i"];
    if ([I  isEqual: @"0"])
    {
        self.imageView1.image =[UIImage imageNamed:@"对号.jpg"];
    }
    if ([I  isEqual: @"1"])
    {
        self.imageView2.image =[UIImage imageNamed:@"对号.jpg"];
    }
    if ([I  isEqual: @"2"])
    {
        self.iamgeView3.image =[UIImage imageNamed:@"对号.jpg"];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    //self.imageView1.image = [UIImage imageNamed:@"对号.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        i = @"0";
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:i forKey:@"i"];
        [user synchronize];
        //选择无密码的时候取消数字密码
        NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
        NSString * password = [load stringForKey:@"password"];
        if (![password  isEqual:@"0"])
        {
            PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionEnter];
            passcodeViewController.delegate = self;
            
            NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
            NSString * password = [load stringForKey:@"password"];
            if (password != nil) {
                
                passcodeViewController.passcode =password;
            }
            passcodeViewController.simple = YES;
            [self presentViewController:passcodeViewController animated:NO completion:nil];
        }
        
        [self tapNOPassword];
        
    }
    if (indexPath.row == 1)
    {
        i = @"1";
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:i forKey:@"i"];
        [user synchronize];
        //选择无密码的时候取消数字密码
        NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
        NSString * password = [load stringForKey:@"password"];
        NSLog(@"   %@",password);
        if (![password  isEqual:@"0"])
        {
            PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionEnter];
            passcodeViewController.delegate = self;
            
            NSUserDefaults * load = [NSUserDefaults standardUserDefaults];
            NSString * password = [load stringForKey:@"password"];
            if (password != nil) {
                
                passcodeViewController.passcode =password;
            }
            passcodeViewController.simple = YES;
            [self presentViewController:passcodeViewController animated:NO completion:nil];
        }
        
        [self tapTouchID];
    }
    if (indexPath.row == 2)
    {
        PAPasscodeViewController *passcodeVC = [[PAPasscodeViewController alloc]initForAction:PasscodeActionSet];
        passcodeVC.delegate = self;
        
        [self presentViewController:passcodeVC animated:YES completion:nil];
        i = @"2";
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:i forKey:@"i"];
        [user synchronize];
        [self tapPassword];
    }
}
-(void)tapNOPassword
{
    self.imageView1.image = [UIImage imageNamed:@"对号.jpg"];
    self.imageView2.image = nil;
    self.iamgeView3.image = nil;
}
-(void)tapTouchID
{
    self.imageView2.image = [UIImage imageNamed:@"对号.jpg"];
    self.imageView1.image = nil;
    self.iamgeView3.image = nil;
}
-(void)tapPassword
{
    self.iamgeView3.image = [UIImage imageNamed:@"对号.jpg"];
    self.imageView1.image = nil;
    self.imageView2.image = nil;
    
}
#pragma mark 密码设置
-(void)mimashezhi
{
    PAPasscodeViewController *passcodeVC = [[PAPasscodeViewController alloc]initForAction:PasscodeActionSet];
    passcodeVC.delegate = self;
    passcodeVC.simple = YES;
    [self presentViewController:passcodeVC animated:YES completion:nil];

}
#pragma mark - PAPasscodeViewControllerDelegate

- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)PAPasscodeViewControllerDidSetPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        str = controller.passcode;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:str forKey:@"password"];
        [user synchronize];

        
        NSLog(@"Password: %@",controller.passcode);
    }];
}

- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller {
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * temp = @"0";
    [user setObject:temp forKey:@"password"];
    [user synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
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
