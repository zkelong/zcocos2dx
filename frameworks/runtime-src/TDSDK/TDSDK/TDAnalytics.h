//
//  TDSDK.h
//  TDSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 TDsdk. All rights reserved.
//

#import <Foundation/Foundation.h>

// 统计分析、崩溃采集接口
@protocol TDAnalytics

@optional
-(void)reportException:(NSDictionary*)params;
-(void)reportLog:(NSDictionary*)params;

@end

