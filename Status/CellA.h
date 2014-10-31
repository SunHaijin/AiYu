//
//  CellA.h
//  SinaWeibo
//
//  Created by 杨斌 on 14-9-4.
//  Copyright (c) 2014年 杨斌. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^TapBlock)(UITableViewCell * cell,int buttonTag);//定义一个block类型

@interface CellA : UITableViewCell


-(void)setTapButtonBlock:(TapBlock) block;  //给外界的接口,也是一个block回调,当按钮点击的时候,来调用block
@end
