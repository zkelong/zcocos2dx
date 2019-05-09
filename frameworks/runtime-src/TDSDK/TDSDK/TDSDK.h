//
//  TDSDK.h
//  TDSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TDUser.h"
#import "TDPay.h"
#import "TDShare.h"
#import "TDAnalytics.h"

#ifdef __cplusplus
#define TDSDK_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define TDSDK_EXTERN	    extern __attribute__((visibility ("default")))
#endif

// TDSDK回调接口
@protocol TDSDKDelegate <NSObject>

-(UIView*) GetView;
-(UIViewController*) GetViewController;

@optional

-(void) OnPlatformInit:(NSNotification*)notification;
-(void) OnUserLogin:(NSNotification*)notification;
-(void) OnUserLogout:(NSNotification*)notification;
-(void) OnPayPaid:(NSNotification*)notification;
-(void) OnEventCustom:(NSNotification*)notification;

@end

// TDSDK的核心类
// 负责插件管理和事件分发
@interface TDSDK : NSObject

@property (nonatomic, copy) NSDictionary* sdkParams;
@property NSInteger supportedOrientations;
@property (strong, nonatomic) NSObject<TDUser>* defaultUser;
@property (strong, nonatomic) NSObject<TDPay>* defaultPay;
@property (strong, nonatomic) NSObject<TDShare>* defaultShare;


+(TDSDK*) sharedInstance;

-(void) setDelegate:(id<TDSDKDelegate>)delegate;
-(void) registerPlugin:(NSObject*)plugin;

-(NSObject*) getInterfaceByName:(NSString*)name andProtocol:(Protocol *)aProtocol;

// NSDictionary转换为Http的URL参数
+(NSString*) encodeHttpParams:(NSDictionary*)params encode:(NSStringEncoding)encoding;

-(NSArray*) plugins;

-(UIView*) GetView;
-(UIViewController*) GetViewController;

-(void) initWithParams:(NSDictionary*)params;

-(void) setupWithParams:(NSDictionary*)params;
-(void) submitExtraData:(NSDictionary*)data;
-(BOOL) isInitCompleted;
-(BOOL) IsSupportFunction:(SEL)function;

// UIApplicationDelegate事件
- (void)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

// 推送通知相关事件
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken;
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error;
- (void)application:(UIApplication*)application didReceiveLocalNotification:(UILocalNotification*)notification;
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo;

// url处理
- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url;

@end

TDSDK_EXTERN NSString* const TDSDKPlatformInit;
TDSDK_EXTERN NSString* const TDSDKUserLogin;
TDSDK_EXTERN NSString* const TDSDKUserLogout;
TDSDK_EXTERN NSString* const TDSDKPayPaid;
TDSDK_EXTERN NSString* const TDSDKCustomEvent;
