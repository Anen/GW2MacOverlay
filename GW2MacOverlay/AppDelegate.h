//
//  AppDelegate.h
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property NSMenuItem *_currentMode;
@property NSMenuItem *_currentWorld;
@property NSMenuItem *_currentContinent;
@property NSMenuItem *_currentEvent;

// Serial
@property NSInteger _serialMode;
@property NSInteger _serialWorld;

@property NSArray *_worldNamesEU;
@property NSArray *_worldNamesNA;
@property NSArray *_eventGroups;

@property (assign) IBOutlet NSWindow *window;

-(void)writeToFile;
-(void)readFromFile;

-(void)initData;
-(void)updateData:(NSTimer*)theTimer;
-(void)createMenu;

-(IBAction)setMode:(id)sender;
-(IBAction)setWorld:(id)sender;
-(IBAction)setContinent:(id)sender;
-(IBAction)setEvent:(id)sender;

@end
