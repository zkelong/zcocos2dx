//
//  TDSDK.h
//  TDSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDShareInfo : NSObject

-(id)initWithDictionary:(NSDictionary*)dict;

-(NSString*) title;
-(NSString*) content;
-(NSString*) url;
-(NSString*) imgUrl;

-(id)valueForKey:(NSString *)key;
-(void)setValue:(id)value forKey:(NSString *)key;

@end

//分享接口
@protocol TDShare

-(NSArray*)supportPlatforms;
-(void)share:(TDShareInfo*)params;
-(void)shareTo:(NSString*)platform shareParams:(TDShareInfo*)params;

@end
