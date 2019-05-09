#import <Foundation/Foundation.h>
#import "TDPlugin.h"

@interface TDSDK_TESTSDK : TDPlugin<TDUser, TDPay,TDShare,TDPluginProtocol>

- (void) login;
- (void) logout;
- (void) switchAccount;
- (BOOL) hasAccountCenter;
- (void) showAccountCenter;

-(void) pay:(TDProductInfo*) profuctInfo;
-(void) share:(TDShareInfo *)params;
@end
