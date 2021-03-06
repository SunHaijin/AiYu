//
//  IImageCell.m
//  AiYu
//
//  Created by ibokan on 14-10-21.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "IImageCell.h"
#import <AFHTTPRequestOperationManager.h>

@interface IImageCell ()

@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UIImageView *selfImage;
@property(nonatomic,strong)AFHTTPRequestOperationManager * manger;

@end

@implementation IImageCell

-(void)setCellInfo:(NSDictionary *)dic
{
    //    NSData * data = dic[@"body"];
    //    NSError * error;
    //    NSDictionary * bodyDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //    if (!bodyDic) {
    //        NSLog(@"SelfImageCell解析填充失败");
    //        return;
    //    }
    //    NSString * text = bodyDic[@"content"];
    NSString * text = dic[@"content"];
    self.manger = [[AFHTTPRequestOperationManager alloc]init];
    AFHTTPRequestOperation * op = [self.manger GET:text parameters:nil success:^(AFHTTPRequestOperation *operation, NSData * responseObject) {
        //把下载来的Data储存到沙盒之中
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString * path = [paths objectAtIndex:0];
        
        NSString * name = [NSString stringWithFormat:@"/%ldimage.png",(long)[NSDate timeIntervalSinceReferenceDate]];
        path = [path stringByAppendingString:name];
        [responseObject writeToFile:path atomically:YES];
        
        NSData * data = [[NSData alloc]initWithContentsOfFile:path];
        UIImage * image = [UIImage imageWithData:data];
        [self.selfImage setImage:image];
        [self.selfImage setContentMode:UIViewContentModeScaleAspectFit];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载图片失败%@",[error localizedDescription]);
    }];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
    NSLog(@"77777777777");
    
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
