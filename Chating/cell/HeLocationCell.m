//
//  HeLocationCell.m
//  AiYu
//
//  Created by ibokan on 14/10/24.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "HeLocationCell.h"
#import "NSObject+Location.h"
#import "UITableViewCell+Function.h"
@interface HeLocationCell()

@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UITextView *taLocation;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *width;


@end

@implementation HeLocationCell

-(void)setCellInfo:(NSDictionary *)dic
{
    NSString * text = dic[@"content"];
    self.taLocation.text=text;
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil];    [self.taLocation removeConstraint:self.width];
    NSString * str2 = [NSString stringWithFormat:@"H:[_taLocation(%g)]",frame.size.width + 20];
    NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:str2 options:0 metrics:0 views:NSDictionaryOfVariableBindings(_taLocation)];
    [self.taLocation addConstraints:c2];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
