//
//  MasterViewController.h
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EventsJSONParser.h"

@interface MasterViewController : NSViewController

@property NSArray *_eventGroups;

@property EventsJSONParser *_ejp;
@property NSInteger _selectedWorldId;

@property IBOutlet NSTableView *_statusTable;

-(void) updateEvents;
-(void) sortEvents;

@end
