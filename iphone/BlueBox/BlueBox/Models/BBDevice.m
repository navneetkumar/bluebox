//
//  BBDevice.m
//  BlueBox
//
//  Created by Vasu Narayan on 10/09/14.
//  Copyright (c) 2014 BlueJeans. All rights reserved.
//

#import "BBDevice.h"

@implementation BBDevice

- (instancetype)initWithNetService:(NSNetService *)netService
{
    self = [super init];
    
    if (self) {
        self.name = netService.name;        
    }
    
    return self;
}

@end
