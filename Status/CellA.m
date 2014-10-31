//
//  CellA.m
//  SinaWeibo
//
//  Created by 杨斌 on 14-9-4.
//  Copyright (c) 2014年 杨斌. All rights reserved.
//

//cellA,文字,转发文字,转发图片
#import "CellA.h"
#import <UIImageView+AFNetworking.h>
@interface CellA ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consWidth;

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
@property (strong, nonatomic) IBOutlet UIButton *buttonForwardImage;
@property (strong, nonatomic) IBOutlet UILabel *labelForwardOthersMsg;
@property (strong, nonatomic) IBOutlet UIButton *buttonForward;
@property (strong, nonatomic) IBOutlet UIButton *buttonComment;
@property (strong, nonatomic) IBOutlet UIButton *buttonZan;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewForward;

@property(strong,nonatomic) NSDictionary *dic;


//-(void)modifyLayoutConstraint:(NSLayoutConstraint *)c andLabel:(UILabel *)label ;

@property (assign,nonatomic) TapBlock block;

@end



@implementation CellA

//外界cell调用此方法回传一个block,点击按钮之后就可以调用
-(void)setTapButtonBlock:(TapBlock)block
{
    self.block=block;
}

- (IBAction)tapForwardText:(UIButton *)sender
{
    NSLog(@"你点击了转发文字详情!");
}

- (IBAction)tapButtonTop:(UIButton *)sender {
    NSLog(@"你点击了top按钮");
}

- (IBAction)tapHeadImageButton:(UIButton *)sender {
    
    NSLog(@"你点击了头像!");
}

- (IBAction)tapImageButton:(UIButton *)sender
{
    NSLog(@"点击了转发图像!");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

  
}

/*
-(void)modifyLayoutConstraint:(NSLayoutConstraint *)c andLabel:(UILabel *)label
{
    CGRect frame=[label.text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil];
    
    CGFloat width=frame.size.width;
    
    NSString *cStr=[NSString stringWithFormat:@"H:[_labelNickName(%g)]",width+5];
    
    NSArray *consArr=[NSLayoutConstraint constraintsWithVisualFormat:cStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(_labelNickName)];
    
    [self removeConstraint:c];
    
    c=[consArr lastObject];
    
    [self addConstraint:c];
    
}
*/
-(void)setCellInfo:(NSDictionary *)dic

{
    self.dic=dic;
    
    NSString *headImageURL=dic[@"user"][@"profile_image_url"];
    
    
   [self.imageViewHead setImageWithURL:[NSURL URLWithString:headImageURL ]];//设置头像,可以直接使用
    
  
    self.labelNickName.text=dic[@"user"][@"name"];
    
    self.labelForward.text=dic[@"text"];
    
    self.labelMessageFrom.text=dic[@"user"][@"location"];
    
    self.labelForwardOthersMsg.text=dic[@"retweeted_status"][@"text"];
    
    self.labelTimeBefore.text=dic[@"created_at"];
    
    NSLog(@"created_at==%@",dic[@"created_at"]);
    

    NSString *imageForward=dic[@"retweeted_status"][@"thumbnail_pic"];
   
    
    if (imageForward)
    {
        self.imageViewForward.contentMode=UIViewContentModeScaleAspectFit;
        
        [self.imageViewForward setImageWithURL:[NSURL URLWithString:imageForward] placeholderImage:[UIImage imageNamed:@"Icon@2x.png"]];
    }
    
   
    
   NSString * ifVerified=dic[@"user"][@"verified"];
    
    
    BOOL isV=[ifVerified boolValue];
    
    if (isV)
    {
        [self.imageViewClasses setImage:[UIImage imageNamed:@"huangguan.png"]];
    }
    
    else
    {
        //[self.imageViewClasses setImage:nil];
    }
    
  /*
    //设置label的高度,可以设置约束LessEqual不用这些代码
    CGRect frame=[self.labelNickName.text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil];
    
    CGFloat width=frame.size.width;
    
    NSString *cStr=[NSString stringWithFormat:@"H:[_labelNickName(%g)]",width+5];
    
    NSArray *consArr=[NSLayoutConstraint constraintsWithVisualFormat:cStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(_labelNickName)];
    
    [self removeConstraint:self.consWidth];
    
   // NSLog(@"删除约束");
    
    self.consWidth=[consArr lastObject];
    
    [self addConstraint:self.consWidth];
    */
}



@end
