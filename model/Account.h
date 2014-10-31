//
//  Account.h
//
//

//  Copyright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
// AccessToken
@property (nonatomic, copy) NSString *accessToken;

// 用户ID
@property (nonatomic, copy) NSString *uid;

//昵称
@property (nonatomic, copy) NSString *name;

//性别
@property (nonatomic, copy) NSString *sex;

//头像
@property (nonatomic, copy) NSString *userImage;

//Tel
@property (nonatomic, copy) NSString *tel;

//关系
@property (nonatomic, copy) NSString *relation;

//设备标示
@property (nonatomic, copy) NSString *deviceToken;

//相册封面
@property (nonatomic, copy) NSString *backgroundImage;

+(Account*)sharedAccount;
@end
