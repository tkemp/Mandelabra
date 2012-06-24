//
//  TKEscapeTimeColorFunction.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 04/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKEscapeTimeColorFunction.h"


@implementation TKEscapeTimeColorFunction

- (NSNumber *) evaluateFractalPoint:(TKFractalPoint *) point {
	float f_maxIter = (float) [point maxIter];
	float f_iter = (float) [point orbitLength];
	float result = f_iter/f_maxIter;
	return [NSNumber numberWithFloat:result];
}

@end
