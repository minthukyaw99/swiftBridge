//
//  CalendarManagerBridge.m
//  SwiftBridge
//
//  Created by Michael Schwartz on 12/11/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

// CalendarManagerBridge.m
#import "React/RCTBridgeModule.h"

#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(GNearByManager, RCTEventEmitter)

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"NearByEvent"];
}

RCT_EXTERN_METHOD(addEvent:(NSString *)name location:(NSString *)location date:(NSNumber *)date)

RCT_EXTERN_METHOD(startScanning:(NSString *)name)

RCT_EXTERN_METHOD(debugMode:(NSBOOL *)isOn)
@end
