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
@property NSMenuItem *_currentMode;
@property NSMenuItem *_currentWorld;
@property NSMenuItem *_currentContinent;
@property NSMenuItem *_currentEvent;

// Serial
@property NSInteger _serialMode;
@property NSInteger _serialWorld;
@property NSInteger _serialContinent;
@property NSString *_serialPath;
@property BOOL _soundIsActive;

// Data
@property NSArray *_worldNamesEU;
@property NSArray *_worldNamesNA;
@property NSArray *_eventGroups;

// Main window
@property (assign) IBOutlet NSWindow *window;
@property IBOutlet NSTextField *_connectTextField;

// Preference window
@property (assign) IBOutlet NSWindow *prefWindow;
@property IBOutlet NSColorWell *_activeColor;
@property IBOutlet NSColorWell *_inactiveColor;
@property IBOutlet NSColorWell *_backgroundColor;
@property IBOutlet NSColorWell *_borderColor;
@property IBOutlet NSButton *_resetColors;

@property IBOutlet NSTextField *_opacityTextField;
@property IBOutlet NSSlider *_opacitySlider;
@property IBOutlet NSButton *_playSound;

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

- (void) writeToFile;
- (void) readFromFile;

- (void) initData;
- (void) updateData:(NSTimer*)theTimer;
- (void) reloadTable;
- (void) createMenu;

- (IBAction) setMode:(id)sender;
- (IBAction) setWorld:(id)sender;
- (IBAction) setContinent:(id)sender;
- (IBAction) setEvent:(id)sender;

- (void) createPreferences;
- (IBAction) setActiveColor:(id)sender;
- (IBAction) setInactiveColor:(id)sender;
- (IBAction) setTheBackgroundColor:(id)sender;
- (IBAction) setBorderColor:(id)sender;
- (IBAction) resetColors:(NSButton*)sender;

- (IBAction) setOpacityField:(id)sender;
- (IBAction) setOpacitySlider:(NSSlider*)sender;
- (IBAction) toggleSound:(NSButton*)sender;

- (IBAction) toggleBoss:(NSButton*)sender;
- (IBAction) checkAll:(NSButton*)sender;
- (IBAction) uncheckAll:(NSButton*)sender;

@end
