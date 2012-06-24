//
//  TKPaletteEditorView.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 06/11/2010.
//  Copyright 2010 Liminal Dynamics. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKPalette.h"
#import "Constants.h"
@class TKPaletteEditorWindowController;

@interface TKPaletteEditorView : NSView {
	TKPalette* palette;
	int colorDepth;
	int channels;
	NSBitmapImageRep *rep;
	IBOutlet TKPaletteEditorWindowController* controller;
}

@property(readwrite, assign) int colorDepth;
@property(readwrite, assign) int channels;
@property(readwrite, assign) TKPalette* palette;

@end
