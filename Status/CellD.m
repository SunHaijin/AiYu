//
//  CellD.m
//  SinaWeibo
//
//  Created by 杨斌 on 14-9-5.
//  Copyright (c) 2014年 杨斌. All rights reserved.
//

//原创不带图片
#import "CellD.h"

@interface CellD ()

@property (strong, nonatomic) IBOutlet UIButton *buttonTop;
@property (strong, nonatomic) IBOutlet UIButton *buttonHead;
@property (strong, nonatomic) IBOutlet UILabel *labelNickName;
@property (strong, nonatomic) IBOutlet UILabel *labelTimeBefore;
@property (strong, nonatomic) IBOutlet UILabel *labelDeviceFrom;
@property (strong, nonatomic) IBOutlet UIButton *buttonActionSheet;
@property (strong, nonatomic) IBOutlet UIButton *buttonForward;
@property (strong, nonatomic) IBOutlet UIButton *buttonComment;
@property (strong, nonatomic) IBOutlet UIButton *buttonZan;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewHuangguan;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewHead;
@property (strong, nonatomic) IBOutlet UIButton *buttonText;

@property (strong, nonatomic) IBOutlet UILabel *labelText;

@end
@implementation CellD
- (IBAction)tapButtonTop:(UIButton *)sender {
    NSLog(@"你点击了top按钮");
}
- (IBAction)tapButtonHead:(UIButton *)sender {
    NSLog(@"你点击了头像呀");
}
- (IBAction)tapButtonText:(UIButton *)sender {
    NSLog(@"你点击了文字");
}
- (IBAction)tapZhuanfa:(UIButton *)sender {
}

-(void)setCellInfo:(NSDictionary *)dic
{
    NSString *headImageURL=dic[@"user"][@"profile_image_url"];
    
    
//    [self.imageViewHead setImageWithURL:[NSURL URLWithString:headImageURL ]];//设置头像,可以直接使用
    
    
    self.labelNickName.text=dic[@"user"][@"name"];
    
    self.labelText.text=dic[@"text"];
    
    self.labelDeviceFrom.text=dic[@"user"][@"location"];
    
    
    
    self.labelTimeBefore.text=dic[@"created_at"];
    
    NSString * ifVerified=dic[@"user"][@"verified"];//是否是皇冠级别,设置图片
    
    
    BOOL isV=[ifVerified boolValue];
    
    if (isV)
    {
        [self.imageViewHuangguan setImage:[UIImage imageNamed:@"huangguan.png"]];
    }
    
    else
    {
        [self.imageViewHuangguan setImage:nil];
    }

}

@end
