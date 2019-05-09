//
//  TDSDK.h
//  TDSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//TDUser 账号登录相关接口
@protocol TDUser

- (void) login;
- (void) logout;
- (void) switchAccount;

- (BOOL) hasAccountCenter;

@optional
- (void) loginCustom:(NSString*)customData;
- (void) showAccountCenter;

@end
