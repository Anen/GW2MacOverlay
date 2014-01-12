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

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andEventGroup:(NSArray *)evgArray{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Events Parser
        self._ejp = [EventsJSONParser alloc];
        
        // EventGroup
        self._eventGroups = evgArray;
        
        // EventGroupToDisplay
        self._eventGroupsToDisplay = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) updateMasterView{
    
    // Update display from preference
    [self._eventGroupsToDisplay removeAllObjects];
    for (EventGroup *evg in self._eventGroups) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:evg._name]) {
            [self._eventGroupsToDisplay addObject:evg];
        }
    }
    
    // Update parser
    [self._ejp updateByWorld:[[NSUserDefaults standardUserDefaults] integerForKey:@"idWorld"] andEventGroups:self._eventGroupsToDisplay];
    
    // Sort events
    NSSortDescriptor *sortActive = [NSSortDescriptor sortDescriptorWithKey:@"_isActive" ascending:NO selector:@selector(compare:)];
    NSSortDescriptor *sortName = [NSSortDescriptor sortDescriptorWithKey:@"_name" ascending:YES selector:@selector(compare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortActive, sortName, nil];
    [self._eventGroupsToDisplay sortUsingDescriptors:sortDescriptors];
    
    // Reload view
    [self._statusTable reloadData];
}

/*********/
/* TABLE */
/*********/

- (void) awakeFromNib {
    //NSLog(@"awakeFromNib");
    [self._statusTable setAction:@selector(doClick:)];
    [self._statusTable setTarget:self];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    [tableView setBackgroundColor:[NSUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"backgroundColor"]]];
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    // Get EventGroup
    EventGroup *eg = [self._eventGroupsToDisplay objectAtIndex:row];
    
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
            [cellView.textField setTextColor:[NSUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"activeColor"]]];
        } else {
            [cellView.textField setTextColor:[NSUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"inactiveColor"]]];
        }
        cellView.textField.stringValue = eg._name;
        return cellView;
    }
    
    return cellView;
}

- (IBAction) doClick:(NSTableView*)sender {
    NSInteger clickedRow = [sender clickedRow];
    NSLog(@"Click %ld", (long)clickedRow );
    
    if (clickedRow >= 0) { // Click on header returns -1
        // Get EventGroup
        EventGroup *eg = [self._eventGroupsToDisplay objectAtIndex:clickedRow];
        
        NSInteger mode = [[NSUserDefaults standardUserDefaults] integerForKey:@"mode"];
        
        if (mode == 1 || mode == 2) {
            
            NSMutableString* cmd = [NSMutableString new];
            [cmd appendString:@"tell application \"System Events\" to keystroke return\n"];
            [cmd appendString:@"delay 0.1\n"];
            
            if (mode == 1) {
                [cmd appendString:@"tell application \"System Events\" to keystroke \"/g "];
            } else if (mode == 2) {
                [cmd appendString:@"tell application \"System Events\" to keystroke \"/s "];
            }
            
            [cmd appendString:eg._name];
            [cmd appendString:@" "];
            [cmd appendString:eg._waypoint];
            [cmd appendString:@"\" & return\n"];
            
            NSAppleScript* script = [[NSAppleScript alloc] initWithSource:cmd];
            NSDictionary* err = nil;
            /*NSAppleEventDescriptor *result = */[script executeAndReturnError:&err];
        } else if (mode == 3) {
            NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
            [pasteboard clearContents];
            NSArray *objectsToCopy = [NSArray arrayWithObjects:eg._name, @" ", eg._waypoint, nil];
            [pasteboard writeObjects:objectsToCopy];
            
            NSLog(@"PASTED");
        }
    }
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
    return [self._eventGroupsToDisplay count];
}

@end

