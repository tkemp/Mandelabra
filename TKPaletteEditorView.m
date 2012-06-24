//
//  TKPaletteEditorView.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 06/11/2010.
//  Copyright 2010 Liminal Dynamics. All rights reserved.
//

#import "TKPaletteEditorView.h"
#import "TKPaletteEditorWindowController.h"

@implementation TKPaletteEditorView
@synthesize palette;
@synthesize colorDepth;
@synthesize channels;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self setColorDepth:8];
		[self setChannels:4];
		//rep = [self repWithSize:[self bounds].size];
    }
	
    return self;
}

- (void)setPalette:(TKPalette *) aPalette {
	palette = aPalette;
	//rep = [self repWithSize:NSMakeSize([palette count]/2, [palette count]/2)];
	[self setNeedsDisplay:YES];
}

- (void) updateRep {
	/*[self clearRepresentation:rep];
	unsigned char* bitmapData[5];
	[rep getBitmapDataPlanes:bitmapData];
	NSSize size = [rep size];
	
	float step = 1/[palette count];
	
	for (int y = 0; y < size.height; y++) {
		for (int x = 0; x < size.width; x++) {
			NSColor* col = [palette */
	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSGraphicsContext currentContext]
     setImageInterpolation: NSImageInterpolationHigh];
	
	[[NSGraphicsContext currentContext]
     setShouldAntialias:YES];
	/*
	[rep drawInRect:[self bounds]];
	[rep release];
	 */
	
	[[palette gradient] drawInRect:[self bounds] angle:0.0];
}

- (NSBitmapImageRep *) repWithSize:(NSSize) size {
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

- (void) clearRepresentation:(NSBitmapImageRep *) rep {
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
			components[ALPHA] = 1.0;
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
