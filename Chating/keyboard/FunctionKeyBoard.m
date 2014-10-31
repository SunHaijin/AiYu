//
//  FunctionKeyBoard.m
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "FunctionKeyBoard.h"

@interface FunctionKeyBoard()

@property(nonatomic,strong)FunctionBlock functionBlock;

@end

@implementation FunctionKeyBoard
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIButton * photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.tag = FunctionKeyTypephoto;
        photoButton.frame = CGRectZero;
        photoButton.translatesAutoresizingMaskIntoConstraints=NO;
        UIImage * photoButtonImage = [UIImage imageNamed:@"aio_icons_pic@2x.png"];
        [photoButton setImage:photoButtonImage forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:photoButton];
        
        UILabel * photoLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        photoLabel.translatesAutoresizingMaskIntoConstraints=NO;
        [photoLabel setTextAlignment:NSTextAlignmentCenter];
        [photoLabel setFont:[UIFont systemFontOfSize:13]];
        photoLabel.text = @"照片";
        [self addSubview:photoLabel];
        
        
        UIButton * cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cameraButton.tag = FunctionKeyTypecamera;
        cameraButton.frame = CGRectZero;
        cameraButton.translatesAutoresizingMaskIntoConstraints=NO;
        UIImage * cameraButtonImage = [UIImage imageNamed:@"aio_icons_camera@2x.png"];
        [cameraButton setImage:cameraButtonImage forState:UIControlStateNormal];
        [cameraButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cameraButton];
        
        UILabel * cameraLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        cameraLabel.translatesAutoresizingMaskIntoConstraints=NO;
        [cameraLabel setTextAlignment:NSTextAlignmentCenter];
        cameraLabel.text = @"拍照";
        [cameraLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:cameraLabel];
        
        
        UIButton * locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        locationButton.tag = FunctionKeyTypelocation;
        locationButton.frame = CGRectZero;
        locationButton.translatesAutoresizingMaskIntoConstraints=NO;
        UIImage * locationButtonImage = [UIImage imageNamed:@"aio_icons_location@2x.png"];
        [locationButton setImage:locationButtonImage forState:UIControlStateNormal];
        [locationButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:locationButton];
        
        UILabel * locationLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        locationLabel.translatesAutoresizingMaskIntoConstraints=NO;
        [locationLabel setTextAlignment:NSTextAlignmentCenter];
        locationLabel.text = @"位置";
        [locationLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:locationLabel];
        
        
//        UIButton * nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        nameButton.tag = FunctionKeyTypename;
//        nameButton.frame = CGRectMake(245, 10, 70, 70);
//        UIImage * nameButtonImage = [UIImage imageNamed:@"name.png"];
//        [nameButton setImage:nameButtonImage forState:UIControlStateNormal];
//        [nameButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:nameButton];
        
//        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(245, 80, 70, 20)];
//        [nameLabel setTextAlignment:NSTextAlignmentCenter];
//        nameLabel.text = @"名片";
//        [nameLabel setFont:[UIFont systemFontOfSize:13]];
//        [self addSubview:nameLabel];
        
        
        UIButton * videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        videoButton.tag = FunctionKeyTypevideo;
        videoButton.frame = CGRectZero;
        videoButton.translatesAutoresizingMaskIntoConstraints=NO;
        UIImage * videoButtonImage = [UIImage imageNamed:@"aio_icons_video@2x.png"];
        [videoButton setImage:videoButtonImage forState:UIControlStateNormal];
        [videoButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:videoButton];
        
        UILabel * videoLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        videoLabel.translatesAutoresizingMaskIntoConstraints=NO;
        [videoLabel setTextAlignment:NSTextAlignmentCenter];
        videoLabel.text = @"视频聊天";
        [videoLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:videoLabel];
        
        
        UIButton * voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        voiceButton.tag = FunctionKeyTypevoice;
        voiceButton.frame = CGRectZero;
        voiceButton.translatesAutoresizingMaskIntoConstraints=NO;
        UIImage * voiceButtonImage = [UIImage imageNamed:@"aio_icons_freeaudio@2x.png"];
        [voiceButton setImage:voiceButtonImage forState:UIControlStateNormal];
        [voiceButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:voiceButton];
        
        UILabel * voiceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        voiceLabel.translatesAutoresizingMaskIntoConstraints=NO;
        [voiceLabel setTextAlignment:NSTextAlignmentCenter];
        voiceLabel.text = @"实时对讲机";
        [voiceLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:voiceLabel];
        
        
        //加约束
        NSArray*c1=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[photoButton]-5-[cameraButton]-5-[locationButton]-5-[videoButton]-5-[voiceButton]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(photoButton,cameraButton,locationButton,videoButton,voiceButton)];
        [self addConstraints:c1];
        
        NSArray*c2=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[photoButton]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(photoButton)];
        [self addConstraints:c2];
        NSArray*c3=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[cameraButton]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(cameraButton)];
        [self addConstraints:c3];
        NSArray*c4=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[locationButton]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(locationButton)];
        [self addConstraints:c4];
        NSArray*c5=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[videoButton]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(videoButton)];
        [self addConstraints:c5];
        NSArray*c6=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[voiceButton]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(voiceButton)];
        [self addConstraints:c6];

        NSArray*c11=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[photoLabel]-25-[cameraLabel]-28-[locationLabel]-19-[videoLabel]-2-[voiceLabel]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(photoLabel,cameraLabel,locationLabel,videoLabel,voiceLabel)];
        [self addConstraints:c11];
        
        NSArray*c12=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[photoLabel]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(photoLabel)];
        [self addConstraints:c12];
        NSArray*c13=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[cameraLabel]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(cameraLabel)];
        [self addConstraints:c13];
        NSArray*c14=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[locationLabel]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(locationLabel)];
        [self addConstraints:c14];
        NSArray*c15=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[videoLabel]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(videoLabel)];
        [self addConstraints:c15];
        NSArray*c16=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[voiceLabel]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(voiceLabel)];
        [self addConstraints:c16];

        
    }
    return self;
}

-(void)setTapFunctionKeyBlock:(FunctionBlock)aBlock
{
    self.functionBlock = aBlock;
}


-(void)tapButton:(UIButton *)button
{
    if (self.functionBlock) {
        self.functionBlock(button.tag);
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
