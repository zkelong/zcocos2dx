//
//  TDSDK.h
//  TDSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TDShare.h"

@implementation TDShareInfo
{
    NSMutableDictionary* _dict;
}

-(id)init
{
    if (self = [super init])
    {
        _dict = [NSMutableDictionary dictionary];
        return self;
    }
    
    return nil;
}

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        _dict = [NSMutableDictionary dictionaryWithDictionary:dict];
        return self;
    }
    
    return nil;
}

-(NSString*)title
{
    return [_dict valueForKey:@"title"];
}

-(NSString*)content
{
    return [_dict valueForKey:@"content"];
}

-(NSString*)url
{
    return [_dict valueForKey:@"url"];
}

-(NSString*)imgUrl
{
    return [_dict valueForKey:@"imgUrl"];
}

-(id)valueForKey:(NSString *)key
{
    return [_dict valueForKey:key];
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [_dict setValue:value forKey:key];
}

@end
