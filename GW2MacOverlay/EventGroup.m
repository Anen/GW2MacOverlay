//
//  EventGroup.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "EventGroup.h"

@implementation EventGroup

-(void) printSummary{
    NSLog(@"Event group: %@. Size: %ld. IsActive: %hhd.", self._name, [self._listOfEvents count], self._isActive);
}

-(void) printDetails{
    [self printSummary];
    for(Event *e in self._listOfEvents){
        [e print];
    }
}

-(EventGroup*) initWithName:(NSString *)name andWaypoint:(NSString*)waypoint andObjects:(Event *)firstEvent, ...{
    
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

-(void) updateActive{
    BOOL n = NO;
    
    for(Event *e in self._listOfEvents){
        if([e._status isEqualToString:@"Active"]){
            n = YES;
        }
    }
    
    self._isActive = n;
}

@end
