#import "TDSDK_TESTSDK.h"

@interface TDSDK_TESTSDK()
@end

@implementation TDSDK_TESTSDK

-(instancetype)initWithParams:(NSDictionary *)params
{
    [TDSDK sharedInstance].defaultUser = self;
    [TDSDK sharedInstance].defaultPay = self;
    [TDSDK sharedInstance].defaultShare = self;
    return self;
}

-(NSArray *)supportPlatforms
{
    return @[];
}

- (void)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return true;
}

// Still need this for iOS8
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(nullable NSString *)sourceApplication
         annotation:(nonnull id)annotation
{
    return YES;
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void) loginCustom:(NSString*)customData;
{
    [self login];
}

-(void) login
{
    NSDictionary *callbackDict = [NSDictionary dictionaryWithObjectsAndKeys:@"123", @"token", @"123", @"userid", nil];
    [self eventUserLogin:callbackDict];
}

-(void) logout
{
    [self eventUserLogout:nil];
}

-(void) switchAccount
{
    
}

-(BOOL)hasAccountCenter
{
    return NO;
}

-(void) pay:(TDProductInfo*) profuctInfo;
{
    
}

-(void) showAccountCenter
{
}

#pragma mark - fb share

-(void)shareTo:(NSString *)platform shareParams:(TDShareInfo *)params
{}

-(void)share:(TDShareInfo *)params
{
    [self shareFbWithLink:[params valueForKey:@"imageUrl"]];
    
}

- (void)shareFbWithLink:(NSString *)aUrl
{
   
}


-(void)submitExtraData:(NSDictionary *)data
{
    
}

@end
