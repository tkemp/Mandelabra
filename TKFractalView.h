//
//  FractalView.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "complex_math.h"
#import "TKFractalPoint.h"
#import "TKIFractalRenderer.h"
#import "TKPalette.h"
@class TKFractalWindowController;

@interface TKFractalView : NSView {
	//NSImageRep *fractalRepresentation;
	//NSImageRep *orbitRepresentation;
	NSPoint dragStart, dragStop;
	NSRect zoomRect;
	NSTrackingArea* trackingArea;
	IBOutlet TKFractalWindowController* controller;
	factor scale;
	id<TKIFractalRenderer> renderer;
}
@property(readwrite, assign) factor scale;
@property(readwrite, assign) id<TKIFractalRenderer> renderer;
@property(readwrite, assign) NSImageRep* fractalRepresentation;
@property(readwrite, assign) NSImageRep* orbitRepresentation;

- (void) plotPoint:(TKFractalPoint *) fp;
- (void) plotOrbit:(TKFractalPoint *) fp;
- (NSRect) rectBetweenStart:(NSPoint)startPoint current:(NSPoint)curPoint;
- (NSString*) description;
- (void) setScaleForMin:(cplx) aMin max:(cplx) aMax;
- (void) setPalette:(TKPalette *) palette;

@end