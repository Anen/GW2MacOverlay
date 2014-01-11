//
//  EventViewController.h
//  GW2MacOverlay
//
//  Created by Bastien on 9/1/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EventGroup.h"
#import "EventsJSONParser.h"

@interface EventViewController : NSViewController

// Data
@property EventsJSONParser *_ejp;
@property NSArray *_listOfWorlds;
@property NSMutableSet *_activeWorlds;

// Menu
@property EventGroup *_egToDisplay;

@property IBOutlet NSTableView *_statusTable;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andListOfWorlds:(NSArray*)listW;
- (void) updateEventView;

@end
