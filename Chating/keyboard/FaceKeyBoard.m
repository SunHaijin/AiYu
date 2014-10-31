

//
//  FaceKeyBoard.m
//  AiYu
//
//  Created by ibokan on 14-10-17.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "FaceKeyBoard.h"
#import <AFNetworking/AFNetworking.h>



@interface FaceKeyBoard()

@property(nonatomic,strong)FaceBlock faceBlock;
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong)UIScrollView * faceScrollView;
@property(nonatomic,strong)UIView *zuijinv;
@property(nonatomic,strong)UIScrollView *moreScrollview;
@property(nonatomic,strong)FaceSendBlock faceblock;
@end

@implementation FaceKeyBoard

- (id)initWithFrame:(CGRect)frame
{
    CGRect s = [[UIScreen mainScreen] bounds];
    frame.size.height = 216;
    frame.size.width = s.size.width;
    self = [super initWithFrame:frame];
    if (self) {
        //表情scrollview
        
//        UIApplication *app=[UIApplication sharedApplication];
//        id delelgate=[app delegate];
//        self.managedObjectContext=[delelgate managedObjectContext];
        
        self.faceScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        self.faceScrollView.translatesAutoresizingMaskIntoConstraints=NO;
        self.faceScrollView.contentSize=CGSizeMake(1250, 170);
        self.faceScrollView.pagingEnabled=YES;
        self.faceScrollView.hidden=NO;
        self.faceScrollView.backgroundColor=[UIColor whiteColor];
        
        [self addSubview:self.faceScrollView];
        
        NSArray *c1=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_faceScrollView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_faceScrollView)];
        [self addConstraints:c1];
        
        NSArray *c2=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_faceScrollView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_faceScrollView)];
        [self addConstraints:c2];
        
        [self faceButton];
        
        //最近view
        self.zuijinv=[[UIView alloc]initWithFrame:CGRectZero];
        self.zuijinv.translatesAutoresizingMaskIntoConstraints=NO;
        self.zuijinv.hidden=YES;
        self.zuijinv.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.zuijinv];
        
        NSArray*c3=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_zuijinv]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_zuijinv)];
        [self addConstraints:c3];
        
        NSArray*c4=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_zuijinv]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_zuijinv)];
        [self addConstraints:c4];
        
        //更多scrollview
        self.moreScrollview=[[UIScrollView alloc]initWithFrame:CGRectZero];
        self.moreScrollview.contentSize=CGSizeMake(1250, 170);
        self.moreScrollview.translatesAutoresizingMaskIntoConstraints=NO;
        self.moreScrollview.hidden=YES;
        self.moreScrollview.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.moreScrollview];
        
        NSArray*c5=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_moreScrollview]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_moreScrollview)];
        [self addConstraints:c5];
        
        NSArray*c6=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_moreScrollview]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_moreScrollview)];
        [self addConstraints:c6];

        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        button1.translatesAutoresizingMaskIntoConstraints=NO;
        button1.frame=CGRectZero;
        // button1.frame = CGRectMake(0,200, (r.size.width)/3, 58);
        button1.backgroundColor=[UIColor groupTableViewBackgroundColor];
        button1.tag=buttonTagA;
        button1.titleLabel.font=[UIFont systemFontOfSize:20];
        [button1 setTitle:@"最近" forState:UIControlStateNormal];
        [button1 setTintColor:[UIColor blackColor]];
        [button1 addTarget:self action:@selector(tapZuiJin:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        NSArray * c15 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button1(==44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(button1)];
        [self addConstraints:c15];
        
        UIButton * button2 = [UIButton buttonWithType:UIButtonTypeSystem ];
        button2.frame=CGRectZero;
        button2.translatesAutoresizingMaskIntoConstraints=NO;
        //        button2.frame =CGRectMake((r.size.width)/3, 200, (r.size.width)/3, 58);
        button2.backgroundColor=[UIColor groupTableViewBackgroundColor];
        button2.tag=buttonTagB;
        button2.titleLabel.font=[UIFont systemFontOfSize:20];
        [button2 setTitle:@"更多" forState:UIControlStateNormal];
        [button2 setTintColor:[UIColor blackColor]];
        [button2 addTarget:self action:@selector(tapMoR:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button2];
        NSArray * c16 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button2(==44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(button2)];
        [self addConstraints:c16];
   
        UIButton * button3 = [UIButton buttonWithType:UIButtonTypeSystem];
        button3.frame=CGRectZero;
        button3.translatesAutoresizingMaskIntoConstraints=NO;
        
        button3.backgroundColor=[UIColor groupTableViewBackgroundColor];
        button3.tag=buttonTagC;
        [button3 setTitle:@"发送" forState:UIControlStateNormal];
        [button3 setTintColor:[UIColor blackColor]];
        button3.titleLabel.font=[UIFont systemFontOfSize:20];
        [button3 addTarget:self action:@selector(tapfasong) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];
        NSArray * c7 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button3(44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(button3)];
        [self addConstraints:c7];
        
        
        NSArray * c8 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button1][button2(==button1)][button3(==button1)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(button1,button2,button3)];
        [self addConstraints:c8];
    }
    return self;
}
-(void)tapZuiJin:(UIButton *)button
{
    self.faceScrollView.hidden=YES;
    self.moreScrollview.hidden=YES;
    self.zuijinv.hidden=NO;
    
    NSArray*subviews=self.zuijinv.subviews;
    for (UIView*view in subviews)
    {
        [view removeFromSuperview];
    }

}
-(void)tapMoR:(UIButton *)button
{
    
}
-(void)setSendBlock:(FaceSendBlock)aBlock
{
    self.faceblock=aBlock;
}
-(void)tapfasong
{
    if (self.faceblock) {
        self.faceblock(buttonTagC);
    }
    
}
-(void)faceButton
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString * path = [bundle pathForResource:@"emoticons2" ofType:@"plist"];
    NSArray * face = [[NSArray alloc]initWithContentsOfFile:path];
    int pages;
    if (face.count % 32) {
        pages = face.count / 32 + 1;
    } else {
        pages = face.count / 32;
    }
    NSLog(@"face.count = %d",face.count);
    self.faceScrollView.contentSize = CGSizeMake(pages * 320, 170);
    self.faceScrollView.pagingEnabled = YES;
    int c = 0;
    
    
    for (int j = 0; j < 4; j++) {
        for (int l = 0; l< 25; l++)
            
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
            
            button.frame=CGRectMake( 44 * l, 44 * j+7 , 30, 30);
            NSString * imageName = face[c][@"png"];
            [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            button.tag = j*25 +l;
            [button addTarget:self action:@selector(tapFaceButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.faceScrollView addSubview:button];
            c++;
            if (button.tag == 100) {
                break;
            }
            
        }
        
    }
}
-(void)tapFaceButton:(UIButton *)button
{
    if (self.faceBlock) {
        self.faceBlock(button.tag);
    }
}
-(void)setTapFaceButtonBlock:(FaceBlock)aBlock
{
    self.faceBlock=aBlock;
}
@end
