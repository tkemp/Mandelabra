//
//  TKFractalPoint.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "complex_math.h"

@interface TKFractalPoint : NSObject {
	cplx z;
	BOOL isMember;
	BOOL isPeriodic;
	cplx *orbit;
	int orbitLength;
	int maxIter;
	float x, y;
	NSNumber* colorMappedReal;
}
@property(readwrite, assign) cplx z;
@property(readwrite, assign) BOOL isMember;
@property(readwrite, assign) BOOL isPeriodic;
@property(readwrite, assign) cplx* orbit;
@property(readwrite, assign) int orbitLength;
@property(readwrite, assign) int maxIter;
@property(readwrite, assign) float x;
@property(readwrite, assign) float y;
@property(readwrite, assign) NSNumber* colorMappedReal;

- (id) initWithComplex:(cplx) aZ
				member:(BOOL) anIsMember
			  periodic:(BOOL) anIsPeriodic
				 orbit:(cplx *) anOrbit
			 orbitLength:(int) anIterReached
			   maxIter:(int) aMaxIter;

@end
