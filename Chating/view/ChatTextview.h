//
//  ChatTextview.h
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceKeyBoard.h"
#import "FunctionKeyBoard.h"

typedef enum : NSUInteger {
    FunctionButtonphoto,
    FunctionButtoncamera,
    FunctionButtonlocation,
    FunctionButtonname,
    FunctionButtonvideo,
    FunctionButtonvoice,
} FunctionButton;

typedef enum : NSUInteger {
    MyKeyBoardFace,
    MyKeyBoardFunction,
    MyKeyBoardSystem,
    MyKeyBoardNone,
} MyKeyBoard;

typedef void(^FunctionButtonBlock)(FunctionButton buttonIndex);
typedef void (^SendBlock)(NSString *text);
@interface ChatTextview : UITextView

-(void)setMyKeyBoard:(MyKeyBoard)keyBoard;
-(void)setFunctionButtonBlock:(FunctionButtonBlock)aBlock;
-(void)setSendTextBlock:(SendBlock)aBlock;
-(NSString *)textString;

@end
