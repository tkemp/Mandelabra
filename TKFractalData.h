//
//  TKFractalData.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 04/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TK2DMutableArray.h"

@interface TKFractalData : NSObject {
	NSSize sizePixels;
	TK2DMutableArray* grid;
}

@property(readwrite, assign) NSSize sizePixels;
@property(readwrite, assign) TK2DMutableArray* grid;

- (id) initWithSize:(NSSize) sizePixels;
- (void) setColorIndex:(int) index column:(int) x row:(int) y;

@end
