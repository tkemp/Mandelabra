//
//  TKLongDouble.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 04/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "complex_math.h"

@interface TKComplexWrapper : NSObject {
	cplx value;
}
@property(readwrite, assign) cplx value;

- (id) initWithValue:(cplx) val;

@end
