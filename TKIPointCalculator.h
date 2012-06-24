//
//  TKIPointCalculator.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "complex_math.h"
#import "TKFractalPoint.h"
#import "TKFractalParameters.h"

@protocol TKIPointCalculator

@property(readwrite, assign) TKFractalParameters* parameters;
- (TKFractalPoint *) calculateWithComplex:(cplx) point doPeriodCheck:(BOOL) check;
- (TKFractalParameters *) initWithParameters:(TKFractalParameters *) params;

@end
