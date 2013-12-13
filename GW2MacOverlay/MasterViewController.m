//
//  MasterViewController.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "MasterViewController.h"
#import "EventGroup.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andEventGroup:(NSArray *)evg{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Events Parser
        self._ejp = [EventsJSONParser alloc];
        
        // EventGroup
        self._eventGroups = evg;
    }
    
    return self;
}

- (void)updateMasterView{
    // Update events
    [self._ejp updateByWorld:self._selectedWorldId andEventGroups:self._eventGroups];
    
    // Sort events
    NSSortDescriptor *sortActive = [NSSortDescriptor sortDescriptorWithKey:@"_isActive" ascending:NO selector:@selector(compare:)];
    NSSortDescriptor *sortName = [NSSortDescriptor sortDescriptorWithKey:@"_name" ascending:YES selector:@selector(compare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortActive, sortName, nil];
    self._eventGroups = [self._eventGroups sortedArrayUsingDescriptors:sortDescriptors];
    
    // Reload view
    [self._statusTable reloadData];
}


/*********/
/* TABLE */
/*********/

-(void) awakeFromNib {
    //NSLog(@"awakeFromNib");
    [self._statusTable setAction:@selector(doClick:)];
    [self._statusTable setTarget:self];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    [tableView setBackgroundColor:[NSColor lightGrayColor]];
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    // Get EventGroup
    EventGroup *eg = [self._eventGroups objectAtIndex:row];
    
    //Multicolumn
    /*if ([tableColumn.identifier isEqualToString:@"checkColumn"]) {
        if (self._isDingDong) {
            [tableColumn setHidden:NO];
            NSLog(@"!Hide");
        } else {
            [tableColumn setHidden:YES];
        }
        
        return cellView;
    }*/
    
    if ([tableColumn.identifier isEqualToString:@"eventColumn"]) {
        if (eg._isActive) {
            [cellView.textField setTextColor:[NSColor blackColor]];
        } else {
            [cellView.textField setTextColor:[NSColor whiteColor]];
        }
        cellView.textField.stringValue = eg._name;
        return cellView;
    }
    
    return cellView;
}

- (void)doClick:(id)sender {
    NSInteger clickedRow = [sender clickedRow];
    NSLog(@"Click %ld", (long)clickedRow );
    
    if (clickedRow >= 0 && self._linkWaypoint != 0) { // Click on header returns -1
        
        // Get EventGroup
        EventGroup *eg = [self._eventGroups objectAtIndex:clickedRow];
        
        NSMutableString* cmd = [NSMutableString new];
        [cmd appendString:@"tell application \"System Events\" to keystroke return\n"];
        [cmd appendString:@"delay 0.1\n"];
        
        if (self._linkWaypoint == 1) {
            [cmd appendString:@"tell application \"System Events\" to keystroke \"/g "];
        } else if (self._linkWaypoint == 2) {
            [cmd appendString:@"tell application \"System Events\" to keystroke \"/s "];
        }
        
        [cmd appendString:eg._name];
        [cmd appendString:@" "];
        [cmd appendString:eg._waypoint];
        [cmd appendString:@"\" & return\n"];

        NSAppleScript* script = [[NSAppleScript alloc] initWithSource:cmd];
        NSDictionary* err = nil;
        NSAppleEventDescriptor *result = [script executeAndReturnError:&err];
    }
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self._eventGroups count];
}

@end

