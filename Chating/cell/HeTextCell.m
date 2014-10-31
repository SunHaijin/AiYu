//
//  HeTextCell.m
//  AiYu
//
//  Created by ibokan on 14-10-21.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "HeTextCell.h"

@interface HeTextCell ()

@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UITextView *taText;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthC;
//@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightC;

@end

@implementation HeTextCell

-(void)setCellInfo:(NSDictionary *)dic
{
    [self.taText setEditable:NO];
    
    //    NSData * data = dic[@"body"];
    //    NSError * error;
    //    NSDictionary * bodyDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //    if (!bodyDic) {
    //        NSLog(@"TaTextCell解析填充失败");
    //        return;
    //    }
    //    NSString * text = bodyDic[@"content"];
    NSString * text = dic[@"content"];
    
    TextWithBiaoqing * tb = [[TextWithBiaoqing alloc]init];
    NSAttributedString * attstr = [tb changeTextWithBiaoqing:text];
    
    self.taText.attributedText = attstr;
    
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil];
    //    CGRect frame = [attstr boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    
    [self.taText removeConstraint:self.widthC];
    NSString * str2 = [NSString stringWithFormat:@"H:[_taText(%g)]",frame.size.width];
    NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:str2 options:0 metrics:0 views:NSDictionaryOfVariableBindings(_taText)];
    [self.taText addConstraints:c2];
    
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
