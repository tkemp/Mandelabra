//
//  TKPalette.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 10/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKPalette.h"


@implementation TKPalette {
}
@synthesize palette;
@synthesize memberColor;
@synthesize gradient;

- (id) initWithColors:(int) count gradient:(NSGradient *) aGradient {
	self = [super init];
	if (self) {
		[self setGradient:aGradient];
		[self setPalette:[self makePaletteWithColors:count]];
		[self setMemberColor:[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:1.0]];
	}
	
	return self;
}

- (id) initWithColors:(int) count {
	return [self initWithColors:count gradient:[TKPalette makeDefaultGradient]];
}

- (NSColor*) colorAtReal:(NSNumber *) real {
	int count = [palette count];
	int index = (int)([real floatValue] * count);
	return [palette objectAtIndex:index];
}

- (int) count {
	return [[self palette] count];
}

+ (NSGradient *) makeDefaultGradient {
	return [[NSGradient alloc] initWithColorsAndLocations:
			[NSColor redColor], (CGFloat)0.0,
			[NSColor orangeColor], (CGFloat)0.2,
			[NSColor yellowColor],(CGFloat)0.4,
			[NSColor blueColor], (CGFloat)0.6,
			[NSColor greenColor], (CGFloat)1.0,nil];
}

- (NSArray *) makePaletteWithColors:(NSInteger) count {
	NSMutableArray *pal = [[NSMutableArray alloc] initWithCapacity:count];
	CGFloat colors = (CGFloat) count;
	CGFloat interval = 1/colors;
	CGFloat step = 0.0;
	
	for (int i = 0; i < count; i++) {
		NSColor *colorEntry = [[NSColor alloc] init];
		//CGFloat components[4];
		colorEntry = [[self gradient] interpolatedColorAtLocation:step];
		//[colorEntry getComponents:components];
		[pal addObject:colorEntry];
		step += interval;
	}
	
	return pal;
}

@end
