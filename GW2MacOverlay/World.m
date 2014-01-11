//
//  World.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "World.h"

@implementation World

- (void) print{
    NSLog(@"World %ld is %@\n", self._id, self._name );
}

- (World*) initWithId:(NSInteger)id andName:(NSString *)name{
    self = [super init];
    
    if ( self ) {
        self._id = id;
        self._name = name;
    }
    return self;
}

@end
