//
//  TKEscapeTimeColorFunction.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 04/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKIColorFunction.h"
#import "TKFractalPoint.h"

@interface TKEscapeTimeColorFunction : NSObject <TKIColorFunction> {

}

- (NSNumber *) evaluateFractalPoint:(TKFractalPoint *) point;

@end
