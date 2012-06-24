//
//  TK2DMutableArray.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 04/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TK2DMutableArray : NSObject {
	NSMutableArray *array;
	int rows, cols;
}

- (id) initWithColumns:(int) columns rows:(int) rows;
- (id) objectAtColumn:(int) col row:(int) row;
- (void) putObject:(id) object atColumn:(int) x row:(int) y;
- (int) indexAtColumn:(int) col row:(int) row;

@end
