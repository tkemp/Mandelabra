//
//  TKFractalPoint.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKFractalPoint.h"


@implementation TKFractalPoint

@synthesize z;
@synthesize isMember;
@synthesize isPeriodic;
@synthesize orbit;
@synthesize orbitLength;
@synthesize maxIter; 
@synthesize x;
@synthesize y;
@synthesize colorMappedReal;

- (id) initWithComplex:(cplx) aZ
				member:(BOOL) anIsMember
			  periodic:(BOOL) anIsPeriodic
				 orbit:(cplx *) anOrbit
			 orbitLength:(int) anIterReached
			   maxIter:(int) aMaxIter 
{
	self = [super init];
    if (self) {
        [self setZ:aZ];
		[self setIsMember:anIsMember];
		[self setIsPeriodic:anIsPeriodic];
		[self setOrbit:anOrbit];
		[self setOrbitLength:anIterReached];
		[self setMaxIter:aMaxIter];
		[self setX:0.0];
		[self setY:0.0];
    }
	
    return self;
}

- (NSString *) description {
	NSString* result;
	
	//	if (colorMappedReal != nil) {
	result = [NSString stringWithFormat:@"z:%Lf,%Lf member:%d periodic:%d orbitLength:%d col:%@ coords:%f,%f", 
			  [self z].real, 
			  [self z].imag, 
			  [self isMember],
			  [self isPeriodic],
			  [self orbitLength],
			  [self colorMappedReal],
			  [self x],
			  [self y]];
	
	return result;
}

- (void) finalize {
	if (orbit) {
		free(orbit);
	}
	[super finalize];
}
@end
