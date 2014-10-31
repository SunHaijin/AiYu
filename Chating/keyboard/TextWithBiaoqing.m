
//
//  TextWithBiaoqing.m
//  AiYu
//
//  Created by ibokan on 14-10-21.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "TextWithBiaoqing.h"

@implementation TextWithBiaoqing
-(NSAttributedString *)changeTextWithBiaoqing:(NSString *)text
{
    //先把普通的字符串text转化生成Attributed类型的字符串
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    
    NSString * zhengze = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    
    NSError * error;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:zhengze options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re)
    {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    NSArray * arr = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString * path = [bundle pathForResource:@"emoticons" ofType:@"plist"];
    NSArray * face = [[NSArray alloc]initWithContentsOfFile:path];
    
    //如果有多个表情图，必须从后往前替换，因为替换后Range就不准确了
    for (int j = arr.count - 1; j >= 0; j--) {
        //NSTextCheckingResult里面包含range
        NSTextCheckingResult * result = arr[j];
        
        for (int i = 0; i < face.count; i++) {
            if ([[text substringWithRange:result.range] isEqualToString:face[i][@"chs"]])
            {
                NSString * imageName = [NSString stringWithString:face[i][@"png"]];
                
                NSTextAttachment * textAttachment = [[NSTextAttachment alloc]init];
                
                textAttachment.image = [UIImage imageNamed:imageName];
                
                NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                
                [attStr replaceCharactersInRange:result.range withAttributedString:imageStr];
                
                break;
            }
        }
    }
    
    return attStr;
}


@end
