//
//  BBDeviceCommunicator.h
//  BlueBox
//
//  Created by Vasu Narayan on 11/09/14.
//  Copyright (c) 2014 BlueJeans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBDeviceCommunicator : NSObject

@property (nonatomic, strong) NSNetService *currentDevice;

+ (instancetype)sharedService;

- (void)sendName:(NSString *)name onCompletion:(void (^)(BOOL success, NSError *error))completionBlock;

- (void)callToMeeting:(NSString *)meetingID onCompletion:(void (^)(BOOL success, NSError *error))completionBlock;
- (void)hangUp:(void (^)(BOOL success, NSError *error))completionBlock;
- (void)playVideo:(void (^)(BOOL success, NSError *error))completionBlock;
- (void)stopVideo:(void (^)(BOOL success, NSError *error))completionBlock;

@end
