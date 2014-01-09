//
//  EventViewController.m
//  GW2MacOverlay
//
//  Created by Bastien on 9/1/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "EventViewController.h"
#import "World.h"
#import "EventsJSONParser.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andListOfWorlds:(NSArray*)listW {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Events Parser
        self._ejp = [EventsJSONParser alloc];
        
        // Worlds list
        self._listOfWorlds = [[NSArray alloc] initWithArray:listW]; // copy because we are going to reorder it
    }
    
    return self;
}

- (void)updateEventView{
    // Set doesn't allow duplicates
    NSMutableSet *finalList = [[NSMutableSet alloc] init];
    
    // Retrive data from API
    for (Event *ev in self._egToDisplay._listOfEvents) {
        for (NSString *world in [self._ejp updateByEvent:ev._id]){
            [finalList addObject:world]; // Set in action here
        }
    }
    
    // Update local array
    for (World *w in self._listOfWorlds) {
        if ([finalList containsObject:[NSNumber numberWithInteger:w._id]]) {
            [w set_eventActive:YES];
        } else {
            [w set_eventActive:NO];
        }
    }
    
    // Sort worlds
    NSSortDescriptor *sortActive = [NSSortDescriptor sortDescriptorWithKey:@"_eventActive" ascending:NO selector:@selector(compare:)];
    NSSortDescriptor *sortName = [NSSortDescriptor sortDescriptorWithKey:@"_name" ascending:YES selector:@selector(compare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortActive, sortName, nil];
    self._listOfWorlds = [self._listOfWorlds sortedArrayUsingDescriptors:sortDescriptors];
    
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
    
    // Get World
    World *w = [self._listOfWorlds objectAtIndex:row];
    
    //Multicolumn
    if ([tableColumn.identifier isEqualToString:@"worldColumn"]) {
        if (w._eventActive) {
            [cellView.textField setTextColor:self._activeColor];
        } else {
            [cellView.textField setTextColor:self._inactiveColor];
        }
        cellView.textField.stringValue = w._name;
        return cellView;
    }
    
    return cellView;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self._listOfWorlds count];
}

@end
