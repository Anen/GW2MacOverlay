//
//  Event.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "Event.h"

@implementation Event

- (void) print{
    NSLog(@"Event %@ is %@. %@\n", self._id, self._name, self._status );
}

- (Event*) initWithId:(NSString*)id andName:(NSString *)name{
    self = [super init];
    
    if ( self ) {
        self._id = id;
        self._name = name;
        self._status = @"N/A";
    }
    return self;
}

@end

