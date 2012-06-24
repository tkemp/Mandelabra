//
//  TK2DMutableArray.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 04/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TK2DMutableArray.h"

@implementation TK2DMutableArray 

- (id) initWithColumns:(int) x rows:(int) y {
	array = [[NSMutableArray alloc] initWithCapacity:x * y];
	cols = x;
	rows = y;
	return self;
}

- (id) objectAtColumn:(int) col row:(int) row {
	return [array objectAtIndex:[self indexAtColumn:col row:row]];
}

- (void) putObject:(id) object atColumn:(int) x row:(int) y {
	[array replaceObjectAtIndex:[self indexAtColumn:x row:y] withObject:object];
}

- (int) indexAtColumn:(int) col row:(int) row {
	return (col + (row * rows));
}

@end
