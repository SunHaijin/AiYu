//
//  ILocationCell.m
//  AiYu
//
//  Created by ibokan on 14/10/24.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "ILocationCell.h"
#import "NSObject+Location.h"
#import "UITableViewCell+Function.h"

@interface ILocationCell()

@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UITextView *ilocation;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthC;


@end

@implementation ILocationCell

-(void)setCellInfo:(NSDictionary *)dic
{
    NSString * text = dic[@"content"];
    self.ilocation.text=text;
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil];
    [self.ilocation removeConstraint:self.widthC];
    NSString * str2 = [NSString stringWithFormat:@"H:[_ilocation(%g)]",frame.size.width + 20];
    NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:str2 options:0 metrics:0 views:NSDictionaryOfVariableBindings(_ilocation)];
       [self.ilocation addConstraints:c2];
    
    NSLog(@"777777777");
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
