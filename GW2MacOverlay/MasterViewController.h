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

@property BOOL _isDingDong;
@property NSInteger _selectedWorldId;
@property EventsJSONParser *_ejp;

@property NSArray *_eventGroups;

@property IBOutlet NSTableView *_statusTable;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andEventGroup:(NSArray *)evg;
- (void)updateMasterView;

@end
