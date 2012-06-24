//
//  TKMandelbrotPointCalculator.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKIPointCalculator.h"
#import "TKFractalPoint.h"
#import "TKFractalParameters.h"

@interface TKMandelbrotPointCalculator : NSObject <TKIPointCalculator> {
	TKFractalParameters *parameters;
}
@property (readwrite, assign) TKFractalParameters* parameters;

- (TKMandelbrotPointCalculator*) initWithParameters:(TKFractalParameters *)params;
- (TKFractalPoint*) calculateWithComplex:(cplx) point doPeriodCheck:(BOOL) check;

@end
