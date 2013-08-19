//
//  AppDelegate.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "Event.h"

@interface  AppDelegate()
@property (nonatomic,strong) IBOutlet MasterViewController *masterViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    /*NSAlert *alert = [[NSAlert alloc] init];
     [alert setAlertStyle:NSInformationalAlertStyle];
     [alert setMessageText:@"Gesture Notification"];
     [alert setInformativeText:@"YOUHOU"];
     [alert runModal];
     */
    
    // 1. Create the master View Controller
    self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    
    // 2. Add the view controller to the Window's content view
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
    
    // Update the view
    [self.masterViewController createGUI];
    
    // Always on top + opacity
    [self.window setLevel:CGShieldingWindowLevel() + 1];
    [self.window setAlphaValue:0.95f];
    
    //[self.window setStyleMask:NSTexturedBackgroundWindowMask];
    
    // Since the timer is passed as an argument when you specify its method as a selector,
    // you can invalidate a repeating timer when appropriate within that method.
    [NSTimer scheduledTimerWithTimeInterval:10.0f
                                     target:self
                                   selector: @selector(updateData:)
                                   userInfo:self.masterViewController
                                    repeats:YES];
}


-(void) updateData:(NSTimer*)theTimer{
    NSLog(@"Timer");
    
    MasterViewController *mvc = [theTimer userInfo];
    [mvc updateEvents];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

@end