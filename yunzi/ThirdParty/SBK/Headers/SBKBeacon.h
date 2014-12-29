//
//  SBKBeacon.h
//  Sensoro Beacon Kit
//
//  Created by Blankwonder on 6/12/14.
//  Copyright (c) 2014 Sensoro Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "SBKConstants.h"
#import "SBKBeaconID.h"

extern NSString * const SBKBeaconInRangeStatusUpdatedNotification;

/// the block as a callback when app communicate with beacon
typedef void (^SBKBeaconCompletionBlock)(NSError *error);

@protocol SBKBeaconDelegate;

/**
 *  The SBKBeacon class defines the interface of a sensoro beacon device. You can use instances of this class to get rssi, sensor data or configurate device settings. You do not create instances of this class directly. Use SBKBeaconManager to get SBKBeacon instances.
 *
 *  The identity of a beacon is defined by its beaconID properties.
 */
@interface SBKBeacon : NSObject

/**---------------------------------------------------------------------------------------
 * @name Setting and Getting the Delegate
 *  ---------------------------------------------------------------------------------------
 */

/**
 * The delegate of the app object.
 */
@property (readwrite, nonatomic, weak) id <SBKBeaconDelegate> delegate;

/**---------------------------------------------------------------------------------------
 * @name General Properties
 *  ---------------------------------------------------------------------------------------
 */

/**
 *  A SBKBeaconID object identify the beacon. (read-only)
 */
@property (readonly, nonatomic, copy) SBKBeaconID * beaconID;

/**
 *  The beacon's hardware serial number. (read-only)
 */
@property (readonly, nonatomic, copy) NSString * serialNumber;

/**
 *  Returns a Boolean value that indicates whether the beacon is in range. (read-only) 
 *
 * @discussion Beacon will be marked out of range after approximate 8 second in order to prevent notifications delivering too frequently.
 */
@property (readonly, nonatomic, assign) BOOL inRange;

/**
 *  the rssi value to decide if entering range of beacon.
 *
 * @discussion  if received rssi is larger than this value, it is in range of this beacon.
 */
@property (readwrite, nonatomic, assign) NSInteger inRangeMinimumRssiWhileEntering;

/**
 *  the rssi value to decide if leaving range of beacon.
 *
 * @discussion  if received rssi is less than this value, it is out of range of this beacon.
 */
@property (readwrite, nonatomic, assign) NSInteger inRangeMinimumRssiWhileLeaving;

/**
 *  The received signal strength of the beacon, measured in decibels. (read-only)
 *  
 *  @discussion If beacon is out of range, the value will be 0.
 */
@property (readonly, nonatomic, assign) NSInteger rssi;

/**
 *  The relative distance to the beacon. (read-only)
 *
 *  @discussion The value in this property gives a general sense of the relative distance to the beacon. Use it to quickly identify beacons that are nearer to the user rather than farther away.
 */
@property (readonly, nonatomic, assign) CLProximity proximity;

/**
 *  The accuracy of the proximity value, measured in meters from the beacon. (read-only)
 *
 *  @discussion Indicates the one sigma horizontal accuracy in meters. Use this property to differentiate between beacons with the same proximity value. Do not use it to identify a precise location for the beacon. Accuracy values may fluctuate due to RF interference. A negative value in this property signifies that the actual accuracy could not be determined.
 */
@property (readonly, nonatomic) CLLocationAccuracy accuracy;

/**
 *  The battery charge level for the device. (read-only)
 *
 *  @discussion Battery level ranges from 0.0 to 1.0 (100% charged).
 */
@property (readonly, nonatomic, copy) NSNumber * batteryLevel;

/**
 *  The model of the device. (read-only)
 */
@property (readonly, nonatomic, copy) NSString * hardwareModelName;

/**
 *  The current firmware version for the device. (read-only)
 */
@property (readonly, nonatomic, copy) NSString * firmwareVersion;

/**
 *  The current work model for the device. (read-only)
 */
@property (readonly, nonatomic) SBKBeaconWorkMode workModel;

/**---------------------------------------------------------------------------------------
 * @name Establishing or Canceling Connections with Beacon
 *  ---------------------------------------------------------------------------------------
 */

/**
 *  Establishes a connection to a beacon.
 *
 *  @param completion The block to execute after the connecting is completed. If error parameter is nil means connection has been established successfully.
 */
- (void)connectWithCompletion:(SBKBeaconCompletionBlock)completion;
/**
 *  Cancels an active or pending connection to a beacon.
 */
- (void)disconnect;
/**
 *  The current status of the connection.
 *
 *  @return A SBKBeaconConnectionStatus enum value.
 */
- (SBKBeaconConnectionStatus)connectionStatus;


/**---------------------------------------------------------------------------------------
 * @name Beacon Configuration
 *  ---------------------------------------------------------------------------------------
 */

/**
 *  The dictionary of beacon base configuration attributes. (read-only)
 *
 *  @discussion This property will be available after connect. For available options, see SBKBeaconBaseSettings.
 *
 *  @see writeBaseSettings:completion:
 */
@property (readonly, nonatomic) NSDictionary *baseSettings;

/**
 *  The dictionary of sensor configuration attributes. (read-only)
 *
 *  @discussion This property will be available after connect. For available options, see SBKBeaconSensorSettings.
 *
*  @see writeSensorSettings:completion:
 */
@property (readonly, nonatomic) NSDictionary *sensorSettings;

/**
 *  The value of sensor umm change interval attributes. (read-only)
 *
 *  you can change value, @see writeSecureBroadcastInterval:completion:
 */
@property (readonly, nonatomic) SBKBeaconSecureBroadcastInterval secureBroadcastInterval;

/**
 *  Updates proximity UUID of this beacon.
 *
 *  @param proximityUUID Proximity UUID in NSUUID object.
 *  @param completion    The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this writing operation be executed.
 */
- (BOOL)writeProximityUUID:(NSUUID *)proximityUUID completion:(SBKBeaconCompletionBlock)completion;

/**
 *  Updates major and minor of this beacon.
 *
 *  @param major      The major value.
 *  @param minor      The minor value.
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this writing operation be executed.
 */
- (BOOL)writeMajor:(NSNumber *)major minor:(NSNumber *)minor completion:(SBKBeaconCompletionBlock)completion;

/**
 *  Updates base settings of this beacon.
 *
 *  @param settings   Configuration attributes you try to update in a dictionary. For available options, see SBKBeaconBaseSettings.
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this writing operation be executed.
 */
- (BOOL)writeBaseSettings:(NSDictionary *)settings completion:(SBKBeaconCompletionBlock)completion;

/**
 *  Updates sensor settings of this beacon.
 *
 *  @param settings   Configuration attributes you try to update in a dictionary. For available options, see SBKBeaconSensorSettings.
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this writing operation be executed.
 */
- (BOOL)writeSensorSettings:(NSDictionary *)settings completion:(SBKBeaconCompletionBlock)completion;

/**
 *  Resets beacon to factory settings. This will reset proximityUUID, major, minor, baseSettings and sensorSettings to original values.
 *
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this writing operation be executed.
 */
- (BOOL)resetToFactorySettingsWithCompletion:(SBKBeaconCompletionBlock)completion;

/**
 *  Updates UMM Change interval.
 *
 *  @param interval The Secure Broadcast change interval. it is enum of @see SBKBeaconSecureBroadcastInterval;
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this writing operation be executed.
 */
- (BOOL)writeSecureBroadcastInterval:(SBKBeaconSecureBroadcastInterval)interval completion:(SBKBeaconCompletionBlock)completion;

/**
 *  Updates the key to encrypt the broadcast packet.
 *
 *  @param key the key to encrypt the broadcast packet;
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this writing operation be executed.
 */
- (BOOL)writeBroadcastKey:(NSString*) key completion:(SBKBeaconCompletionBlock)completion;

/**
 *  Clear the key to encrypt the broadcast packet.
 *
 *  @param completion The block to execute after the clear is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this clear operation be executed.
 */
- (BOOL)clearBroadcastKeyWithCompletion:(SBKBeaconCompletionBlock)completion;

/**
 *  Set device whether it is as beacon. if state was NO, the device is just a sensor.
 *
 *  @param state indicate whether the device is as beacon, if NO, the device is just a sensor,
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this writing operation be executed.
 */
- (BOOL)disableiBeacon:(BOOL) state completion:(SBKBeaconCompletionBlock)completion;

/**---------------------------------------------------------------------------------------
 * @name Writing Authorization
 *  ---------------------------------------------------------------------------------------
 */

/**
 *  Indicates if the application has permission to write setting to the beacon.
 */
@property (readonly, nonatomic) SBKBeaconWritePermissionStatus writePermissionStatus;

/**
 *  You should use this method to request write permission if writePermissionStatus property is restricted.
 *
 *  @param password   Password string.
 *  @param completion The block to execute after the operation is completed. If error parameter is nil means success.
 *
 *  @see writePermissionStatus
 *
 *  @return Can this operation be executed.
 */
- (BOOL)requireWritePermissionWithPassword:(NSString *)password completion:(SBKBeaconCompletionBlock)completion;

/**
 *  Changes the beacon's password.
 *
 *  @param password   New password string.
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this writing operation be executed.
 */
- (BOOL)updateWritePassword:(NSString *)password completion:(SBKBeaconCompletionBlock)completion;

/**
 *  Clear the beacon's password.
 *
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means clear successfully.
 *
 *  @return Can this clear operation be executed.
 */
- (BOOL)clearWritePasswordWithCompletion:(SBKBeaconCompletionBlock)completion;

/**
 *  @return Which energy saving mode the beacon supports.
 */
- (SBKBeaconEnergySavingMode)availableEnergySavingMode;

/**---------------------------------------------------------------------------------------
 * @name Temperature, Light and Accelerometer Sensor
 *  ---------------------------------------------------------------------------------------
 */

/**
 *  Causes beacon to reload temperature and light sensors data immediately.
 *
 *  @param completion The block to execute after the operation is completed. If error parameter is nil means success.
 *
 *  @return Can this operation be executed.
 */
- (BOOL)reloadSensorDataWithCompletion:(SBKBeaconCompletionBlock)completion;

/**
 *  @return Flag indicating whether temperature sensor is available.
 */
- (BOOL)isTemperatureSensorAvailable;

/**
 *  @return Flag indicating whether light sensor is available.
 */
- (BOOL)isLightSensorAvailable;

/**
 *  @return Flag indicating whether accelerometer sensor is available.
 */
- (BOOL)isAccelerometerAvailable;

/**
 *  @return Flag indicating whether this beacon has beacon information, uuid, major, minor, proximity, accuracy etc..
 */
- (BOOL)isBeacon;

/**
 *  @return Flag indicating whether this beacon has sensor information, temprature, light, accelerometer etc..
 */
- (BOOL)isSensor;

/**
 *  Temperature value in Celsius
 *
 *  @discussion Sensor data can only be updated when the app is running in the foreground.
 */
@property (readonly, nonatomic, copy) NSNumber * temperature;

/**
 *  The ambient light level in lux.
 *
 *  @discussion Sensor data can only be updated when the app is running in the foreground.
 */
@property (readonly, nonatomic, copy) NSNumber * light;

/**
 *
 *  The broadcast transmit power.
 *
 *  @see SBKBeaconTransmitPower.
 */
@property (nonatomic, readonly) NSNumber * broadcastTransmitPower;

/**
 *
 *  The broadcast transmit interval.
 *
 */
@property (nonatomic, readonly) NSNumber * broadcastInterval;

/**
 *  The number of accelerometer count.
 *
 *  @discussion Sensor data can only be updated when the app is running in the foreground.
 */
@property (readonly, nonatomic, copy) NSNumber * accelerometerCount;

/**
 *  Flag indicating accelerometer state, boolean value wrapped in NSNumber.
 *
 *  @discussion Sensor data can only be updated when the app is running in the foreground.
 */
@property (readonly, nonatomic, copy, getter = isMoving) NSNumber * moving;

/**
 *  Resets accelerometer counter value to zero.
 *
 *  @param completion The block to execute after the writing is completed. If error parameter is nil means writing successfully.
 *
 *  @return Can this operation be executed.
 */
- (BOOL)resetAccelerometerCountWithCompletion:(SBKBeaconCompletionBlock)completion;

/**---------------------------------------------------------------------------------------
 * @name Bridge to Core Bluetooth
 *  ---------------------------------------------------------------------------------------
 */

/**
 *  The CBPeripheral object assign to this beacon.
 */
@property (readonly, nonatomic, strong) CBPeripheral * assignedPeripheral;

@end

/**
 *  The delegate of a SBKBeacon object must adopt the SBKBeaconDelegate protocol. The delegate uses this protocol’s methods to monitor the connection state and sensor date changing of a beacon. There are no required methods in this protocol.
 */
@protocol SBKBeaconDelegate <NSObject>

@optional

/**
 *  Invoked when a connection is successfully created with a beacon.
 *
 *  @param beacon The beacon that has been connected.
 */
- (void)sensoroBeaconDidConnect:(SBKBeacon *)beacon;

/**
 *  Invoked when an existing connection with a beacon is torn down
 *
 *  @param beacon The beacon that has been disconnected.
 *  @param error  If an error occurred, the cause of the failure.
 */
- (void)sensoroBeaconDidDisconnect:(SBKBeacon *)beacon error:(NSError *)error;

/**
 *  Invoked when a beacon's RSSI changes.
 *
 *  @param beacon The beacon providing this information.
 *  @param rssi   The new rssi value.
 */
- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateRSSI:(NSInteger)rssi;;

/**
 *  Invoked when a beacon's temperature data changes.
 *
 *  @param beacon      The beacon providing this information.
 *  @param temperature New temperature value wrapped in NSNumber.
 */
- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateTemperatureData:(NSNumber *)temperature;

/**
 *  Invoked when a beacon's light lux changes.
 *
 *  @param beacon The beacon providing this information.
 *  @param light  New ambient light level in lux.
 */
- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateLightData:(NSNumber *)light;

/**
 *  Invoked when a beacon's accelerometer count changes.
 *
 *  @param beacon             The beacon providing this information.
 *  @param accelerometerCount New accelerometer count value.
 */
- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateAccelerometerCount:(NSNumber *)accelerometerCount;

/**
 *  Invoked when a beacon's moving state changes.
 *
 *  @param beacon   The beacon providing this information.
 *  @param isMoving New moving state.
 */
- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateMovingState:(NSNumber *)isMoving;

@end

/// Constants

/**
 *  the Key for the Transmit Power in base setting dictionary.
 */
extern NSString * const SBKBeaconBaseSettingsTransmitPowerKey;
/**
 *  the Key for the Advertising Interval in base setting dictionary.
 */
extern NSString * const SBKBeaconBaseSettingsAdvertisingIntervalKey;
/**
 *  the Key for the Energy Saving Mode in base setting dictionary.
 */
extern NSString * const SBKBeaconBaseSettingsEnergySavingModeKey;
/**
 *  the Key for the Measure Power in base setting dictionary.
 */
extern NSString * const SBKBeaconBaseSettingsMeasuredPowerKey;

/**
 *  the Key for the Temperature Sampling Interval in sensoro setting dictionary.
 */
extern NSString * const SBKBeaconSensorSettingsTemperatureSamplingIntervalKey;
/**
 *  the Key for the Light Sampling Interval in sensoro setting dictionary.
 */
extern NSString * const SBKBeaconSensorSettingsLightSamplingIntervalKey;
/**
 *  the Key for the Accelerometer Sensitivity in sensoro setting dictionary.
 */
extern NSString * const SBKBeaconSensorSettingsAccelerometerSensitivityKey;
