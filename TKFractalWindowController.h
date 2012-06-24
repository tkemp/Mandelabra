//
//  TKFractalWindowController.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 06/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKFractalView.h"
#import "TKFractalDocument.h"
#import "complex_math.h"
#import "Constants.h"
#import "TKFractalParameters.h"
#import "TKFractalPoint.h"
#import "TKFractalData.h"
#import "TKCocoaFractalRenderer.h"

@interface TKFractalWindowController : NSWindowController {
	IBOutlet TKFractalView *view;
}
@property(readwrite, assign) TKFractalView* view;
@property(readonly) TKFractalParameters* parameters;
@property(readwrite, assign) BOOL plotOrbits;

// Actions
- (IBAction) plotClicked:(id)sender;
- (IBAction) paletteApplyClicked:(id)sender;

// Mouse events
- (void) mouseAtPoint:(NSPoint) point;
- (void) zoomFromPoint:(NSPoint) from to:(NSPoint) to;

// Utility functions
- (cplx) complexAtPoint:(NSPoint) point;
- (NSPoint) pointAtComplex:(cplx) z;
- (void) generateFractal;
- (void) redraw;

@end
