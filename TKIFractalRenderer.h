//
//  TKIFractalRenderer.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKFractalPoint.h"
#import "TKPalette.h"
@class TKFractalWindowController;

@protocol TKIFractalRenderer
@property(readwrite, assign) NSImageRep* fractalRepresentation;
@property(readwrite, assign) NSImageRep* orbitRepresentation;

- (id) initWithSize:(NSSize) size palette:(TKPalette *) pal;
- (void) plotPoint:(TKFractalPoint *) fp;
- (void) plotOrbit:(TKFractalPoint *) fp controller:(TKFractalWindowController *) controller;

@end
