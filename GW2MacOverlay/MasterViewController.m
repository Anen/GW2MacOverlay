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
        
        // Ding Dong
        self._isDingDong = NO;
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
        cellView.textField.stringValue = eg._name;
        return cellView;
    }
    
    if ([tableColumn.identifier isEqualToString:@"statusColumn"]) {
        NSFont* boldFont = [NSFont boldSystemFontOfSize:[NSFont systemFontSize]];
        [cellView.textField setFont:boldFont];
        if (eg._isActive) {
            cellView.textField.stringValue = @"Active";
        } else {
            cellView.textField.stringValue = @"--";
        }
        return cellView;
    }
    
    return cellView;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self._eventGroups count];
}

@end

