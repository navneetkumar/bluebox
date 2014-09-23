//
//  BBDevice.h
//  BlueBox
//
//  Created by Vasu Narayan on 10/09/14.
//  Copyright (c) 2014 BlueJeans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBDevice : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) NSInteger portNumber;

- (instancetype)initWithNetService:(NSNetService *)netService;

@end
