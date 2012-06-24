//
//  TKIColorFunction.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKFractalPoint.h"

@protocol TKIColorFunction

/**
 * Return a real number in the range 0..1
 */
- (NSNumber *) evaluateFractalPoint:(TKFractalPoint *) point;

@end
