//
//  AppDelegate.h
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

// Menu
@property NSMenuItem *_currentWorld;
@property NSMenuItem *_currentContinent;
@property NSMenuItem *_currentEvent;

// Data
@property NSArray *_worldNamesEU;
@property NSArray *_worldNamesNA;
@property NSArray *_eventGroups;

// Main window
@property (assign) IBOutlet NSWindow *window;
@property IBOutlet NSTextField *_connectTextField;

// Preference window
@property (assign) IBOutlet NSWindow *prefWindow;
@property IBOutlet NSColorWell *_activeColorWell;
@property IBOutlet NSColorWell *_inactiveColorWell;
@property IBOutlet NSColorWell *_backgroundColorWell;
@property IBOutlet NSColorWell *_borderColorWell;
@property IBOutlet NSButton *_resetColors;

@property IBOutlet NSTextField *_opacityTextField;
@property IBOutlet NSStepper *_opacityStepper;
@property IBOutlet NSMatrix *_waypointRadio;
@property IBOutlet NSMatrix *_soundRadio;


@property NSArray *_eventButtons;
@property IBOutlet NSButton *_dredge;
@property IBOutlet NSButton *_eye;
@property IBOutlet NSButton *_felemental;
@property IBOutlet NSButton *_fshaman;
@property IBOutlet NSButton *_fmaw;
@property IBOutlet NSButton *_foulbear;
@property IBOutlet NSButton *_golem;
@property IBOutlet NSButton *_gjunglewurm;
@property IBOutlet NSButton *_karkaqueen;
@property IBOutlet NSButton *_megadestroyer;
@property IBOutlet NSButton *_sbehemot;
@property IBOutlet NSButton *_taidha;
@property IBOutlet NSButton *_ulgoth;
@property IBOutlet NSButton *_balthazar;
@property IBOutlet NSButton *_dwayna;
@property IBOutlet NSButton *_grenth;
@property IBOutlet NSButton *_lyssa;
@property IBOutlet NSButton *_melandru;
@property IBOutlet NSButton *_jormag;
@property IBOutlet NSButton *_shatterer;
@property IBOutlet NSButton *_tequalt;

@property IBOutlet NSButton *_checkAll;
@property IBOutlet NSButton *_uncheckAll;

// METHODS
- (void) createUserDefaults;
- (void) initData;
- (void) updateData:(NSTimer*)theTimer;
- (void) reloadTable;
- (void) createMenu;

- (IBAction) setMode:(NSMenuItem*)sender;
- (IBAction) setWorld:(NSMenuItem*)sender;
- (IBAction) setContinent:(NSMenuItem*)sender;
- (IBAction) setEvent:(NSMenuItem*)sender;

- (void) createPreferences;
- (IBAction) setActiveColor:(NSColorWell*)sender;
- (IBAction) setInactiveColor:(NSColorWell*)sender;
- (IBAction) setTheBackgroundColor:(NSColorWell*)sender;
- (IBAction) setBorderColor:(NSColorWell*)sender;
- (IBAction) resetColors:(NSButton*)sender;

- (IBAction) setOpacityField:(NSTextField*)sender;
- (IBAction) changeStepper:(NSStepper*)sender;
- (IBAction) setSound:(NSButton*)sender;

- (IBAction) toggleBoss:(NSButton*)sender;
- (IBAction) checkAll:(NSButton*)sender;
- (IBAction) uncheckAll:(NSButton*)sender;

@end
