 //
//  ChatToolView.m
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "ChatToolView.h"
#import "ChatTextView.h"
#import "LCVoice.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

typedef enum : NSUInteger {
    ButtonTagSpeak = 100,
    ButtonTagSpeakSys,
    ButtonTagFace,
    ButtonTagFaceSys,
    ButtonTagFunction,
    ButtonTagFunctionSys,
} ButtonTag;


@interface ChatToolView()

{
    ToolViewType _toolViewType;
    
    AVAudioSession *session;
    AVAudioPlayer *audioPlayer;
    AVAudioRecorder *recorder;
}

@property(nonatomic,strong)AVAudioRecorder *player;
@property(nonatomic,strong)LCVoice *voice;
@property(nonatomic,strong)UIButton *speak;
@property(nonatomic,strong)UIButton *anzhushuohua;
@property(nonatomic,strong)UIButton *face;
@property(nonatomic,strong)UIButton *function;


@property(nonatomic,strong)ToolViewFunctionBlock functionBlock;
@property(nonatomic,strong)ToolViewSendBlock senderBlock;
@property(nonatomic,strong)ToolViewRecordBlock recordBlock;
@property(nonatomic,strong)ToolViewSizeChangeBlock sizeBlock;


@end
@implementation ChatToolView
-(id)initWithFrame:(CGRect)frame
{
    self.voice = [[LCVoice alloc]init];
    
    CGRect r = [[UIScreen mainScreen] bounds];
    frame.size.width = r.size.width;
    frame.size.height = 44;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self otherInit];
        
    }
    return self;
}
-(void)otherInit
{
    self.speak=[UIButton buttonWithType:UIButtonTypeCustom];
    self.speak.tag=ButtonTagSpeak;
    UIImage *speakbuttonimage=[UIImage imageNamed:@"chat_bottom_voice_nor@2x.png"];
    [self.speak setImage:speakbuttonimage forState:UIControlStateNormal];
    self.speak.translatesAutoresizingMaskIntoConstraints=NO;
    [self.speak addTarget:self action:@selector(tapSpeakButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.speak];
    
    
    self.textField=[[ChatTextview alloc]initWithFrame:CGRectZero];
    self.textField.translatesAutoresizingMaskIntoConstraints=NO;
    
//    borderStyle=UITextBorderStyleRoundedRect;
    [self addSubview:self.textField];
    
    
    self.anzhushuohua=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.anzhushuohua setTitle:@"按住说话" forState:UIControlStateNormal];
    self.anzhushuohua.backgroundColor=[UIColor whiteColor];
    [self.anzhushuohua setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UILongPressGestureRecognizer * gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGes:)];
    [self.anzhushuohua addGestureRecognizer:gesture];
    gesture.minimumPressDuration=0.5;
    
    [self.anzhushuohua addTarget:self action:@selector(tapRecord:) forControlEvents:UIControlEventTouchUpInside];
    self.anzhushuohua.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:self.anzhushuohua];


    self.face=[UIButton buttonWithType:UIButtonTypeCustom];
    self.face.tag=ButtonTagFace;
    [self.face setImage:[UIImage imageNamed:@"chat_bottom_smile_nor@2x.png"] forState:UIControlStateNormal];
    [self.face addTarget:self action:@selector(tapFaceButton:) forControlEvents:UIControlEventTouchUpInside];
    self.face.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:self.face];
    
    self.function=[UIButton buttonWithType:UIButtonTypeCustom];
    self.function.tag=ButtonTagFunction;
    [self.function setImage:[UIImage imageNamed:@"chat_bottom_up_nor@2x.png"] forState:UIControlStateNormal];
    [self.function addTarget:self action:@selector(tapFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    self.function.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:self.function];
    
    NSArray*c1=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_speak(44)][_textField][_face(44)][_function(44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_speak,_textField,_face,_function)];
    [self addConstraints:c1];
    
    NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_speak][_anzhushuohua][_face]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_speak,_anzhushuohua,_face)];
    [self addConstraints:c2];
    
    NSArray * c3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_textField]-5-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_textField)];
    [self addConstraints:c3];
    
    NSArray * c4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_anzhushuohua]-5-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_anzhushuohua)];
    [self addConstraints:c4];
    
    NSArray * c5 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_speak(44)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_speak)];
    [self addConstraints:c5];
    
    NSArray * c6 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_face(44)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_face)];
    [self addConstraints:c6];
    
    NSArray * c7 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_function(44)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_function)];
    [self addConstraints:c7];
    
    
    self.textField.hidden=NO;
    self.anzhushuohua.hidden=YES;
    
    __weak __block ChatToolView * copy_self = self;
    
    [self.textField setFunctionButtonBlock:^(FunctionButton buttonIndex) {
        if (copy_self.functionBlock) {
            copy_self.functionBlock(buttonIndex);
        }
    }];    
    
    self.textField.delegate = self;

   
}
-(BOOL)textView:(ChatTextview *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        NSString * string = [textView textString];
        if (self.senderBlock) {
            self.senderBlock(string);
        }
        textView.attributedText = [[NSAttributedString alloc]initWithString:@""];
        return NO;
    }
    return YES;
}

-(void)tapRecord:(UIButton *)button
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"语音时间过短!!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    

}

-(void)longPressGes:(UILongPressGestureRecognizer *)ges

{
    if (ges.state == UIGestureRecognizerStateBegan)
    {
        [self.voice startRecordWithPath:[NSString stringWithFormat:@"%@/Documents/%ldMySound.caf",NSHomeDirectory(),(long)[NSDate timeIntervalSinceReferenceDate]]];
        
    }
    if (ges.state == UIGestureRecognizerStateEnded)
    {
        [self.voice stopRecordWithCompletionBlock:^{
            
            if (self.voice.recordTime > 0.0f) {
                
                
                if (self.recordBlock) {
                    self.recordBlock(self.voice.recordPath);
                }
            }
            
            
            
            
        }];
        
        
    }
    
}

//-(void)setFinishRecordBlock:(ToolViewRecordBlock)aBlock
//{
//    
//}

-(void)tapSpeakButton:(UIButton *)button
{
    
    switch (button.tag) {
        case ButtonTagSpeak:
            [self setToolViewType:ToolViewTypeSpeak];
            break;
        case ButtonTagSpeakSys:
            [self setToolViewType:ToolViewTypeInputText];
            break;
            
        default:
            break;
    }
    
}

-(void)tapFaceButton:(UIButton *)button
{
    
    switch (button.tag) {
        case ButtonTagFace:
            [self setToolViewType:ToolViewTypeInputFace];
            break;
        case ButtonTagFaceSys:
            [self setToolViewType:ToolViewTypeInputText];
            break;
            
        default:
            break;
    }
    
}

-(void)tapFunctionButton:(UIButton *)button
{
    
    switch (button.tag) {
        case ButtonTagFunction:
            [self setToolViewType:ToolViewTypeInputFunction];
            break;
        case ButtonTagFunctionSys:
            [self setToolViewType:ToolViewTypeInputText];
            break;
            
        default:
            break;
    }
    
    
}

//设置键盘和ToolView的样式
-(void)setToolViewType:(ToolViewType)type
{
    _toolViewType = type;
    switch (type) {
        case ToolViewTypeSpeak:
            [self setSpeakType];
            break;
        case ToolViewTypeInputText:
            [self setInputTextType];
            break;
        case ToolViewTypeInputFace:
            [self setInputFaceType];
            break;
        case ToolViewTypeInputFunction:
            [self setInputFunctionType];
            break;
        case ToolViewTypeNomal:
            [self setNomalType];
            break;
            
        default:
            break;
    }
}

-(ToolViewType)toolViewType
{
    return _toolViewType;
}

//分别设置五种模式下的toolview样式
-(void)setSpeakType
{
    self.speak.tag = ButtonTagSpeakSys;
    UIImage * image1 = [UIImage imageNamed:@"chat_bottom_keyboard_nor@2x.png"];
    [self.speak setImage:image1 forState:UIControlStateNormal];
    
    self.face.tag = ButtonTagFace;
    UIImage *image2 = [UIImage imageNamed:@"chat_bottom_smile_nor@2x.png"];
    [self.face setImage:image2 forState:UIControlStateNormal];
    
    self.function.tag = ButtonTagFunction;
    UIImage * image3 = [UIImage imageNamed:@"chat_bottom_up_nor@2x.png"];
    [self.function setImage:image3 forState:UIControlStateNormal];
    
    [self.textField setMyKeyBoard:MyKeyBoardNone];
    self.textField.hidden = YES;
    self.anzhushuohua.hidden = NO;
}

-(void)setInputTextType
{
    self.speak.tag = ButtonTagSpeak;
    UIImage * image1 = [UIImage imageNamed:@"chat_bottom_voice_nor@2x.png"];
    [self.speak setImage:image1 forState:UIControlStateNormal];
    
    self.face.tag = ButtonTagFace;
    UIImage *image2 = [UIImage imageNamed:@"chat_bottom_smile_nor@2x.png"];
    [self.face setImage:image2 forState:UIControlStateNormal];
    
    self.function.tag = ButtonTagFunction;
    UIImage * image3 = [UIImage imageNamed:@"chat_bottom_up_nor@2x.png"];
    [self.function setImage:image3 forState:UIControlStateNormal];
    
    [self.textField setMyKeyBoard:MyKeyBoardSystem];
    self.textField.hidden = NO;
    self.anzhushuohua.hidden = YES;
}

-(void)setInputFaceType
{
    self.speak.tag = ButtonTagSpeak;
    UIImage * image1 = [UIImage imageNamed:@"chat_bottom_voice_nor@2x.png"];
    [self.speak setImage:image1 forState:UIControlStateNormal];
    
    self.face.tag = ButtonTagFaceSys;
    UIImage *image2 = [UIImage imageNamed:@"chat_bottom_keyboard_nor@2x.png"];
    [self.face setImage:image2 forState:UIControlStateNormal];
    
    self.function.tag = ButtonTagFunction;
    UIImage * image3 = [UIImage imageNamed:@"chat_bottom_up_nor@2x.png"];
    [self.function setImage:image3 forState:UIControlStateNormal];
    
    [self.textField setMyKeyBoard:MyKeyBoardFace];
    self.textField.hidden = NO;
    self.anzhushuohua.hidden = YES;
    
}

-(void)setInputFunctionType
{
    self.speak.tag = ButtonTagSpeak;
    UIImage * image1 = [UIImage imageNamed:@"chat_bottom_voice_nor@2x.png"];
    [self.speak setImage:image1 forState:UIControlStateNormal];
    
    self.face.tag = ButtonTagFace;
    UIImage *image2 = [UIImage imageNamed:@"chat_bottom_smile_nor@2x.png"];
    [self.face setImage:image2 forState:UIControlStateNormal];
    
    self.function.tag = ButtonTagFunctionSys;
    UIImage * image3 = [UIImage imageNamed:@"chat_bottom_keyboard_nor@2x.png"];
    [self.function setImage:image3 forState:UIControlStateNormal];
    
    [self.textField setMyKeyBoard:MyKeyBoardFunction];
    self.textField.hidden = NO;
    self.anzhushuohua.hidden = YES;
}

-(void)setNomalType
{
    self.speak.tag = ButtonTagSpeak;
    UIImage * image1 = [UIImage imageNamed:@"chat_bottom_voice_nor@2x.png"];
    [self.speak setImage:image1 forState:UIControlStateNormal];
    
    self.face.tag = ButtonTagFace;
    UIImage *image2 = [UIImage imageNamed:@"chat_bottom_smile_nor@2x.png"];
    [self.face setImage:image2 forState:UIControlStateNormal];
    
    self.function.tag = ButtonTagFunction;
    UIImage * image3 = [UIImage imageNamed:@"chat_bottom_up_nor@2x.png"];
    [self.function setImage:image3 forState:UIControlStateNormal];
    
    [self.textField setMyKeyBoard:MyKeyBoardNone];
    self.textField.hidden = NO;
    self.anzhushuohua.hidden = YES;
}

-(void)setFunctionEventBlock:(ToolViewFunctionBlock)aBlock
{
    self.functionBlock = aBlock;
}
-(void)setSizeChangeBlock:(ToolViewSizeChangeBlock)aBlock
{
    self.sizeBlock = aBlock;
}
-(void)setFinishRecordBlock:(ToolViewRecordBlock)aBlock
{
    
    self.recordBlock=aBlock;
}
-(void)textViewDidChange:(UITextView *)textView
{
    CGSize contentSize = textView.contentSize;
    if (self.sizeBlock) {
        self.sizeBlock(contentSize);
    }
}
-(void)setSendBlock:(ToolViewSendBlock)aBlock
{
    self.senderBlock = aBlock;
}

@end
