//
//  TKMandelbrotPointCalculator.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKMandelbrotPointCalculator.h"
#import "TKFractalPoint.h"

int maxIter;
long double bailout;
cplx min, max;

@implementation TKMandelbrotPointCalculator

@synthesize parameters;

- (TKMandelbrotPointCalculator*) init {
	return [self initWithParameters:nil];
}

- (TKMandelbrotPointCalculator*) initWithParameters:(TKFractalParameters *)params {
	self = [super init];
	if (self) {
		[self setParameters:params];
		maxIter = [[self parameters] maxIter];
		bailout = [[self parameters] bailout];
		min = [[self parameters] min];
		max = [[self parameters] max];
	}
	
	return self;
}

- (TKFractalPoint*) calculateWithComplex:(cplx) point doPeriodCheck:(BOOL) check {
	cplx z = { 0.0, 0.0 };
	cplx c = point;	
	cplx *fastTmpOrbitArray = malloc(maxIter * sizeof(cplx));
	//NSMutableArray* orbit = [[NSMutableArray alloc] initWithCapacity:maxIter];
	
	BOOL isMember = YES; // c is in the set
	BOOL isPeriodic = NO;
	BOOL periodChecking = ([[self parameters] periodChecking] && check);
	int orbitLength = 0;
	int periodCheckAtIteration = (maxIter / 10) + 1; // Minimum iteration number to check for periodicity 
	for (int i = 0; i < maxIter; i++) {
		if (isPeriodic) {
			isMember = YES;
			break;
		}
		
		orbitLength = i;
		z = cplxAdd(mult(z, z), c); // z_t = z^2 + c
		fastTmpOrbitArray[i] = z; // save orbit points to temp array
		
		if (modSqr(z) > bailout) { // bailout check
			isMember = NO;
			break;
		}
		
		if (periodChecking) {
			if ((i > 0) && ((i >= periodCheckAtIteration) || (periodCheckAtIteration == maxIter))) {
				for (int j = 0; j < i; j++) { // periodic orbit check
					if(cplxEqual(z, fastTmpOrbitArray[j])) {
						orbitLength = j;
						isPeriodic = YES;
					}					
				}
				periodCheckAtIteration *= 2;
				periodCheckAtIteration = (periodCheckAtIteration > maxIter) ? maxIter : periodCheckAtIteration;
			}
		}		
	}
	
	TKFractalPoint* fp = [[TKFractalPoint alloc] initWithComplex:z
														  member:isMember
														periodic:isPeriodic
														   orbit:fastTmpOrbitArray
													   orbitLength:orbitLength
														 maxIter:maxIter];
	
	return fp;
}


@end
