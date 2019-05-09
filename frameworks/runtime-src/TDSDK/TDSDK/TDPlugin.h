//
//  TDSDK.h
//  TDSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import "TDSDK.h"

@interface TDUserExtraData : NSObject

@property int dataType;
@property (nonatomic, strong) NSString* roleID;
@property (nonatomic, strong) NSString* roleName;
@property (nonatomic, strong) NSString* roleLevel;
@property int serverID;
@property (nonatomic, strong) NSString* serverName;
@property int moneyNum;
@property (nonnull,strong) NSString * extraData;
@end

// TDPlugin 插件接口
@protocol TDPluginProtocol

-(instancetype) initWithParams:(NSDictionary*)params;

@optional

-(BOOL) isInitCompleted;
-(void) setupWithParams:(NSDictionary*)params;
-(void) submitExtraData:(NSDictionary*)data;

// UIApplicationDelegate事件
- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url;
- (void)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken;
- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError*)error;

- (void)didReceiveLocalNotification:(UILocalNotification*)notification;
- (void)didReceiveRemoteNotification:(NSDictionary*)userInfo;

@end

@interface TDPlugin : NSObject<TDPluginProtocol>

@property (nonatomic, copy) NSDictionary* params;

-(instancetype) initWithParams:(NSDictionary*)params;

-(BOOL) getBoolForParam:(NSString*)key default:(BOOL)defaultValue;

-(UIView*) view;
-(UIViewController*) viewController;

-(id) getInterface:(Protocol *)aProtocol;

-(void) eventPlatformInit:(NSDictionary*) params;
-(void) eventUserLogin:(NSDictionary*) params;
-(void) eventUserLoginExt:(id) extension;
-(void) eventUserLogout:(NSDictionary*) params;
-(void) eventPayPaid:(NSDictionary*) params;
-(void) eventCustom:(NSString*)name params:(NSDictionary*)params;

@end
