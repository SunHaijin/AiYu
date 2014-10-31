//
//  NSURLRequest+Url.h
//  AiYu
//
//  Created by ibokan on 14-10-16.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Url)
+(NSURLRequest * )requestWithPath:(NSString *)path params:(NSDictionary *)params;

@end
