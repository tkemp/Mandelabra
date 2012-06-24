//
//  TKFractalParameters.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 09/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "complex_math.h"
#import "TKIColorFunction.h"
#import "TKPalette.h"

// For early dev only - will be runtime bound
#import "TKEscapeTimeColorFunction.h"

@interface TKFractalParameters : NSObject {
	cplx min, max;
	float bailout;
	NSInteger maxIter;
	id<TKIColorFunction> colorFunc;
	TKPalette* palette;
	BOOL periodChecking;
	BOOL autoMaxImag;
	BOOL isParallel;
}
@property(readwrite, assign) cplx min;
@property(readwrite, assign) cplx max;
@property(readwrite, assign) float bailout;
@property(readwrite, assign) NSInteger maxIter;
@property(readwrite, assign) id<TKIColorFunction> colorFunc;
@property(readwrite, assign) TKPalette* palette;
@property(readwrite, assign) BOOL periodChecking;
@property(readwrite, assign) BOOL autoMaxImag;
@property(readwrite, assign) BOOL isParallel;
@property(readonly, assign) NSString* txtMinRe;
@property(readonly, assign) NSString* txtMinIm;
@property(readonly, assign) NSString* txtMaxRe;
@property(readonly, assign) NSString* txtMaxIm;

-(id) initWithMin:(cplx) aMin max:(cplx) aMax bailout:(long double) aBailout maxIter:(int) aMaxIter;

@end
