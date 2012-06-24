//
//  TKFractalRenderer.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKCocoaFractalRenderer.h"


@implementation TKCocoaFractalRenderer 

@synthesize fractalRepresentation;
@synthesize orbitRepresentation;
@synthesize colorDepth;
@synthesize channels;
@synthesize palette;
@synthesize data;

- (id) initWithSize:(NSSize ) size palette:(TKPalette *) pal {
	self = [super init];
	if (self) {
		[self setColorDepth:8];
		[self setChannels:4]; // rgb + a
		[self setPalette:pal];
		[self allocRepsWithSize:size];
	}
	
	return self;
}

#pragma mark Plotting

- (void) plotPoint:(TKFractalPoint *)point {
	NSSize size = [fractalRepresentation size];
	int rowBytes = ((size.width * [self colorDepth]) / 8);
	unsigned char* bitmapData[5];
	[fractalRepresentation getBitmapDataPlanes:bitmapData];
	int x = [point x];
	int y = [point y];
	int rowFromTop = size.height - y;
	NSColor* col;
	if ([point isMember]) {
		col = [[self palette] memberColor];
	}
	else {
		col = [[self palette] colorAtReal:[point colorMappedReal]];
	}
	
	if ([point isPeriodic]) {
		col = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.2 alpha:1.0];
	}
	
	CGFloat components[4];
	unsigned char* pixel;
	[col getComponents:components];
		
	pixel = bitmapData[RED] + rowFromTop * rowBytes + 1 * x;
	*pixel = 255 * components[RED];
	pixel = bitmapData[GREEN] + rowFromTop * rowBytes + 1 * x;
	*pixel = 255 * components[GREEN];
	pixel = bitmapData[BLUE] + rowFromTop * rowBytes + 1 * x;
	*pixel = 255 * components[BLUE];
	pixel = bitmapData[ALPHA] + rowFromTop * rowBytes + 1 * x;
	*pixel = 255 * components[ALPHA];
}

- (void) plotOrbit:(TKFractalPoint *) fp controller:(TKFractalWindowController *) controller {
	// Bitmap data itself
	NSSize size = [orbitRepresentation size];
	int rowBytes = ((size.width * [self colorDepth]) / 8);
	unsigned char *bitmapData[5];
	// Clear old orbit rep and make a new one
	[self clearRepresentation:orbitRepresentation];
	[orbitRepresentation getBitmapDataPlanes:bitmapData];
	
	// The colour
	NSColor* col;
	float greyVal = 0.0;
	
	CGFloat components[4];
	
	// The point
	unsigned char* pixel;
	
	// Iterate around each point in the orbit, only working with those which are on-screen.
	cplx *orbit = [fp orbit];
	cplx min = [[controller parameters] min];
	cplx max = [[controller parameters] max];
	BOOL pointIsOnScreen = true;
	for (int i = 0; i < [fp orbitLength]; i++) {
		greyVal = (float) i / [fp orbitLength];
		greyVal += 0.2;
		col = [NSColor colorWithCalibratedRed:greyVal
										green:greyVal 
										 blue:greyVal 
										alpha:1.0];
		[col getComponents:components];
		cplx z = orbit[i];
		pointIsOnScreen = isInRange(z, min, max);

		if (pointIsOnScreen) {
			NSPoint pt = [controller pointAtComplex:z];
			int x = pt.x;
			int y = pt.y;
			int rowFromTop = size.height - y;
			
			pixel = bitmapData[RED] + rowFromTop * rowBytes + 1 * x;
			*pixel = 255 * components[RED];
			pixel = bitmapData[GREEN] + rowFromTop * rowBytes + 1 * x;
			*pixel = 255 * components[GREEN];
			pixel = bitmapData[BLUE] + rowFromTop * rowBytes + 1 * x;
			*pixel = 255 * components[BLUE];
			pixel = bitmapData[ALPHA] + rowFromTop * rowBytes + 1 * x;
			*pixel = 255 * components[ALPHA];
		}
	}
}

#pragma mark Representations

- (void) allocRepsWithSize:(NSSize) size {
	[self setFractalRepresentation:[self repWithSize:size]];
	[self setOrbitRepresentation:[self repWithSize:size]];
}

- (NSImageRep *) repWithSize:(NSSize) size {
	int rowBytes = ((size.width * [self colorDepth]) / 8);
	NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
																		  pixelsWide:size.width
																		  pixelsHigh:size.height
																	   bitsPerSample:[self colorDepth]
																	 samplesPerPixel:[self channels]
																			hasAlpha:YES
																			isPlanar:YES
																	  colorSpaceName:NSDeviceRGBColorSpace
																		 bytesPerRow:rowBytes
																		bitsPerPixel:0];
	[self clearRepresentation:rep];
	
	return rep;
}

- (void) clearRepresentation:(NSImageRep *) rep {
	NSSize size = [rep size];
	int rowBytes = ((size.width * [self colorDepth]) / 8);
	unsigned char* bitmapData[5];
	[rep getBitmapDataPlanes:bitmapData];
	int rowFromTop = 0;
	for (int y = size.height - 1; y >= 0; y--) {
		for (int x = 0; x < size.width; x++) {
			CGFloat components[4];
			unsigned char* pixel;
			components[RED] = 0.0;
			components[GREEN] = 0.0;
			components[BLUE] = 0.0;
			components[ALPHA] = 0.0;
			pixel = bitmapData[RED] + rowFromTop * rowBytes + 1 * x;
			*pixel = 255 * components[RED];
			pixel = bitmapData[GREEN] + rowFromTop * rowBytes + 1 * x;
			*pixel = 255 * components[GREEN];
			pixel = bitmapData[BLUE] + rowFromTop * rowBytes + 1 * x;
			*pixel = 255 * components[BLUE];
			pixel = bitmapData[ALPHA] + rowFromTop * rowBytes + 1 * x;
			*pixel = 255 * components[ALPHA];
		}
		rowFromTop++;
	}	
}

@end
