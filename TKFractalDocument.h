//
//  MyDocument.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "TKFractalWindowController.h"
#import "complex_math.h"
#import "Constants.h"
#import "TKFractalParameters.h"
#import "TKMandelbrotPointCalculator.h"
#import "TKIPointCalculator.h"
#import "TKFractalData.h"
#import "TKIColorFunction.h"

@interface TKFractalDocument : NSDocument {
	TKFractalParameters* parameters;
	id<TKIPointCalculator> calculator;
	IBOutlet TKFractalWindowController* controller;
}
@property(readwrite, assign) TKFractalParameters* parameters;
@property(readwrite, assign) id<TKIPointCalculator> calculator;
@property(readwrite, assign) TKFractalWindowController* controller;

- (void) generateFractal;
- (TKFractalParameters *) makeDefaultParameters;

@end
