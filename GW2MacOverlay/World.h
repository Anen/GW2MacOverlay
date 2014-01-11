//
//  World.h
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface World : NSObject

@property NSInteger _id;
@property NSString *_name;
@property BOOL _eventActive;

- (void) print;
- (World*) initWithId:(NSInteger)id andName:(NSString*)name;

@end