//
//  ThirdSdk.m
//  zcocos2dx-mobile
//
//  Created by tsixi_ima on 2019/5/8.
//

#import "ThirdSdk.h"
#include "cocos2d.h"
#include "CCLuaEngine.h"
#include "CCLuaBridge.h"
#import <CommonCrypto/CommonDigest.h>
using namespace cocos2d;

@implementation ThirdSdk

static int s_loginHandler = 0;
static int s_logoutHandler = 0;
static int s_payHandler = 0;
static int s_shareHandler = 0;

- (ThirdSdk*)init:(UIViewController*) delegate application:(UIApplication*)application options:(NSDictionary *)launchOptions
{
    NSDictionary *sdkconfig = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"TDSDK"];
    NSMutableDictionary* sdkparams = sdkconfig ? [NSMutableDictionary dictionaryWithDictionary:sdkconfig] : [NSMutableDictionary dictionary];
    [[TDSDK sharedInstance] initWithParams:sdkparams];
    
    _delegate = delegate;
    [[TDSDK sharedInstance] setDelegate:self];
    [[TDSDK sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [[TDSDK sharedInstance] setupWithParams:nil];
    return self;
}

+(void) doLogin:(NSDictionary *)dict
{
    if (s_loginHandler != 0) {
        LuaBridge::releaseLuaFunctionById(s_loginHandler);
        s_loginHandler = 0;
    }
    s_loginHandler = [[dict objectForKey:@"scriptHandler"] intValue];
    NSString *loginData = dict[@"custom"];
    if(loginData.length > 0){
        [[TDSDK sharedInstance].defaultUser loginCustom:loginData];
    }
    else
    {
        [[TDSDK sharedInstance].defaultUser login];
    }
}

+ (void) doPay:(NSDictionary*) dict

{
    if (s_payHandler != 0) {
        LuaBridge::releaseLuaFunctionById(s_payHandler);
        s_payHandler = 0;
    }
    s_payHandler = [[dict objectForKey:@"scriptHandler"] intValue];
    
    NSString* json = [dict objectForKey:@"json"];
    TDProductInfo* profuctInfo =  [TDProductInfo productFromJsonString:json];
    [[TDSDK sharedInstance].defaultPay pay:profuctInfo];
}

+(void) doSubmitExtraData:(NSDictionary*) dict
{
    NSString* json = [dict objectForKey:@"json"];
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError* err = nil;
    NSDictionary* extraData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&err];
    [[TDSDK sharedInstance] submitExtraData:extraData];
}

+(void) doLogout:(NSDictionary *)dict
{
    if (s_logoutHandler != 0) {
        LuaBridge::releaseLuaFunctionById(s_logoutHandler);
        s_logoutHandler = 0;
    }
    s_logoutHandler = [[dict objectForKey:@"scriptHandler"] intValue];
    [[TDSDK sharedInstance].defaultUser logout];
}

+(void) setLogoutHandler:(NSDictionary *)dict
{
    if (s_logoutHandler != 0) {
        LuaBridge::releaseLuaFunctionById(s_logoutHandler);
        s_logoutHandler = 0;
    }
    s_logoutHandler = [[dict objectForKey:@"scriptHandler"] intValue];
}

+ (void) doShare:(NSDictionary*) dict
{
    if (s_shareHandler != 0) {
        LuaBridge::releaseLuaFunctionById(s_shareHandler);
        s_shareHandler = 0;
    }
    s_shareHandler = [[dict objectForKey:@"scriptHandler"] intValue];
    
    NSString* json = [dict objectForKey:@"json"];
    
    
    NSError* err = nil;
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&err];
    
    TDShareInfo* ret = [[TDShareInfo alloc] initWithDictionary:jsonObj];
    
    
    [[TDSDK sharedInstance].defaultShare share:ret];
}

-(UIView*) GetView
{
    return [_delegate view];
}

-(UIViewController*) GetViewController
{
    return _delegate;
}

-(void) OnPlatformInit:(NSNotification*)notification
{
    
}

-(void) OnUserLogin:(NSNotification*)notification
{
    NSError* err = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:notification.userInfo options:kNilOptions error:&err];
    NSString* extension = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    LuaBridge::pushLuaFunctionById(s_loginHandler);
    LuaStack *stack = LuaBridge::getStack();
    stack->pushString([extension UTF8String]);
    stack->executeFunction(1);
    [extension release];
}

-(void) OnUserLogout:(NSNotification*)notification
{
    if (s_logoutHandler != 0)
    {
        LuaBridge::pushLuaFunctionById(s_logoutHandler);
        LuaStack *stack = LuaBridge::getStack();
        stack->executeFunction(0);
    }
}

-(void) OnPayPaid:(NSNotification*)notification
{
    BOOL result = [[notification.userInfo valueForKey:@"result"] boolValue];
    LuaBridge::pushLuaFunctionById(s_payHandler);
    LuaStack *stack = LuaBridge::getStack();
    stack->pushBoolean(result);
    stack->executeFunction(1);
    
}

-(void)OnEventCustom:(NSNotification *)notification
{
    NSString *eventName = notification.userInfo[@"eventName"];
    if ([eventName isEqualToString:@"share"]) {
        BOOL result = [[notification.userInfo valueForKey:@"success"] boolValue];
        LuaBridge::pushLuaFunctionById(s_shareHandler);
        LuaStack *stack = LuaBridge::getStack();
        NSString *resultStr = [NSString stringWithFormat:@"{\"success\":%d}",result ? 1 : 0];
        stack->pushString([resultStr UTF8String]);
        stack->executeFunction(1);
    }
}

- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    return [[TDSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return [[TDSDK sharedInstance] application:application openURL:url options:options];
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url
{
    return [[TDSDK sharedInstance] application:application handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    [[TDSDK sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[TDSDK sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[TDSDK sharedInstance] applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[TDSDK sharedInstance] applicationWillEnterForeground:application];
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[TDSDK sharedInstance] applicationWillTerminate:application];
}

@end

