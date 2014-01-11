//
//  Event.h
//  GW2MacOverlay
//
//  Created by Bastien on 8/19/13.
//  Copyright (c) 2013 Bastien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property NSString *_id;
@property NSString *_name;
@property NSString *_status;

- (void) print;
- (Event*) initWithId:(NSString*)id andName:(NSString *)name;

@end
