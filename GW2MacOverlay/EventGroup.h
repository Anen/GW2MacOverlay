//
//  EventGroup.h
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface EventGroup : NSObject

@property NSString *_name;
@property BOOL _isActive;
@property NSMutableArray *_listOfEvents;

-(void) printSummary;
-(void) printDetails;
-(EventGroup*) initWithName: (NSString*)name andObjects:(Event*)firstEvent, ... NS_REQUIRES_NIL_TERMINATION;
-(void) updateActive;

@end