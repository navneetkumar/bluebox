//
//  BBDeviceCommunicator.m
//  BlueBox
//
//  Created by Vasu Narayan on 11/09/14.
//  Copyright (c) 2014 BlueJeans. All rights reserved.
//

#import "BBDeviceCommunicator.h"
#import <AFJSONRPCClient/AFJSONRPCClient.h>
#include <arpa/inet.h>

@interface BBDeviceCommunicator ()

@property (nonatomic, strong) AFJSONRPCClient *jsonClient;

@end


@implementation BBDeviceCommunicator

+ (instancetype)sharedService
{
    static BBDeviceCommunicator *sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[BBDeviceCommunicator alloc] init];
    });
    
    return sharedService;
}

- (void)sendName:(NSString *)name onCompletion:(void (^)(BOOL success, NSError *error))completionBlock {
    [self.jsonClient invokeMethod:@"echo" withParameters:@[name] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"****** sendName Success = %@", responseObject);
        completionBlock(YES, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"****** sendName Failed = %@", error);
        completionBlock(NO, nil);
    }];
}

- (void)callToMeeting:(NSString *)meetingID onCompletion:(void (^)(BOOL success, NSError *error))completionBlock
{
    [self.jsonClient invokeMethod:@"call" withParameters:@[meetingID] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"****** callToMeeting Success = %@", responseObject);
        completionBlock(YES, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"****** callToMeeting Failure = %@", error);
        completionBlock(NO, error);
    }];
}

- (void)hangUp:(void (^)(BOOL success, NSError *error))completionBlock
{
    [self.jsonClient invokeMethod:@"stop" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"****** Hangup success = %@", responseObject);
        completionBlock(YES, nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"****** Hangup error = %@", error);
        completionBlock(NO, error);
    }];
}

- (void)playVideo:(void (^)(BOOL success, NSError *error))completionBlock
{
    [self.jsonClient invokeMethod:@"playvideo" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"****** playVideo success = %@", responseObject);
        completionBlock(YES, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"****** playVideo error = %@", error);
        completionBlock(NO, error);
    }];
}

- (void)stopVideo:(void (^)(BOOL success, NSError *error))completionBlock
{
    [self.jsonClient invokeMethod:@"stopvideo" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"****** playVideo success = %@", responseObject);
        completionBlock(YES, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"****** playVideo error = %@", error);
        completionBlock(NO, error);
    }];
}

- (AFJSONRPCClient *)jsonClient {
    if (!_jsonClient) {
        if (self.currentDevice.addresses.count > 0) {
            NSString *address = [self getStringFromAddressData:[self.currentDevice.addresses objectAtIndex:0]];
            NSString *endpointString = [NSString stringWithFormat:@"http://%@:%ld/jsonrpc", address, (long)self.currentDevice.port];
            NSLog(@"******* endpointString = %@", endpointString);
            
            _jsonClient = [[AFJSONRPCClient alloc] initWithEndpointURL:[NSURL URLWithString:endpointString]];
        }
    }
    
    return _jsonClient;
}

#pragma mark - Helper Methods -

- (NSString *)getStringFromAddressData:(NSData *)dataIn {
    struct sockaddr_in  *socketAddress = nil;
    NSString            *ipString = nil;
    
    socketAddress = (struct sockaddr_in *)[dataIn bytes];
    ipString = [NSString stringWithFormat: @"%s",
                inet_ntoa(socketAddress->sin_addr)];  ///problem here
    return ipString;
}

@end
