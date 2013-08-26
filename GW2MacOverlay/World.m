//
//  World.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "World.h"

@implementation World

@synthesize _id;
@synthesize _name; // Generates getter and setter

-(void) print{
    NSLog(@"World %ld is %@\n", _id, _name );
}

-(World*) initWithId:(NSInteger)id andName:(NSString *)name{
    self = [super init];
    
    if ( self ) {
        self._id = id;
        self._name = name;
    }
    return self;
}

@end
