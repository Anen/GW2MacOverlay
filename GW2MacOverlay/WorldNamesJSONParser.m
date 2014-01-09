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

- (WorldNamesJSONParser*) initFromURL{
    
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
                NSMutableArray *worldEU = [[NSMutableArray alloc] init];
                NSMutableArray *worldNA = [[NSMutableArray alloc] init];
                
                // Fill
                for(NSDictionary *item in worldNamesJSON) {
                    
                    NSInteger tmpId = [[item objectForKey:@"id"] integerValue];
                    NSString *tmpName = [NSString stringWithFormat:@"%@", [item objectForKey:@"name"]];
                    
                    World *tmpWorld = [[World alloc] initWithId:tmpId andName: tmpName];
                    
                    if (tmpId/1000 == 1) {
                        [worldNA addObject:tmpWorld];
                    }else{
                        [worldEU addObject:tmpWorld];
                    }
                }
                
                // Sort
                NSSortDescriptor *sortName = [NSSortDescriptor sortDescriptorWithKey:@"_name" ascending:YES selector:@selector(compare:)];
                NSArray *sortDescriptors = [NSArray arrayWithObject:sortName];
                self._worldNamesEU = [[NSArray alloc] init];
                self._worldNamesNA = [[NSArray alloc] init];
                self._worldNamesEU = [worldEU sortedArrayUsingDescriptors:sortDescriptors];
                self._worldNamesNA = [worldNA sortedArrayUsingDescriptors:sortDescriptors];
            }
            
        } else {
            NSLog(@"Error connecting to world_names API");
        }
    }
    
    return self;
}


@end

