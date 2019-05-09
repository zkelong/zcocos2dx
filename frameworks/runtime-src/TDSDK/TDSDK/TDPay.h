//
//  TDSDK.h
//  TDSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDProductInfo : NSObject

@property (strong, nonatomic)NSString* orderID;
@property (strong, nonatomic)NSString* productId;
@property (strong, nonatomic)NSString* productName;
@property (strong, nonatomic)NSString* productDesc;

@property (strong, nonatomic)NSNumber* price;
@property NSInteger buyNum;

@property (strong, nonatomic)NSString* roleId;
@property (strong, nonatomic)NSString* roleName;
@property (strong, nonatomic)NSString* roleLevel;
@property (strong, nonatomic)NSString* vip;
@property (strong, nonatomic)NSString* serverId;
@property (strong, nonatomic)NSString* serverName;

@property (strong, nonatomic)NSDictionary* extension;
@property (strong, nonatomic) NSString *checkUrl;

+(instancetype) productFromJsonString:(NSString*)js;
-(NSString*) toJsonString;

@end

//TDPay 应用内购接口
@protocol TDPay

-(void) pay:(TDProductInfo*) profuctInfo;

@optional
-(void) openIAP;

@optional
-(void) closeIAP;

@optional
-(void) finishTransactionId:(NSString*)transactionId;

@end
