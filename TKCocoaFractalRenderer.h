//
//  TKFractalRenderer.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKFractalData.h"
#import "TK2DMutableArray.h"
#import "TKPalette.h"
#import "TKIFractalRenderer.h"
#import "TKFractalWindowController.h"
#import "complex_math.h"
#import "Constants.h"

@interface TKCocoaFractalRenderer : NSObject <TKIFractalRenderer> {
	NSImageRep* fractalRepresentation;
	NSImageRep* orbitRepresentation;
	int colorDepth;
	int channels;
	TKPalette* palette;
	NSData* data;
}
@property(readwrite, assign) NSImageRep* fractalRepresentation;
@property(readwrite, assign) NSImageRep* orbitRepresentation;
@property(readwrite, assign) int colorDepth;
@property(readwrite, assign) int channels;
@property(readwrite, assign) TKPalette* palette;
@property(readwrite, assign) NSData* data;

- (id) initWithSize:(NSSize) data palette:(TKPalette *) pal;
- (void) plotPoint:(TKFractalPoint *) point;
- (void) plotOrbit:(TKFractalPoint *) point controller:(TKFractalWindowController *) controller;

@end
