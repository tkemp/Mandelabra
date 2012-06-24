//
//  FractalView.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKFractalView.h"
#import "TKFractalWindowController.h"

@implementation TKFractalView

@synthesize scale;
@synthesize renderer;
@synthesize fractalRepresentation;
@synthesize orbitRepresentation;

NSImage* image;
NSBezierPath* path;
NSPointArray orbitPoints; // Global scope so we can free it, avoiding memory leaks

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        zoomRect = NSMakeRect(0.0, 0.0, 0.0, 0.0);
		trackingArea = [[NSTrackingArea alloc] initWithRect:[self visibleRect]
													options: (NSTrackingMouseEnteredAndExited 
															  | NSTrackingMouseMoved 
															  | NSTrackingActiveAlways
															  | NSTrackingInVisibleRect)
													  owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
    }
	
	return self;
}

- (void) setScaleForMin:(cplx) aMin max:(cplx) aMax {
	factor f;
	f.real = (aMax.real - aMin.real) / ([self bounds].size.width -1);
	f.imag = (aMax.imag - aMin.imag) / ([self bounds].size.height - 1);
	
	[self setScale:f];
	
	NSLog(@"setScale factor:%Lf,%Lf", f.real, f.imag);
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSGraphicsContext currentContext]
     setImageInterpolation: NSImageInterpolationHigh];

	[[NSGraphicsContext currentContext]
     setShouldAntialias:YES];
	
	[fractalRepresentation drawInRect:[self bounds]];
	[orbitRepresentation drawInRect:[self bounds]
						   fromRect:NSZeroRect
						  operation:NSCompositeSourceOver
						   fraction:1.0
					 respectFlipped:YES
							  hints:nil];
	
	[[NSColor colorWithCalibratedRed:0.7 green:0.0 blue:0.0 alpha:0.5] set];
	NSRectFillUsingOperation(zoomRect, NSCompositeSourceOver);
	[[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0] set];
	[path stroke];
}

- (void) plotPoint:(TKFractalPoint *) fp {
	if (renderer != nil)
		[renderer plotPoint:fp];
}

- (void) plotOrbit:(TKFractalPoint *) fp {
	[self plotOrbitAsPath:fp];
	// [self plotOrbitAsPoints:fp];
}

- (void) plotOrbitAsPath:(TKFractalPoint *) fp {
	path = [NSBezierPath bezierPath];
	cplx* orbit = [fp orbit];
	int orbitLength = [fp orbitLength];

	if (orbitPoints)
		free(orbitPoints);
	
	orbitPoints = (NSPointArray) malloc(sizeof(NSPoint) * orbitLength);
	
	fprintf(stderr, "{\n");
	for (int i = 0; i < orbitLength; i++) {
		fprintf(stderr, "%\t%Lf + %LfI,\n", orbit[i].real, orbit[i].imag);
		NSPoint p = [controller pointAtComplex:orbit[i]];
		orbitPoints[i] = p;
	}
	fprintf(stderr, "}\n");
	
	[path appendBezierPathWithPoints:orbitPoints count:[fp orbitLength]];
}

- (void) plotOrbitAsPoints:(TKFractalPoint *) fp {
	if (renderer != nil)
		[renderer plotOrbit:fp controller:controller];
}

- (void)mouseMoved:(NSEvent *)theEvent {
	NSPoint pt = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	
	[controller mouseAtPoint:pt];
}

- (void)mouseDown:(NSEvent *)event {
	NSPoint pt = [self convertPoint:[event locationInWindow] fromView:nil];
	dragStart = pt;
	dragStop = pt;
}

- (void)mouseDragged:(NSEvent *)event {
	NSPoint pt = [self convertPoint:[event locationInWindow] fromView:nil];
	dragStop = pt;
	
	zoomRect = [self rectBetweenStart:dragStart current:dragStop];
	
	[self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event {
	if ((dragStart.x != dragStop.x) && (dragStart.y != dragStop.y)) {
		[controller zoomFromPoint:dragStart to:dragStop];
	}
	
	zoomRect.size = NSMakeSize(0.0, 0.0);
}

- (NSRect) rectBetweenStart:(NSPoint)startPoint current:(NSPoint)curPoint
{
	NSRect rect;
	if (startPoint.x > curPoint.x)
	{
		rect.origin.x = curPoint.x;
		rect.size.width = startPoint.x - curPoint.x;
	}
	else
	{
		rect.origin.x = startPoint.x;
		rect.size.width = curPoint.x - startPoint.x;
	}
	if (startPoint.y > curPoint.y)
	{
		rect.origin.y = curPoint.y;
		rect.size.height = startPoint.y - curPoint.y;
	}
	else
	{
		rect.origin.y = startPoint.y;
		rect.size.height = curPoint.y - startPoint.y;
	}
	return rect;
}

- (void) setPalette:(TKPalette *) palette {
	[[self renderer] setPalette:palette];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"size:%d,%d",[self bounds].size.width, [self bounds].size.height];
}

@end
