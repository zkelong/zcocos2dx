//
//  TDSDK.h
//  TDSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TDPay.h"

@implementation TDProductInfo


+(instancetype) productFromJsonString:(NSString*)js
{
    NSError* err = nil;
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:[js dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&err];
    
    TDProductInfo* ret = [[TDProductInfo alloc] initWithDict:jsonObj];
    
    return ret;
}

-(instancetype) initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self == nil)
        return nil;
    
    self.orderID = [dict valueForKey:@"orderID"];
    self.productId = [dict valueForKey:@"productID"];
    self.productName = [dict valueForKey:@"productName"];
    self.productDesc = [dict valueForKey:@"productDesc"];
    
    self.price = [dict valueForKey:@"price"];
    self.buyNum = [[dict valueForKey:@"buyNum"] intValue];
    
    self.roleId = [dict valueForKey:@"roleID"];
    self.roleName = [dict valueForKey:@"roleName"];
    self.roleLevel = [dict valueForKey:@"roleLevel"];
    self.vip = [dict valueForKey:@"vip"];
    self.serverId = [dict valueForKey:@"serverID"];
    self.serverName = [dict valueForKey:@"serverName"];
    
    self.extension = [dict valueForKey:@"extension"];
    self.checkUrl = [dict valueForKey:@"check_url"];
    return self;
}

-(NSString*) toJsonString
{
    NSDictionary* jsonObj = @{
                              @"orderID": self.orderID,
                              @"productID": self.productId,
                              @"productName": self.productName,
                              @"productDesc": self.productDesc,
                              @"price": self.price,
                              @"buyNum": [NSNumber numberWithLong:self.buyNum],
                              @"roleID": self.roleId,
                              @"roleName": self.roleName,
                              @"roleLevel": self.roleLevel,
                              @"vip": self.vip,
                              @"serverID": self.serverId,
                              @"serverName": self.serverName,
                              @"extension": self.extension
                              };
    NSError* err = nil;
    NSData* jsdata = [NSJSONSerialization dataWithJSONObject:jsonObj options:kNilOptions error:&err];
    
    return [[NSString alloc] initWithData:jsdata encoding:NSUTF8StringEncoding];
}

@end
