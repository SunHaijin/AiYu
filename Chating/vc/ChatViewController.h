//
//  ChatViewController.h
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ITextCell.h"
#import "IImageCell.h"
#import "IVideoCell.h"
#import "IVoiceCell.h"
#import "HeTextCell.h"
#import "HeImageCell.h"
#import "HeVioceCell.h"
#import "HeVideoCell.h"
#import "UITableViewCell+Function.h"
#import <XMPPMessageArchiving_Contact_CoreDataObject.h>
#import <XMPPMessageArchiving_Message_CoreDataObject.h>
#import <XMPP.h>

@interface ChatViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,NSFetchedResultsControllerDelegate,UIActionSheetDelegate,XMPPStreamDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)XMPPMessageArchiving_Contact_CoreDataObject*contact;


@end
