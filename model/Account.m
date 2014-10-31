//
//  Account.m
//  005LoveWords
//
//  Created by HDP King on 14-3-7.
//  Copyright (c) 2014年 HDP King. All rights reserved.
//

#import "Account.h"
#import "Config.h"
#import "Config.h"

static Account * acc;

@implementation Account

+(Account*)sharedAccount
{
    if (!acc)
    {
        acc = [[Account alloc]init];
        
        
        
        
        
    }
    
    return acc;
}

//-(id)initWithCoder:(NSCoder *)decoder{
//    
//    
//    
//    
//    if (self = [super init]) {
//        self.accessToken = [decoder decodeObjectForKey:kAccessToken];
//        self.uid = [decoder decodeObjectForKey:kUID];
//        self.name = [decoder decodeObjectForKey:kName];
//        self.sex = [decoder decodeObjectForKey:kSex];
//        self.userImage = [decoder decodeObjectForKey:kUserImage];
//        self.tel = [decoder decodeObjectForKey:kTel];
//        self.relation = [decoder decodeObjectForKey:kRelation];
//        self.deviceToken = [decoder decodeObjectForKey:kDeviceToken];
//    }
//    return self;
//}
//
//-(void)encodeWithCoder:(NSCoder *)encoder{
//    [encoder encodeObject:self.accessToken forKey:kAccessToken];
//    [encoder encodeObject:self.uid forKey:kUID];
//    [encoder encodeObject:self.name forKey:kName];
//    [encoder encodeObject:self.sex forKey:kSex];
//    [encoder encodeObject:self.userImage forKey:kUserImage];
//    [encoder encodeObject:self.tel forKey:kTel];
//    [encoder encodeObject:self.relation forKey:kRelation];
//    [encoder encodeObject:self.deviceToken forKey:kDeviceToken];
//}
//
@end
