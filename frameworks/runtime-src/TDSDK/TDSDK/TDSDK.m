//
//  TDSDK.m
//  TDSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import "TDSDK.h"
#import "TDPlugin.h"

#import <CommonCrypto/CommonDigest.h>

#define DEFINE_NOTIFICATION(name) __attribute__((visibility ("default"))) NSString* const name = @#name;

DEFINE_NOTIFICATION(TDSDKPlatformInit);
DEFINE_NOTIFICATION(TDSDKUserLogin);
DEFINE_NOTIFICATION(TDSDKUserLogout);
DEFINE_NOTIFICATION(TDSDKPayPaid);
DEFINE_NOTIFICATION(TDSDKCustomEvent);

@implementation TDSDK
{
    NSMutableArray* plugins;
    id<TDSDKDelegate> delegate;
}

static TDSDK* _instance = nil;

+(TDSDK*) sharedInstance
{
    if (_instance == nil)
    {
        _instance = [[TDSDK alloc] init];
    }
    return _instance;
}

- (void) setDelegate:(id<TDSDKDelegate>)obj
{
    delegate = obj;
    if ([obj respondsToSelector:@selector(OnPlatformInit:)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:obj
                                                 selector:@selector(OnPlatformInit:)
                                                     name:TDSDKPlatformInit
                                                   object:nil
         ];
    }
    
    if ([obj respondsToSelector:@selector(OnUserLogin:)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:obj
                                                 selector:@selector(OnUserLogin:)
                                                     name:TDSDKUserLogin
                                                   object:nil
         ];
    }
    
    if ([obj respondsToSelector:@selector(OnUserLogout:)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:obj
                                                 selector:@selector(OnUserLogout:)
                                                     name:TDSDKUserLogout
                                                   object:nil
         ];
    }
    
    if ([obj respondsToSelector:@selector(OnPayPaid:)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:obj
                                                 selector:@selector(OnPayPaid:)
                                                     name:TDSDKPayPaid
                                                   object:nil
         ];
    }
    
    if ([obj respondsToSelector:@selector(OnEventCustom:)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:obj
                                                 selector:@selector(OnEventCustom:)
                                                     name:TDSDKCustomEvent
                                                   object:nil
         ];
    }
}

- (id)init {
    plugins = [NSMutableArray array];
    self.supportedOrientations = UIInterfaceOrientationMaskLandscape;
    return self;
}

-(void) initWithParams:(NSDictionary*)params
{
    if (params == nil) return;
    
    self.sdkParams = params;
    
    // TODO 从配置文件读取需要加载的插件
    NSArray* configPlugins = [params valueForKey:@"Plugins"];
    for (NSDictionary* pluginConfig in configPlugins) {
        NSString* className = [pluginConfig valueForKey:@"name"];
        if (![className hasPrefix:@"TDSDK_"])
        {
            className = [@"TDSDK_" stringByAppendingString:className];
        }
        Class pluginClass = NSClassFromString(className);
        if (pluginClass != nil)
        {
            TDPlugin* plugin = [pluginClass alloc];
            [plugin setParams:pluginConfig];
            [self registerPlugin:[plugin initWithParams:pluginConfig]];
        }
        else
        {
            NSLog(@"unable loadPlugin: %@", className);
        }
    }
}

-(BOOL) IsSupportFunction:(SEL)function
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:function])
        {
            return YES;
        }
    }
    return NO;
}

-(BOOL) isInitCompleted
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(isInitCompleted)])
        {
            if (![plugin isInitCompleted])
            {
                return NO;
            }
        }
    }
    
    return YES;
}

-(UIView*) GetView
{
    return [delegate GetView];
}

-(UIViewController*) GetViewController
{
    return [delegate GetViewController];
}

-(void) registerPlugin:(NSObject<TDPluginProtocol>*)plugin
{
    if (plugin)
    {
        [plugins addObject:plugin];
    }
}

-(NSObject*) getInterfaceByName:(NSString*)name andProtocol:(Protocol *)aProtocol
{
    for (TDPlugin* plugin in plugins) {
        NSString* pluginClassName = NSStringFromClass([plugin class]);
        
        if (![name hasPrefix:@"TDSDK_"])
        {
            name = [@"TDSDK_" stringByAppendingString:name];
        }
        if ([pluginClassName compare:name] == NSOrderedSame)
        {
            if (aProtocol == nil)
                return plugin;
            else
            {
                return [plugin getInterface:aProtocol];
            }
        }
    }
    
    return nil;
}

-(NSArray*) plugins
{
    return plugins;
}

-(void) setupWithParams:(NSDictionary*)params
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(setupWithParams:)])
        {
            [plugin setupWithParams:params];
        }
    }
}

-(void) submitExtraData:(NSDictionary*)data
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(submitExtraData:)])
        {
            [plugin submitExtraData:data];
        }
    }
}

- (void)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)])
        {
            [plugin application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(applicationWillResignActive:)])
        {
            [plugin applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(applicationDidEnterBackground:)])
        {
            [plugin applicationDidEnterBackground:application];
        }
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(applicationWillEnterForeground:)])
        {
            [plugin applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(applicationDidBecomeActive:)])
        {
            [plugin applicationDidBecomeActive:application];
        }
    }
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(applicationWillTerminate:)])
        {
            [plugin applicationWillTerminate:application];
        }
    }
}

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(didRegisterForRemoteNotificationsWithDeviceToken:)])
        {
            [plugin didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(didFailToRegisterForRemoteNotificationsWithError:)])
        {
            [plugin didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}
- (void)didReceiveLocalNotification:(UILocalNotification*)notification
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(didReceiveLocalNotification:)])
        {
            [plugin didReceiveLocalNotification:notification];
        }
    }
}
- (void)didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(didReceiveRemoteNotification:)])
        {
            [plugin didReceiveRemoteNotification:userInfo];
        }
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL ret = NO;
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            ret |= [plugin application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    
    return ret;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL ret = NO;
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(application:openURL:options:)]) {
            ret |= [plugin application:application openURL:url options:options];
        }
    }
    
    return ret;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL ret = NO;
    for (NSObject<TDPluginProtocol>* plugin in plugins) {
        if ([plugin respondsToSelector:@selector(application:handleOpenURL:)]) {
            ret |= [plugin application:application handleOpenURL:url];
        }
    }
    
    return ret;
}


+(NSString*) encodeHttpParams:(NSDictionary*)params encode:(NSStringEncoding)encoding
{
    NSMutableArray* paramsArray = [NSMutableArray array];
    
    for (NSString* key in params) {
        id value = [params valueForKey:key];
        
        NSString* strValue = nil;
        
        if ([value isKindOfClass:[NSDictionary class]] ||
            [value isKindOfClass:[NSArray class]] ||
            [value isKindOfClass:[NSData class]] ||
            [value isKindOfClass:[NSSet class]])
        {
            NSError* err = nil;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:value options:kNilOptions error:&err];
            strValue = [[NSString alloc] initWithData:jsonData encoding:encoding];
        }
        else if ([value isKindOfClass:[NSString class]])
        {
            strValue = value;
        }
        else
        {
            strValue = [value description];
        }
        
        static NSString * const kAFCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";
        static NSString * const kAFCharactersToLeaveUnescapedInQueryStringPairKey = @"[].";
        
        NSString* strKey = (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                                  kCFAllocatorDefault,
                                                                                                  (__bridge CFStringRef)key,
                                                                                                  (__bridge CFStringRef)kAFCharactersToLeaveUnescapedInQueryStringPairKey,
                                                                                                  (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
        
        strValue = (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                          kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)strValue,
                                                                                          NULL,
                                                                                          (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString,
                                                                                          CFStringConvertNSStringEncodingToEncoding(encoding));
        
        [paramsArray addObject:[NSString stringWithFormat:@"%@=%@", strKey, strValue]];
    }
    
    return [paramsArray componentsJoinedByString:@"&"];
}

@end
