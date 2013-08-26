//
//  AppDelegate.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "World.h"
#import "WorldNamesJSONParser.h"

@interface  AppDelegate()
@property (nonatomic,strong) IBOutlet MasterViewController *masterViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    
    // VIEW
    self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
    
    // WINDOW
    // Always on top + opacity
    [self.window setLevel:CGShieldingWindowLevel() + 1];
    [self.window setAlphaValue:0.95f];
    
    // DATA
    WorldNamesJSONParser *wnjp = [[WorldNamesJSONParser alloc] initFromURL];
    NSArray *worldNamesEU = wnjp._worldNamesEU;
    NSArray *worldNamesNA = wnjp._worldNamesNA;
    
    // MENU
    NSMenu *EUWorldMenu = [[NSMenu alloc] initWithTitle:@"EU Worlds"];
    NSMenu *NAWorldMenu = [[NSMenu alloc] initWithTitle:@"NA Worlds"];
    
    for(World *w in worldNamesEU){
        NSMenuItem *tmpItem = [[NSMenuItem alloc] initWithTitle:w._name action:@selector(setWorld:) keyEquivalent:@""];
        [tmpItem setTag:w._id];
        [EUWorldMenu addItem:tmpItem];
    }
    
    for(World *w in worldNamesNA){
        NSMenuItem *tmpItem = [[NSMenuItem alloc] initWithTitle:w._name action:@selector(setWorld:) keyEquivalent:@""];
        [tmpItem setTag:w._id];
        [NAWorldMenu addItem:tmpItem];
    }
 
    NSMenuItem *EUMenuItem = [[NSMenuItem alloc] init];
    [EUMenuItem setSubmenu: EUWorldMenu]; 
    [[NSApp mainMenu] addItem: EUMenuItem];
    
    NSMenuItem *NAMenuItem = [[NSMenuItem alloc] init];
    [NAMenuItem setSubmenu: NAWorldMenu];
    [[NSApp mainMenu] addItem: NAMenuItem];
    
    // TIMER
    [NSTimer scheduledTimerWithTimeInterval:10.0f
                                     target:self
                                   selector: @selector(updateData:)
                                   userInfo:NULL
                                    repeats:YES];
}


-(void) updateData:(NSTimer*)theTimer{
    NSLog(@"Timer");
    if(self.masterViewController._selectedWorldId){
        [self.masterViewController updateEvents];
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

/**********/
/* WORLDS */
/**********/

-(IBAction)setWorld:(id)sender{
    // Disable previous
    [self._currentWorld setState:NSOffState];
    
    // Enable current
    self._currentWorld = sender;
    [self._currentWorld setState:NSOnState];
    [self.window setTitle:[self._currentWorld title]];
    
    // Update UI
    self.masterViewController._selectedWorldId = [self._currentWorld tag];
    [self.masterViewController updateEvents];
}

@end