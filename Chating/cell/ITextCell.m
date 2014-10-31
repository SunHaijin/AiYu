//
//  ITextCell.m
//  AiYu
//
//  Created by ibokan on 14-10-21.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "ITextCell.h"

@interface ITextCell ()

@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UITextView *selfText;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthC;

@end

@implementation ITextCell

-(void)setCellInfo:(NSDictionary *)dic
{
    [self.selfText setEditable:NO];
    
    //    NSData * data = dic[@"body"];
    //    NSError * error;
    //    NSDictionary * bodyDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //    if (!bodyDic) {
    //        NSLog(@"SelfTextCell解析填充失败");
    //        return;
    //    }
    //    NSString * text = bodyDic[@"content"];
    NSString * text = dic[@"content"];
    
    
    NSLog(@"解析下来的内容%@",text);
    TextWithBiaoqing * tb = [[TextWithBiaoqing alloc]init];
    NSAttributedString * attstr = [tb changeTextWithBiaoqing:text];
    
    self.selfText.attributedText = attstr;
    NSLog(@"iiiiiiiiiiiii%@",text);
    NSLog(@"uuuuuuuuuuuuu%@",attstr);
    
    
    CGRect frame = [attstr boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    [self.selfText removeConstraint:self.widthC];
    NSString * str2 = [NSString stringWithFormat:@"H:[_selfText(%g)]",frame.size.width + 20];
    NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:str2 options:0 metrics:0 views:NSDictionaryOfVariableBindings(_selfText)];
    [self.selfText addConstraints:c2];
    
    
    
    //    CGRect f = self.selfText.frame;
    //    f.size.height = frame.size.height;
    //    f.size.width = frame.size.width;
    //
    //    self.selfText.frame = f;
    //    NSLog(@"frame.size.width = %f",frame.size.width);
    //    NSLog(@"frame.size.height = %f",frame.size.height);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
