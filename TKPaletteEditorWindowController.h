//
//  TKPaletteEditorWindowController.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 06/11/2010.
//  Copyright 2010 Liminal Dynamics. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Constants.h"
#import "TKFractalParameters.h"
#import "TKPaletteEditorView.h"

@interface TKPaletteEditorWindowController : NSWindowController {
	TKPalette* palette;
	IBOutlet TKPaletteEditorView* view;
}

@property(readwrite, assign) TKFractalParameters* parameters; // Retrieves directly from the document associated with the inspector.
@property(readwrite, assign) TKPalette* palette;
@property(readwrite, assign) TKPaletteEditorView* view;

+ (TKPaletteEditorWindowController *) sharedController;
- (void) show;

@end
