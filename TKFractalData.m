//
//  TKFractalData.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 04/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKFractalData.h"


@implementation TKFractalData 

@synthesize sizePixels;
@synthesize grid;

- (id) initWithSize:(NSSize) aSizePixels {
	self = [super init];
	if (self) {
		[self setSizePixels:aSizePixels];
		[self setGrid:[[TK2DMutableArray alloc] initWithColumns:aSizePixels.width
														   rows:aSizePixels.height]];
		
		for (int i = 0; i < aSizePixels.width * aSizePixels.height; i++)
			[grid addObject:0];
	}
	
	return self;
}

- (void) setColorIndex:(int) index column:(int) x row:(int) y {
	[grid putObject:[[NSNumber alloc] initWithInt:index] atColumn:x Row:y];
}

@end
