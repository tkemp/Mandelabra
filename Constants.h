//
//  Constants.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 07/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "complex_math.h"

NSString * const TKFractalDocument_DocumentDeactivateNotification;
NSString * const TKFractalDocument_DocumentActivateNotification;
#define DEFAULT_MIN_REAL -2
#define DEFAULT_MIN_IMAG -1.2
#define DEFAULT_MAX_REAL 1.2
#define DEFAULT_MAX_IMAG 1.2
#define DEFAULT_BAILOUT 4
#define DEFAULT_MAXITER 5

#define RED 0
#define GREEN 1
#define BLUE 2
#define ALPHA 3
#define DEFAULT_COLORS 256*256

@interface Constants : NSWindowController {

}

@end
