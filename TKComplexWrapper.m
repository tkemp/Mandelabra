//
//  TKLongDouble.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 04/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKComplexWrapper.h"


@implementation TKComplexWrapper 

@synthesize value;

- (id) initWithValue:(cplx) val {
	self = [super init];
	if (self) {
		value = val;
	}
	
	return self;
}

- (NSString *) description {
	return [NSString stringWithFormat:@"TKComplexWrapper (%Lf + i%Lf)", value.real, value.imag];
}
@end
