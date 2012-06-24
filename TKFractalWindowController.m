//
//  TKFractalWindowController.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 06/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKFractalWindowController.h"


@implementation TKFractalWindowController 

@synthesize view;
@synthesize plotOrbits;

- (id) initWithWindowNibName:(NSString*) name {
	self = [super initWithWindowNibName:name];
	return self;
}

#pragma mark Event handlers

- (IBAction) plotClicked:(id) sender {
	[self generateFractal];
}

- (IBAction) paletteApplyClicked:(id) sender {
	[self applyPalette];
}

- (void) mouseAtPoint:(NSPoint) point {
	if ([self plotOrbits]) {
		[[[self document] calculator] initWithParameters:[self parameters]];
		TKFractalPoint* fp = [[[self document] calculator] calculateWithComplex:[self complexAtPoint:point] doPeriodCheck:YES];
		[fp setX:point.x];
		[fp setY:point.y];
		
		if ([fp orbitLength] > 0) {
			[view plotOrbit:fp];
			[view setNeedsDisplay:YES];
			
		}
	}
}

- (void) zoomFromPoint:(NSPoint)from to:(NSPoint)to {	
	NSPoint startPt = NSMakePoint(MIN(from.x, to.x), MIN(from.y, to.y));
	NSPoint stopPt  = NSMakePoint(MAX(from.x, to.x), MAX(from.y, to.y));
	cplx startZ = [self complexAtPoint:startPt];
	cplx stopZ = [self complexAtPoint:stopPt];
	//stopZ.imag = startZ.imag + (stopZ.real - startZ.real) * [view bounds].size.height / [view bounds].size.width;
	
	[[self parameters] setMin:startZ];
	[[self parameters] setMax:stopZ];
	
	if ([[self parameters] autoMaxImag]) {
		cplx max = [[self parameters] max];
		cplx min = [[self parameters] min];
		NSSize size = [[self view] bounds].size;
		max.imag = min.imag + (max.real - min.real) * size.height / size.width;
		[[self parameters] setMax:max];
	}

	[self generateFractal];
}

- (void) generateFractal {
	TKFractalDocument* doc = [self document];
	[view setScaleForMin:[[self parameters] min] max:[[self parameters] max]];

	TKPalette* palette = [[self parameters] palette];
	
	if (palette == nil)
		palette = [[TKPalette alloc] initWithColors:(255 * 255)];
	
	// Do this here, or have the view ask the controller for a renderer?
	[view setRenderer:[[TKCocoaFractalRenderer alloc]
					   initWithSize:[[self view] bounds].size
					   palette:palette]];
	
	// Do this here? Probably should have the view manage all this
	[view setFractalRepresentation:[[view renderer] fractalRepresentation]];
	[view setOrbitRepresentation:[[view renderer] orbitRepresentation]];
	
	[doc generateFractal];
}	

- (void) applyPalette {
	[view setPalette:[[self parameters] palette]];
}

#pragma mark Utility functions

- (cplx) complexAtPoint:(NSPoint) point {	
	cplx result, p, base;
	factor scale;
	
	base = [[self parameters] min];
	scale = [view scale]; 
	p.real = point.x; 
	p.imag = point.y;
	
	result = vectorMult(p, scale);
	result = cplxAdd(result, base);
	
	return result;
}

- (NSPoint) pointAtComplex:(cplx) z {
	NSPoint result;
	cplx base = [[self parameters] min];
	factor scale = [view scale];
	
	cplx d = vectorDiv(cplxSub(z, base), scale);
	result = NSMakePoint(d.real, d.imag);
	
	return result;
}


- (TKFractalParameters *) parameters {
	return [[self document] parameters];
}

#pragma mark Notifications and delegate methods

- (void) postNotification: (NSString *) notificationName {
	NSNotificationCenter *center;
	center = [NSNotificationCenter defaultCenter];
	
	[center postNotificationName: notificationName
						  object: self];	
}

- (void) windowDidBecomeMain: (NSNotification *) notification {
	[self postNotification: 
	 TKFractalDocument_DocumentActivateNotification];	
}

- (void) windowDidResignMain: (NSNotification *) notification {
	[self postNotification: 
	 TKFractalDocument_DocumentDeactivateNotification];	
}

- (void) windowWillClose: (NSNotification *) notification {
	[self postNotification: 
	 TKFractalDocument_DocumentDeactivateNotification];
}

- (void)windowDidResize:(NSNotification *)notification {
	[view setScaleForMin:[[self parameters] min] max:[[self parameters] max]];
	//[view setRenderer:[[TKFractalRenderer alloc] initWithSize:[[self view] bounds].size]];
}

- (void)windowDidLoad {
	[super windowDidLoad];
	[[self document] setParameters:[[self document] makeDefaultParameters]];
}

- (void) documentDidCalculateFractalPoint:(TKFractalPoint *) fp {
	[view plotPoint:fp];
}

- (void) documentDidFinishCalculatingLine {
	[view setNeedsDisplay:YES];
}

- (void) redraw {
	[view setNeedsDisplay:YES];
	//[view displayIfNeeded];
}

- (BOOL) isDocumentEdited {
	return [[self document] isDocumentEdited];
}

- (NSString *) windowTitleForDocumentDisplayName:(NSString *)displayName {
	NSString *string;
	
	string = [NSString stringWithFormat: 
			  NSLocalizedString(@"Fractal: %@", @""), displayName];
	return (string);
}

@end
