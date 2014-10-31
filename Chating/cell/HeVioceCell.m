//
//  HeVioceCell.m
//  AiYu
//
//  Created by ibokan on 14-10-21.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "HeVioceCell.h"
#import <AFHTTPRequestOperationManager.h>
#import <AVFoundation/AVFoundation.h>

@interface HeVioceCell ()
@property (strong, nonatomic) IBOutlet UIButton *imageButton;

@property (strong, nonatomic) IBOutlet UIButton *taVoice;

@property(nonatomic,strong)AFHTTPRequestOperationManager * manger;
@property(nonatomic,strong)AVAudioPlayer * player;
@property(nonatomic,strong)NSString * path;

@end

@implementation HeVioceCell


- (IBAction)tapButton:(UIButton *)sender {
    
    if ([self.player isPlaying])
    {
        [self.player pause];
    }
    else
    {
        [self.player play];
    }
    
}

-(void)setCellInfo:(NSDictionary *)dic
{
    //    NSData * data = dic[@"body"];
    //    NSError * error;
    //    NSDictionary * bodyDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //    if (!bodyDic) {
    //        NSLog(@"TaVoiceCell解析填充失败");
    //        return;
    //    }
    //    NSString * text = bodyDic[@"content"];
    
    NSString * text = dic[@"content"];
    self.manger = [[AFHTTPRequestOperationManager alloc]init];
    AFHTTPRequestOperation * op = [self.manger GET:text parameters:nil success:^(AFHTTPRequestOperation *operation, NSData * responseObject) {
        //把下载来的Data储存到沙盒之中
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString * path = [paths objectAtIndex:0];
        
        NSString * name = [NSString stringWithFormat:@"/%ldvoice.mp3",(long)[NSDate timeIntervalSinceReferenceDate]];
        path = [path stringByAppendingString:name];
        [responseObject writeToFile:path atomically:YES];
        
        self.path = path;
        
        //把taVoice button的title设置成声音的长度
        NSData * data = [[NSData alloc]initWithContentsOfFile:path];
        NSError * error;
        self.player = [[AVAudioPlayer alloc]initWithData:data error:&error];
        
        
        NSString * title = [NSString stringWithFormat:@"语音:%02d秒",(int)self.player.duration];
        [self.taVoice setTitle:title forState:UIControlStateNormal];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载声音失败%@",[error localizedDescription]);
    }];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
    
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
