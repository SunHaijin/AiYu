//
//  CellB.m
//  SinaWeibo
//
//  Created by 杨斌 on 14-9-5.
//  Copyright (c) 2014年 杨斌. All rights reserved.
//
//cellB转发不带文字
#import "CellB.h"
@interface CellB ()


@property (strong, nonatomic) IBOutlet UIImageView *imageViewHead;

@property (strong, nonatomic) IBOutlet UIButton *buttonTop;

@property (strong, nonatomic) IBOutlet UIButton *buttonHead;
@property (strong, nonatomic) IBOutlet UILabel *labelNickName;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewClasses;
@property (strong, nonatomic) IBOutlet UIButton *buttonActionSheet;
@property (strong, nonatomic) IBOutlet UILabel *labelTimeBefore;
@property (strong, nonatomic) IBOutlet UILabel *labelMessageFrom;
@property (strong, nonatomic) IBOutlet UILabel *labelForward;
@property (strong, nonatomic) IBOutlet UIButton *buttonMedium;

@property (strong, nonatomic) IBOutlet UILabel *labelForwardOthersMsg;
@property (strong, nonatomic) IBOutlet UIButton *buttonForward;
@property (strong, nonatomic) IBOutlet UIButton *buttonComment;
@property (strong, nonatomic) IBOutlet UIButton *buttonZan;
@property (strong, nonatomic) IBOutlet UIButton *buttonForwardText;
@end
@implementation CellB
- (IBAction)tapButtonTop:(UIButton *)sender {
    NSLog(@"点击了top按钮");
}
- (IBAction)tapButtonHead:(UIButton *)sender {
    NSLog(@"点击了头像");
}


- (IBAction)tapButtonText:(UIButton *)sender {
    NSLog(@"你点击了文字大按钮!");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}


-(void)setCellInfo:(NSDictionary *)dic
{
    NSString *headImageURL=dic[@"user"][@"profile_image_url"];
    
    
//    [self.imageViewHead setImageWithURL:[NSURL URLWithString:headImageURL ]];//设置头像,可以直接使用
    
    
    self.labelNickName.text=dic[@"user"][@"name"];
    
    self.labelForward.text=dic[@"text"];
    
    self.labelMessageFrom.text=dic[@"user"][@"location"];
    
    self.labelForwardOthersMsg.text=dic[@"retweeted_status"][@"text"];
    
    self.labelTimeBefore.text=dic[@"created_at"];
    
    NSString * ifVerified=dic[@"user"][@"verified"];
    
    
    BOOL isV=[ifVerified boolValue];
    
    if (isV)
    {
        [self.imageViewClasses setImage:[UIImage imageNamed:@"huangguan.png"]];
    }
    
    else
    {
        [self.imageViewClasses setImage:nil];
    }
    
}


@end
