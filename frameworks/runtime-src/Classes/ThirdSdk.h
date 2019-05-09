//
//  ThirdSdk.h
//  zcocos2dx-mobile
//
//  Created by tsixi_ima on 2019/5/8.
//

#import <Foundation/Foundation.h>
#import "TDSDK.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThirdSdk : NSObject
{
    UIViewController* _delegate;
}

+ (void) doLogin:(NSDictionary*) dict;
+ (void) doLogout:(NSDictionary*) dict;
+ (void) setLogoutHandler:(NSDictionary*) dict;
+ (void) doPay:(NSDictionary*) dict;
+ (void) doSubmitExtraData:(NSDictionary*) dict;

- (ThirdSdk*)init:(UIViewController*) delegate application:(UIApplication*)application options:(NSDictionary *)launchOptions;
- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation;
- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url options:(NSDictionary<NSString*, id> *)options;
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url;

- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application;
@end

NS_ASSUME_NONNULL_END
