//
//  CellC.m
//  SinaWeibo
//
//  Created by 杨斌 on 14-9-5.
//  Copyright (c) 2014年 杨斌. All rights reserved.
//

//原创带图片
#import "CellC.h"
#import <UIImageView+AFNetworking.h>
@interface CellC ()
@property (strong, nonatomic) IBOutlet UIButton *buttonTop;
@property (strong, nonatomic) IBOutlet UIButton *buttonHead;
@property (strong, nonatomic) IBOutlet UILabel *labelNickName;
@property (strong, nonatomic) IBOutlet UILabel *labelTimeBefore;
@property (strong, nonatomic) IBOutlet UILabel *deviceFrom;
@property (strong, nonatomic) IBOutlet UIButton *buttonActionSheet;

@property (strong, nonatomic) IBOutlet UIButton *buttonText;
@property (strong, nonatomic) IBOutlet UIButton *buttonForwardImage;
@property (strong, nonatomic) IBOutlet UILabel *labelText;
@property (strong, nonatomic) IBOutlet UIButton *buttonForward;
@property (strong, nonatomic) IBOutlet UIButton *buttonComment;
@property (strong, nonatomic) IBOutlet UIButton *buttonZan;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewHuangguan;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewHead;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewForward;
@end
@implementation CellC
- (IBAction)tapButtonTop:(UIButton *)sender {
    NSLog(@"你点击了top按钮");
}
- (IBAction)tapButtonHead:(UIButton *)sender
{
    NSLog(@"你点击了头像");
}
- (IBAction)tapTextButton:(UIButton *)sender {
    
    NSLog(@"你点击了文字!");
}
- (IBAction)tapImageButton:(UIButton *)sender {
    NSLog(@"点击了原创微博图像");
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

-(void)setCellInfo:(NSDictionary *)dic
{
    NSString *headImageURL=dic[@"user"][@"profile_image_url"];
    
    
    [self.imageViewHead setImageWithURL:[NSURL URLWithString:headImageURL ]];//设置头像,可以直接使用
    
    
    self.labelNickName.text=dic[@"user"][@"name"];
    
    self.labelText.text=dic[@"text"];
    
    self.deviceFrom.text=dic[@"user"][@"location"];
    
   
    
    self.labelTimeBefore.text=dic[@"created_at"];
    
    NSLog(@"created_at==%@",dic[@"created_at"]);
    
    
    NSString *imageForward=dic[@"thumbnail_pic"];
    
    
    NSLog(@"图片==%@",imageForward);
    
    
    
    if (imageForward)
    {
        self.imageViewForward.contentMode=UIViewContentModeScaleAspectFit;
        
        [self.imageViewForward setImageWithURL:[NSURL URLWithString:imageForward] placeholderImage:[UIImage imageNamed:@"Icon@2x.png"]];
    }
    
    
    
    NSString * ifVerified=dic[@"user"][@"verified"];
    
    
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
