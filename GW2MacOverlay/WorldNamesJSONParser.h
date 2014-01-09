//
//  WorldNamesJSONParser.h
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorldNamesJSONParser : NSObject

@property NSArray *_worldNamesEU;
@property NSArray *_worldNamesNA;

- (WorldNamesJSONParser*) initFromURL;

@end

