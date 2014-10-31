//
//All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class Account;

@interface AccountTool : NSObject

singleton_interface(AccountTool)

@property (nonatomic, strong) NSMutableDictionary *accounts;
@property (nonatomic, strong) Account *currentAccount;

//存档
-(void)addAccount:(Account *)account;

//读档
-(Account *)accountWithUid:(NSString *)uid;

//退出登录
-(void)signOut:(Account *)account;

@end
