//
//  SBKUnitConvertHelper.h
//  Sensoro Beacon Kit
//
//  Created by David Yang on 14/12/26.
//  Copyright (c) 2014年 Sensoro Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBKConstants.h"

@interface SBKUnitConvertHelper : NSObject

+ (short) transimitPowerToRawValue: (SBKBeaconTransmitPower) transmitPower;
+ (float) frequencyToRawValue: (SBKBeaconAdvertisingInterval) broadcastInterval;

+ (NSString*) transimitPowerToString: (SBKBeaconTransmitPower) transmitPower;
+ (NSString*) frequencyToString: (SBKBeaconAdvertisingInterval) broadcastInterval;

@end
