//
//  FaceKeyBoard.h
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    buttonTagA,
    buttonTagB,
    buttonTagC,
    
} buttonTag;

typedef void(^FaceBlock)(buttonTag tag);
typedef void(^FaceSendBlock)(buttonTag tag);

@interface FaceKeyBoard : UIView

-(void)setTapFaceButtonBlock:(FaceBlock)aBlock;
-(void)setSendBlock:(FaceSendBlock)aBlock;

@end
