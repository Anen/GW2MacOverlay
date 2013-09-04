//
//  EventsJSONParser.h
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventGroup.h"

@interface EventsJSONParser : NSObject

- (void)updateByWorld:(NSInteger)worldId andEventGroups:(NSArray*)eventGroups;
- (NSMutableArray*)updateByEvent:(NSString*)eventId;


@end
