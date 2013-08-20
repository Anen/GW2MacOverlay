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
@property NSArray *_worldNames;

@property EventsJSONParser *_ejp;
@property NSInteger _selectedWorldId;

@property IBOutlet NSPopUpButton *_worldSelection;
@property IBOutlet NSTableView *_statusTable;

-(IBAction)worldSelected:(id)sender;

-(void) createGUI;
-(void) updateEvents;

@end
