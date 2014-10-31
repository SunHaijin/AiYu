//
//  AccountTool.m

//

// All rights reserved.
//

#define kFileName @"accounts.dat"
#define kCurrentName @"currentAccount.dat"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName]

#define kCurrentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kCurrentName]

#import "AccountTool.h"
#import "Account.h"

@interface AccountTool ()

@end

@implementation AccountTool
singleton_implementation(AccountTool)

- (id)init
{
    self = [super init];
    if (self) {
        //1. 从账号中读取账号信息
        self.accounts = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        self.currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kCurrentPath];
        
        //2. 如果没有账号信息
        if (self.accounts == nil) {
            self.accounts = [NSMutableDictionary dictionary];
        }
    }
    return self;
}

//存档
-(void)addAccount:(Account *)account{
    //1. 添加账号并设置为当前账号
    [self.accounts setObject:account forKey:account.uid];
    self.currentAccount = account;
    
    //2. 归档
    [NSKeyedArchiver archiveRootObject:self.accounts toFile:kFilePath];
    [NSKeyedArchiver archiveRootObject:self.currentAccount toFile:kCurrentPath];
}

//读档
-(Account *)accountWithUid:(NSString *)uid{
    Account *acc =   [self.accounts objectForKey:uid];
    return acc;
}

//退出

-(void)signOut:(Account *)account{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager isDeletableFileAtPath:kCurrentPath]) {
        [fileManager removeItemAtPath:kCurrentPath error:nil];
    }
}

@end
