//
//  EventsJSONParser.h
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventsJSONParser : NSObject

-(void) updateFromURL:(NSInteger)worldId andEventGroups:(NSArray*)eventGroups;

@end
