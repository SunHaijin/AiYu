//
//  ChatToolView.h
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatTextview.h"

typedef enum : NSUInteger {
    ToolViewTypeSpeak,
    ToolViewTypeInputText,
    ToolViewTypeInputFace,
    ToolViewTypeInputFunction,
    ToolViewTypeNomal,
} ToolViewType;

typedef void(^ToolViewFunctionBlock)(FunctionButton functionIndex);
typedef void(^ToolViewSendBlock)(NSString * text);
typedef void(^ToolViewRecordBlock)(NSString * data);
typedef void(^ToolViewSizeChangeBlock)(CGSize size);

@interface ChatToolView : UIView<UITextViewDelegate>
@property(nonatomic,strong)ChatTextview *textField;
-(void)otherInit;
-(void)setToolViewType:(ToolViewType)type;
-(ToolViewType)toolViewType;

-(void)setFunctionEventBlock:(ToolViewFunctionBlock)aBlock;
-(void)setSendBlock:(ToolViewSendBlock)aBlock;
-(void)setFinishRecordBlock:(ToolViewRecordBlock)aBlock;
-(void)setSizeChangeBlock:(ToolViewSizeChangeBlock)aBlock;


-(void)setNomalType;

@end
