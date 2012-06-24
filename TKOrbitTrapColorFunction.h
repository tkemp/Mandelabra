//
//  TKOrbitTrapColorFunction.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 04/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKIColorFunction.h"


@interface TKOrbitTrapColorFunction : NSObject <TKIColorFunction> {

}

- (NSNumber *) evaluateFractalPoint:(TKFractalPoint *) point;

@end
