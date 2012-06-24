//
//  MyDocument.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 03/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKFractalDocument.h"

@implementation TKFractalDocument 

@synthesize parameters;
@synthesize calculator;
@synthesize controller;

- (id)init
{
    self = [super init];
    if (self) {
        [self setCalculator:[TKMandelbrotPointCalculator alloc]];
    }
    return self;
}

#pragma mark Generators

- (void) generateFractal {
	if([[self parameters] isParallel])
		[self generateFractal_parallel];
	else
		[self generateFractal_serial];
}

- (void) generateFractal_serial {
	NSLog(@"generateFractal_serial");
	
	// Have the calculator run each point:
	[[self calculator] initWithParameters:[self parameters]];
	int widthPx = [[[self controller] view] bounds].size.width;
	int heightPx = [[[self controller] view] bounds].size.height;
	//TKFractalData *data = [[TKFractalData alloc] initWithSize:[[[self controller] view] bounds].size];
	//[[self controller] setData:data];
	id<TKIColorFunction> colorFunc = [[self parameters] colorFunc];
	
	// int optMaxIter = 1; // Optimized maxIter - last orbitLength + 1 - does this help?
	BOOL lastPointWasMember = NO;
	for (int y = 0; y <= heightPx; y++) {
		for (int x = 0; x <= widthPx; x++) {
			TKFractalPoint* fp = [[self calculator] calculateWithComplex:[[self controller] complexAtPoint:NSMakePoint(x, y)]
														   doPeriodCheck:lastPointWasMember];
			[fp setX:x];
			[fp setY:y];
			[fp setColorMappedReal:[colorFunc evaluateFractalPoint:fp]];
			lastPointWasMember = [fp isMember];
			[[self controller] documentDidCalculateFractalPoint:fp];
		}
		
		[[self controller] documentDidFinishCalculatingLine];
		if (y % 10 == 0)
			[[self controller] redraw];
	}
}

- (void) generateFractal_parallel {	
	NSLog(@"generateFractal_parallel");
	
	// Have the calculator run each point:
	[[self calculator] initWithParameters:[self parameters]];
	int widthPx = [[[self controller] view] bounds].size.width;
	int heightPx = [[[self controller] view] bounds].size.height;
	//TKFractalData *data = [[TKFractalData alloc] initWithSize:[[[self controller] view] bounds].size];
	//[[self controller] setData:data];
	id<TKIColorFunction> colorFunc = [[self parameters] colorFunc];
	
	// int optMaxIter = 1; // Optimized maxIter - last orbitLength + 1 - does this help?
	BOOL lastPointWasMember = NO;
	
	/* GCD - send each line to the global queue */
	dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_queue_t mainQ = dispatch_get_main_queue();
	for (int y = 0; y <= heightPx; y++) {
		dispatch_async(globalQ, ^{ // Parallel unit in block
			for (int x = 0; x <= widthPx; x++) {
				TKFractalPoint* fp = [[self calculator] calculateWithComplex:[[self controller] complexAtPoint:NSMakePoint(x, y)]
															   doPeriodCheck:lastPointWasMember];
				[fp setX:x];
				[fp setY:y];
				[fp setColorMappedReal:[colorFunc evaluateFractalPoint:fp]];
				//lastPointWasMember = [fp isMember]; // Cannot use in parallel block
				//dispatch_async(mainQ, ^{
				    [[self controller] documentDidCalculateFractalPoint:fp];
				//});
			}
		}); // End of parallel unit block
		
		//[[self controller] documentDidFinishCalculatingLine];
		//if ((y % 10 == 0) || (y == heightPx))
//			dispatch_async(mainQ, ^{
//				[[self controller] redraw];
//			});
	}
	
	[[self controller] redraw];
}

- (void) makeWindowControllers {
	TKFractalWindowController *ctrl = [[TKFractalWindowController alloc] initWithWindowNibName:@"TKFractalDocument"];
	NSLog(@"makeWindowControllers %@ controlling %@", ctrl, self);
	[self addWindowController:ctrl];
	[self setController:ctrl];
}

- (TKFractalParameters *) makeDefaultParameters {
	NSLog(@"makeDefaultParameters");
	cplx def_min;// = {-2.0, -1.2};
	def_min.real = DEFAULT_MIN_REAL;
	def_min.imag = DEFAULT_MIN_IMAG;
	cplx def_max;// = {2.0, 1.2};
	def_max.real = DEFAULT_MAX_REAL;
	def_max.imag = DEFAULT_MAX_IMAG;
	long double def_bailout = DEFAULT_BAILOUT;
	int def_maxIter = DEFAULT_MAXITER;
	TKFractalParameters* params = [[TKFractalParameters alloc] initWithMin:def_min
																	   max:def_max 
																   bailout:def_bailout 
																   maxIter:def_maxIter];
	[params setPalette:[[TKPalette alloc] initWithColors:DEFAULT_COLORS]];
	[params setPeriodChecking:NO];
	[params setIsParallel:YES];
	
	return params;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
	// Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.
	
	// You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
	
	// For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.
	
	if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
	// Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.
	
	// You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
	
	// For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
	
	if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return YES;
}

- (void) setController:(TKFractalWindowController *) ctrl {
	controller = ctrl;
}

- (NSString *) description {
	return (@"TKFractalDocument object");
}

@end
