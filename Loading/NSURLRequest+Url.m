//
//  NSURLRequest+Url.m
//  AiYu
//
//  Created by ibokan on 14-10-16.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "NSURLRequest+Url.h"
#import "AccountTool.h"
#import "Account.h"
#import "Config.h"


@implementation NSURLRequest (Url)
+(NSURLRequest * )requestWithPath:(NSString *)path params:(NSDictionary *)params

{
    NSMutableString * urlStr = [NSMutableString stringWithFormat:@"%@%@",kBaseURL,path];
    if (params)
    {
        [urlStr appendString:@"?"];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [urlStr appendFormat:@"&%@=%@",key,obj];
        }];
    }
    NSURL * url = [NSURL URLWithString:urlStr];
    return [NSURLRequest requestWithURL:url];
    
}
@end
