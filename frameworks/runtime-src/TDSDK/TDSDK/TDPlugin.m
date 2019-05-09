//
//  TDPlugin.m
//  TDPlugin
//
//  Created by dayong on 15-8-8.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import "TDPlugin.h"
#import <Foundation/Foundation.h>

@implementation TDUserExtraData

@end

@implementation TDPlugin
{
    NSMutableArray* interfaces;
}

-(instancetype) initWithParams:(NSDictionary*)params
{
    return self;
}

-(BOOL) getBoolForParam:(NSString*)key default:(BOOL)defaultValue
{
    NSNumber* value = [_params valueForKey:key];
    
    if (value)
        return value.boolValue;
    
    return defaultValue;
}

-(UIView*) view
{
    return [[TDSDK sharedInstance] GetView];
}

-(UIViewController*) viewController
{
    return [[TDSDK sharedInstance] GetViewController];
}

-(id) getInterface:(Protocol *)aProtocol
{
    if ([self conformsToProtocol:aProtocol])
    {
        return self;
    }
    
    if (interfaces != nil)
    {
        for (id item in interfaces) {
            if ([item conformsToProtocol:aProtocol])
            {
                return item;
            }
        }
    }
    
    return nil;
}

-(void) registerInterface:(NSObject*)aInterface
{
    if (interfaces == nil)
    {
        interfaces = [NSMutableArray arrayWithObject:aInterface];
    }
    else
    {
        [interfaces addObject:aInterface];
    }
}

-(void) eventPlatformInit:(NSDictionary*) params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TDSDKPlatformInit object:self userInfo:params];
}

-(void) eventUserLogin:(NSDictionary*) params
{
    [self eventUserLoginAll:params];
}

-(void)eventUserLoginExt:(id)extension
{
    [self eventUserLoginAll:@{ @"extension":extension }];
}

-(void)eventUserLoginAll:(NSDictionary*)params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TDSDKUserLogin object:self userInfo:params];
}

-(void) eventUserLogout:(NSDictionary*) params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TDSDKUserLogout object:self userInfo:params];
}

-(void) eventPayPaid:(NSDictionary*) params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TDSDKPayPaid object:self userInfo:params];
}

-(void) eventCustom:(NSString*)name params:(NSDictionary*)params
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TDSDKCustomEvent object:self userInfo:params];
}

@end
