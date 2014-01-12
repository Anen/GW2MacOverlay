//
//  EventGroup.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "EventGroup.h"

@implementation EventGroup

- (void) printSummary{
    NSLog(@"Event group: %@. Size: %ld. IsActive: %hhd.", self._name, [self._listOfEvents count], self._isActive);
}

- (void) printDetails{
    [self printSummary];
    for(Event *e in self._listOfEvents){
        [e print];
    }
}

- (EventGroup*) initWithName:(NSString *)name andWaypoint:(NSString*)waypoint andObjects:(Event *)firstEvent, ...{
    
    self = [super init];
    
    if (self) {
        self._name = name;
        self._waypoint = waypoint;
        
        self._listOfEvents = [[NSMutableArray alloc] init];
        va_list args;
        va_start(args, firstEvent);
        for (Event *arg = firstEvent; arg != nil; arg = va_arg(args, Event*)){
            [self._listOfEvents addObject:arg];
        }
        va_end(args);
        
        [self updateActive];
    }
    
    return self;
}

- (void) updateActive{
    BOOL active = false;
    
    // Update activity from listOfEvents
    for(Event *e in self._listOfEvents){
        if([e._status isEqualToString:@"Active"]){
            active = true;
        }
    }
    
    // Play sound when inactive to active
    if (!self._isActive && active) {
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"sound"] == 1 ) {
            NSLog(@"Playing sound for %@", self._name);
            NSBeep();
        } else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"sound"] == 2 ) {
            NSLog(@"Playing speech for %@", self._name);
            //NSBeep();
        }
    }
    
    
    self._isActive = active;
}

@end
