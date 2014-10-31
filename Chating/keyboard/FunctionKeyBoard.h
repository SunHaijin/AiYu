//
//  FunctionKeyBoard.h
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FunctionKeyTypephoto,
    FunctionKeyTypecamera,
    FunctionKeyTypelocation,
    FunctionKeyTypename,
    FunctionKeyTypevideo,
    FunctionKeyTypevoice,
} FunctionKeyType;

typedef void(^FunctionBlock)(FunctionKeyType index);


@interface FunctionKeyBoard : UIView

-(void)setTapFunctionKeyBlock:(FunctionBlock)aBlock;

@end
