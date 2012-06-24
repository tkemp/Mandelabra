//
//  TKFractalParameters.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 09/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKFractalParameters.h"


@implementation TKFractalParameters

@synthesize min;
@synthesize max;
@synthesize bailout;
@synthesize maxIter;
@synthesize colorFunc;
@synthesize palette;
@synthesize periodChecking;
@synthesize autoMaxImag;
@synthesize isParallel;

-(id) initWithMin:(cplx) aMin max:(cplx) aMax bailout:(long double) aBailout maxIter:(int) aMaxIter {
	NSLog(@"Initializing fractal parameters: %Lf,%Lf->%Lf,%Lf %Lf %d", aMin.real, aMin.imag, aMax.real, aMax.imag, aBailout, aMaxIter);
	self = [super init];
	if (self) {
		[self setMin:aMin];
		[self setMax:aMax];
		[self setBailout:aBailout];
		[self setMaxIter:aMaxIter];
		
		// Intention is to bind these at runtime; just hardcoded here for early test
		[self setColorFunc:[[TKEscapeTimeColorFunction alloc] init]];
		[self setPeriodChecking:YES];
		[self setAutoMaxImag:YES];
	}
	
	NSLog(@"Made params: %@", self);
	
	return self;
}

- (NSString*) txtMinRe {
	return [NSString stringWithFormat:@"%Lf",[self min].real];
}

- (NSString*) txtMinIm {
	return [NSString stringWithFormat:@"%Lf",[self min].imag];
}

- (NSString*) txtMaxRe {
	return [NSString stringWithFormat:@"%Lf",[self max].real];
}

- (NSString*) txtMaxIm {
	return [NSString stringWithFormat:@"%Lf",[self max].imag];
}


- (NSString *) description {
	return [[NSString alloc] initWithFormat:@"%Lf,%Lf->%Lf,%Lf %Lf %d %@ %@ period check: %d", 
			[self min].real, 
			[self min].imag, 
			[self max].real,
			[self max].imag, 
			[self bailout], 
			[self maxIter],
			[self colorFunc],
			[self palette],
			[self periodChecking]];
}

@end
