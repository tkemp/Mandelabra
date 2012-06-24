//
//  TKPalette.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 10/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TKPalette : NSObject {
	NSArray* palette;
	NSColor* memberColor;
	NSGradient* gradient;
}
@property(readwrite, assign) NSArray* palette;
@property(readonly) int count;
@property(readwrite, assign) NSColor* memberColor;
@property(readwrite, assign) NSGradient* gradient;

- (id) initWithColors:(int) count gradient:(NSGradient *) aGradient;
- (id) initWithColors:(int) count;
- (NSColor*) colorAtReal:(NSNumber *) aReal;

+ (NSGradient *) makeDefaultGradient;

@end
