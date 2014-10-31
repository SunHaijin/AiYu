//
//  ChatViewController.m
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatToolView.h"
#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"
#import <XMPP.h>
#import <XMPPStream.h>
#import <XMPPMessage.h>
#import <XMPPMessageArchiving_Message_CoreDataObject.h>
@interface ChatViewController ()

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)ChatToolView *toolview;
@property(nonatomic,strong)XMPPStream * xmppStream;
@property(nonatomic,strong)XMPPJID * jid;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString *number;
@property(nonatomic,strong)UIImagePickerController *piker;
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultsController;
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property (strong, nonatomic) NSURL *videoURL;


@end

@implementation ChatViewController



-(void)xmppStreamDidConnect:(XMPPStream *)sender

{
    
    NSLog(@"%s",__FUNCTION__);
    
    [self.xmppStream authenticateWithPassword:@"000000" error:nil];
    
    
}
-(void)xmppStreamConnectDidTimeout:(XMPPStream *)sender
{
    
    NSLog(@"%s",__FUNCTION__);
    
    
}
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"登陆成功！");
    
    XMPPPresence * pre = [XMPPPresence presence];
    [self.xmppStream sendElement:pre];
}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"密码错误");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.number=[[NSString alloc]initWithFormat:@"13120201471"];
    
    self.jid=[XMPPJID jidWithUser:@"yxj" domain:@"xuyingcloud.com" resource:nil];
    self.toolview=[[ChatToolView alloc]initWithFrame:CGRectZero];
    self.toolview.translatesAutoresizingMaskIntoConstraints=NO;
    self.toolview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.toolview];
    
    UIApplication *app=[UIApplication sharedApplication];
    id delegate=[app delegate];
    self.managedObjectContext=[delegate managedObjectContext];
    self.xmppStream=[delegate xmppStream];
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    XMPPJID * jid1 = [XMPPJID jidWithUser:@"yangbin" domain:@"xuyingcloud.com" resource:@"test"];
    [self.xmppStream setMyJID:jid1];
    
    [self.xmppStream connectWithTimeout:10 error:nil];
    
    
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([XMPPMessageArchiving_Message_CoreDataObject class])];
    NSSortDescriptor * s = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    [request setSortDescriptors:@[s]];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];

    
    
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receivetongzhicenter:) name:UIKeyboardWillChangeFrameNotification object:nil];
    

    
//    self.managedObjectContext=[delegate managedObjectContext];
//    self.xmppStream=[delegate xmppStream];
    
    self.manager=[[AFHTTPRequestOperationManager alloc]init];
    self.piker=[[UIImagePickerController alloc]init];
    self.piker.delegate=self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //创建toolview和tableview
    self.toolview =[[ChatToolView alloc]initWithFrame:CGRectZero];
    self.toolview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.toolview];
   
    __weak __block ChatViewController * copy_self =self;
    [self.toolview.textField setSendTextBlock:^(NSString *text) {
        NSLog(@"%@",text);
        NSDictionary * body = @{@"type": @"Text",@"content":text};
        NSError * error;
        NSLog(@"发表的内容:%@",text);
        NSData * data = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
        if (!data) {
            NSLog(@"body转Data error = %@",[error localizedDescription]);
            return ;
        }
        NSString * bodyStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        XMPPMessage * message = [XMPPMessage messageWithType:@"chat" to:copy_self.jid];
        [message addBody:bodyStr];
        [copy_self.xmppStream sendElement:message];
        [copy_self.tableView reloadData];

        
    }];
    [self.toolview setFunctionEventBlock:^(FunctionButton buttonIndex) {
        switch (buttonIndex)
        {
            case  FunctionButtonphoto:
                
                [copy_self tapcamera];
                NSLog(@"点击相册按钮");
                break;
            case  FunctionButtonlocation:
            {
                
                UIStoryboard *s=[UIStoryboard storyboardWithName:@"Chat" bundle:[NSBundle mainBundle]];
                
                UIViewController *vc=[s instantiateViewControllerWithIdentifier:@"map"];
                [copy_self presentViewController:vc animated:YES completion:nil];
                NSLog(@"44444444444444");
                break;
            }

                break;
            case FunctionButtonvoice:
                [copy_self tapvoicephone];
                NSLog(@"点击语音通话按钮");
                break;
            default:
                break;
        }
    }];
   [self.toolview setSendBlock:^(NSString *text) {
      
       NSDictionary * body = @{@"type": @"Text",@"content":text};
       NSError * error;
       NSLog(@"发表的内容:%@",text);
       NSData * data = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
       if (!data) {
           NSLog(@"body转Data error = %@",[error localizedDescription]);
           return ;
       }
       NSString * bodyStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       
       XMPPMessage * message = [XMPPMessage messageWithType:@"chat" to:copy_self.jid];
       [message addBody:bodyStr];
       [copy_self.xmppStream sendElement:message];
       [copy_self.tableView reloadData];

   }];
    
    [self.toolview setFinishRecordBlock:^(NSString *path) {
        AFHTTPRequestOperation * op = [copy_self.manager POST:@"http://xuyingtest.sinaapp.com/uploadfile.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSURL * url = [NSURL fileURLWithPath:path];
            NSError * error;
            
            if (![formData appendPartWithFileURL:url name:@"file" error:&error]) {
                NSLog(@"formData拼接错误 %@",[error localizedDescription]);
                return ;
            }
            
            
        } success:^(AFHTTPRequestOperation *operation, NSData * responseObject)
                                       {
                                           
                                           NSError * error;
                                           NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                                           if (!dic) {
                                               NSLog(@"返回值为空%@",[error localizedDescription]);
                                               return ;
                                           }
                                           NSString * str = dic[@"success"];
                                           NSDictionary * body = @{@"type": @"Voice",@"content":str};
                                           NSData * bodyData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
                                           NSString * bodystr = [[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding];
                                           XMPPMessage * message=[XMPPMessage messageWithType:@"chat" to:copy_self.jid ];
                                           [message addBody:bodystr];
                                           [copy_self.xmppStream sendElement:message];
                                           [copy_self.tableView reloadData];
                                           
                                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           NSLog(@"录音发送失败%@",[error localizedDescription]);
                                       }];
        op.responseSerializer = [AFHTTPResponseSerializer serializer];
        [op start];
        
        
    }];


    //约束
    self.toolview.translatesAutoresizingMaskIntoConstraints=NO;
    NSArray *c1=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_toolview]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_toolview)];
    [self.view addConstraints:c1];
    NSArray *c2=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolview(44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_toolview)];
    [self.view addConstraints:c2];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//收到通知中心回调
-(void)receivetongzhicenter:(NSNotification *)noti
{
    //通过相应的数据，改变一下self的frame；
    NSValue * vB = noti.userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect frameB = [vB CGRectValue];
    
    //键盘的坐标参考系为系统屏幕
    //只当正向使用App时，VC的参考系和屏幕参考系一样
    //当旋转时，需要将键盘在系统屏幕参考系下的坐标转换为VC根视图参考系下的坐标
    frameB = [self.view convertRect:frameB fromView:self.view.window];
    
    //其余代码，和之前一样
    
    NSDictionary * dic = noti.userInfo;
    //    NSLog(@"%@",dic);
    
    NSNumber * d = dic[UIKeyboardAnimationDurationUserInfoKey];
    NSNumber * c = dic[UIKeyboardAnimationCurveUserInfoKey];
    
    NSValue * beginF = dic[UIKeyboardFrameBeginUserInfoKey];
    NSValue * endF = dic[UIKeyboardFrameEndUserInfoKey];
    
    CGRect bf = [beginF CGRectValue];
    bf = [self.view convertRect:bf fromView:self.view.window];
    CGRect ef = [endF CGRectValue];
    ef = [self.view convertRect:ef fromView:self.view.window];
    
    CGFloat dy = ef.origin.y - bf.origin.y;
    
    CGRect frame = self.view.frame;
    //    CGRect frame = frameB;
    
    frame.size.height = ef.origin.y;
    
    [UIView animateWithDuration:[d floatValue] animations:^{
        [UIView setAnimationCurve:[c intValue]];
        self.view.frame = frame;
        [self.view layoutIfNeeded];
    }];
}


//点击相机功能
-(void)tapcamera
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"图片库" otherButtonTitles:@"照相机", nil];
    
    
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    switch (buttonIndex)
    {
        case 1:
            [self shootNewPhoto];
            break;
        case 0:
            [self choosePhoto];
            break;
        default:
            break;
    }
    
}
-(void)choosePhoto
{
    //检查设备是否有图片库(用图片选取器的 isSourceTypeAvailable 类方法)
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备不存在图片库" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
    //如果图片选取器不存在,则初始化并指定委托
    if (!self.imagePickerController)
    {
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.delegate = self;
    }
    
    //指定图片选取器可以获取哪些类型的媒体(图片选取器的mediaTypes属性.视频:kUTTypeMovie)
    self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *) kUTTypeMovie];
    
    //指定图片选取器的来源为图片库(图片选取器的sourceType属性.也可以从照相机取图片:UIImagePickerControllerSourceTypeCamera)
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //弹出图片选取器(它是控制器.以模态视图弹出)
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}
-(void)shootNewPhoto
{
    //检查设备是否有照相机(用图片选取器的 isSourceTypeAvailable 类方法)
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备不存在照相机" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
    //如果图片选取器不存在,则初始化并指定委托
    if (!self.imagePickerController)
    {
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.delegate = self;
    }
    //指定图片的来源为摄像头
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //指定照相机可以获取哪些媒体类型
    self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    //指定照相机的摄像头的捕获模式.有两种,一种是照片,一种是视频
    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    
    
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}
#pragma mark -图片选取器的delegate方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    NSLog(@"选取图片的路径:%@",image);
    NSData *data=UIImagePNGRepresentation(image);
    
    __weak __block ChatViewController *copy_self=self;
    AFHTTPRequestOperation *op=[self.manager POST:@"http://xuyingtest.sinaapp.com/uploadfile.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         [formData appendPartWithFileData:data name:@"file" fileName:@"image" mimeType:@"png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString * content = dic[@"success"];
        NSDictionary * body =@{@"type": @"Image",@"content":content};
        
        NSData * bodyData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:nil];
        NSString * bodyStr = [[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding];
        XMPPMessage * message = [XMPPMessage messageWithType:@"chat" to:copy_self.jid];
        [message addBody:bodyStr];
        [copy_self.xmppStream sendElement:message];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"图片上传失败:%@",[error localizedDescription]);
    }];
    op.responseSerializer=[AFHTTPResponseSerializer serializer];
    [op start];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.toolview setNomalType];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    [self.toolview setNomalType];
}
//点击定位按钮

//点击语音通话按钮
-(void)tapvoicephone
{
    NSLog(@"收到运行点击语音电话功能");
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否打电话给对方" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            [self phonehe];
            break;
        default:
            break;
    }
}
-(void)phonehe
{
    NSString * num = [[NSString alloc]initWithFormat:@"tel://%@",self.number];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:num]];
    NSLog(@"%@",num);
}

//判断cell,显示cell类型
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    NSDictionary * message = self.messages[indexPath.row];
//    //    NSLog(@"666666666666heightForRowAtIndexPath = %g",[self cellHeightWithDic:message]);
//    
//    XMPPMessageArchiving_Message_CoreDataObject * message = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    NSLog(@"55555555555555");
//    return [self cellHeightWithDic:message];
//    //return 100;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSLog(@"111111111");
    XMPPMessageArchiving_Message_CoreDataObject * message = [self.fetchedResultsController objectAtIndexPath:indexPath];

    return [self cellHeightWithDic:message];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
 //   NSLog(@"2222222222");
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // NSLog(@"-------%d",self.messages.count);
    NSArray * sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo>sectionInfo = sections[section];
    int a =[sectionInfo numberOfObjects];
    NSLog(@"a = %d",a);
    return a;
  //  NSLog(@"333333333");
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XMPPMessageArchiving_Message_CoreDataObject * message = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString * identifer = [self identifierWithMessage:message];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    NSString * body = message.body;
    NSData * data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    [cell setCellInfo:dic];
    NSLog(@"44444444444");
    return cell;
}
#pragma mark - 本类相关功能实现
//通过message字典，返回cell的重用标识符
-(NSString *)identifierWithMessage:(XMPPMessageArchiving_Message_CoreDataObject *)message
{
    NSString * body = message.body;
    NSData * data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSString *str;
    if ([message.outgoing isEqualToValue:[NSNumber numberWithInt:1]])
    {
        
        if ([dic[@"type"] isEqualToString:@"Text"])
        {
            str = @"ITextCell";
            NSLog(@"kkkkkkkkk");
        }
        if ([dic[@"type"] isEqualToString:@"Voice"]) {
            str = @"IVoiceCell";
        }
        if ([dic[@"type"] isEqualToString:@"Image"]) {
            str = @"IImageCell";
            NSLog(@"55555555555");
        }
        if ([dic[@"type"] isEqualToString:@"Video"]) {
            str = @"IVideoCell";
        }
        if ([dic[@"type"] isEqualToString:@"Location"]) {
            str = @"ILocationCell";
        }
        
    }
            else
            {
            if ([dic[@"type"] isEqualToString:@"Text"]) {
                str = @"HeTextCell";
            }
            if ([dic[@"type"] isEqualToString:@"Voice"]) {
                str = @"HeVoiceCell";
            }
            if ([dic[@"type"] isEqualToString:@"Image"]) {
                str = @"HeImageCell";
            }
            if ([dic[@"type"] isEqualToString:@"Video"]) {
                str = @"HeVideoCell";
            }
            if ([dic[@"type"] isEqualToString:@"Location"]) {
                str = @"HeLocationCell";
            }
        }
    NSLog(@"identifier   =    %@",str);
    return str;
}
-(CGFloat)cellHeightWithDic:(XMPPMessageArchiving_Message_CoreDataObject *)message
{
    NSString * body = message.body;
    NSData * data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    CGFloat  gaodu = 0;
    
    if ([dic[@"type"] isEqualToString:@"Text"]) {
        
        NSString * text = dic[@"content"];
        TextWithBiaoqing * tb = [[TextWithBiaoqing alloc]init];
        NSAttributedString * attstr = [tb changeTextWithBiaoqing:text];
        CGRect frame = [attstr boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        double height = frame.size.height;
        //NSLog(@"height = %g",height);
        gaodu = 20 + height;
        if (gaodu < 55) {
            gaodu = 55;
        }
        else
        {
            gaodu = 20 + height;
        }
        
        
    }
    if ([dic[@"type"] isEqualToString:@"Voice"]) {
        
        gaodu = 20 + 35;
    }
    if ([dic[@"type"] isEqualToString:@"Image"])
    {
        
        gaodu = 80 + 20;
        NSLog(@"66666666666");
    }
    NSLog(@"--------高度-------------%g",gaodu);
    return gaodu;
}

//当CoreData的数据将要发生改变时，FRC产生的回调
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

//分区改变状况
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

//数据改变状况
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            //让tableView在newIndexPath位置插入一个cell
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            //让tableView刷新indexPath位置上的cell
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            //            [self.searchDisplayController.searchResultsTableView reloadData];
            //            [self.searchDisplayController.searchResultsTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

//当CoreData的数据完成改变时，FRC产生的回调
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
    //    [self.searchDisplayController.searchResultsTableView endUpdates];
}



@end

