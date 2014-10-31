//
//  ChatTextview.m
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "ChatTextview.h"

@interface ChatTextview()

@property(nonatomic,strong)FaceKeyBoard * faceKB;
@property(nonatomic,strong)FunctionKeyBoard * functionKB;
@property(nonatomic,strong)FunctionButtonBlock functionBlock;
@property(nonatomic,strong)SendBlock block;

@end

@implementation ChatTextview
-(void)setSendTextBlock:(SendBlock)aBlock
{
    self.block=aBlock;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        __weak __block ChatTextview * copy_self = self;

        [self setFont:[UIFont systemFontOfSize:17]];
        
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        
        self.faceKB = [[FaceKeyBoard alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 216)];
        [self.faceKB setSendBlock:^(buttonTag tag) {
            copy_self.block(copy_self.textString);
        }];
        [self.faceKB setTapFaceButtonBlock:^(buttonTag tag) {
            //通过tag和plist文件找到图片对象
            NSString * path = [[NSBundle mainBundle] pathForResource:@"emoticons2" ofType:@"plist"];
            NSArray * arr = [NSArray arrayWithContentsOfFile:path];
            NSDictionary * dic = arr[tag];
            NSString * imageName = dic[@"png"];
            UIImage * image = [UIImage imageNamed:imageName];
            
            //通过图片对象生成NSAttributedString
            NSTextAttachment * attach = [[NSTextAttachment alloc]init];
            attach.image = image;
            NSAttributedString * att = [NSAttributedString attributedStringWithAttachment:attach];
            
            //将生成的NSAttributedString拼接到当前显示的内容上
            NSAttributedString * currentAtt = copy_self.attributedText;
            NSMutableAttributedString * tempAtt = [[NSMutableAttributedString alloc]initWithAttributedString:currentAtt];
            [tempAtt appendAttributedString:att];
            
            copy_self.attributedText = tempAtt;
        }];
        
        
        self.functionKB = [[FunctionKeyBoard alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 216)];
        [self.functionKB setTapFunctionKeyBlock:^(FunctionKeyType index) {
            FunctionButton buttonType;
            switch (index) {
                case FunctionKeyTypephoto:
                    buttonType = FunctionButtonphoto;
                    break;
                case FunctionKeyTypecamera:
                    buttonType = FunctionButtoncamera;
                    break;
                case FunctionKeyTypelocation:
                    buttonType = FunctionButtonlocation;
                    break;
                case FunctionKeyTypename:
                    buttonType = FunctionButtonname;
                    break;
                case FunctionKeyTypevideo:
                    buttonType = FunctionButtonvideo;
                    break;
                case FunctionKeyTypevoice:
                    buttonType = FunctionButtonvoice;
                    break;
                    
                default:
                    break;
            }
            
            if (copy_self.functionBlock) {
                copy_self.functionBlock(buttonType);
            }
            
        }];
        
        self.returnKeyType = UIReturnKeySend;
        
    }
    return self;
}



-(void)setFunctionButtonBlock:(FunctionButtonBlock)aBlock
{
    self.functionBlock = aBlock;
}

-(void)setMyKeyBoard:(MyKeyBoard)keyBoard
{
    UIView * tempKeyBoard;
    switch (keyBoard)
    {
        case MyKeyBoardFace:
            tempKeyBoard = self.faceKB;
            break;
        case MyKeyBoardFunction:
            tempKeyBoard = self.functionKB;
            break;
        case MyKeyBoardSystem:
            tempKeyBoard = nil;
            break;
        case MyKeyBoardNone:
            [self resignFirstResponder];
            return;
        default:
            break;
    }
    
    
    
    self.inputView = tempKeyBoard;
    
    if ([self isFirstResponder])
    {
        [self reloadInputViews];
    }
    else
    {
        [self becomeFirstResponder];
    }
}


-(NSString *)textString
{
    NSAttributedString * att = self.attributedText;
    
    NSMutableAttributedString * resutlAtt = [[NSMutableAttributedString alloc]initWithAttributedString:att];
    
    
    __weak __block ChatTextview * copy_self = self;
    [att enumerateAttributesInRange:NSMakeRange(0, att.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        //key-NSAttachment
        //NSTextAttachment value类型
        NSTextAttachment * textAtt = attrs[@"NSAttachment"];
        if (textAtt)
        {
            UIImage * image = textAtt.image;
            NSString * text = [copy_self stringFromImage:image];
            [resutlAtt replaceCharactersInRange:range withString:text];
            
        }
        
        
    }];
    
    
    return resutlAtt.string;
}

-(NSString *)stringFromImage:(UIImage *)image
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString * path = [bundle pathForResource:@"emoticons2" ofType:@"plist"];
    NSArray * face = [[NSArray alloc]initWithContentsOfFile:path];
    
    NSData * imageD = UIImagePNGRepresentation(image);
    
    NSString * imageName;
    for (int i = 0; i < face.count; i++) {
        UIImage * tempImage = [UIImage imageNamed:face[i][@"png"]];
        NSData * tempD = UIImagePNGRepresentation(tempImage);
        if ([imageD isEqual:tempD]) {
            imageName = face[i][@"chs"];
        }
    }
    return imageName;
}

@end
