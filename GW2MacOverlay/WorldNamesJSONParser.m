//
//  WorldNamesJSONParser.m
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import "WorldNamesJSONParser.h"
#import "World.h"

@implementation WorldNamesJSONParser

@synthesize _worldNames;

-(WorldNamesJSONParser*) initFromURL{
    
    self = [super init];
    
    if (self) {
        
        NSURL *worldNamesURL = [NSURL URLWithString:@"https://api.guildwars2.com/v1/world_names.json"];
        NSData *worldNamesData = [[NSData alloc] initWithContentsOfURL:worldNamesURL];
        
        if (worldNamesData) {
            NSError *error = nil;
            NSArray *worldNamesJSON = [NSJSONSerialization JSONObjectWithData:worldNamesData options:0 error:&error];
            
            if (error) {
                NSLog(@"Error parsing JSON: %@", error);
            } else {
                self._worldNames = [[NSMutableArray alloc] init];
                
                for(NSDictionary *item in worldNamesJSON) {
                    
                    NSInteger tmpId = [[item objectForKey:@"id"] integerValue];
                    NSString *tmpName;
                    
                    if (tmpId/1000==1) {
                        tmpName = [NSString stringWithFormat:@"NA - %@",[item objectForKey:@"name"]];
                    }else{
                        tmpName = [NSString stringWithFormat:@"EU - %@",[item objectForKey:@"name"]];
                    }
                    
                    World *tmpWorld = [[World alloc] initWithId:tmpId andName: tmpName];
                    [self._worldNames addObject:tmpWorld];
                    
                }
            }
            
        } else {
            NSLog(@"Error connecting to world_names API");
        }
    }
    
    return self;
}


@end

