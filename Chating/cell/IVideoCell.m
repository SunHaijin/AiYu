//
//  IVideoCell.m
//  AiYu
//
//  Created by ibokan on 14-10-21.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "IVideoCell.h"

@interface IVideoCell()

@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UIButton *videoButton;

@end

@implementation IVideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
