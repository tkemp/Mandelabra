//
//  TKPaletteEditorWindowController.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 06/11/2010.
//  Copyright 2010 Liminal Dynamics. All rights reserved.
//

#import "TKPaletteEditorWindowController.h"

static TKPaletteEditorWindowController *g_controller;

@implementation TKPaletteEditorWindowController

@synthesize palette;
@synthesize view;

+ (TKPaletteEditorWindowController *) sharedController {
	if (g_controller == nil) {
		g_controller = [[TKPaletteEditorWindowController alloc] initWithWindowNibName:@"TKPaletteEditorWindow"];
		
		NSNotificationCenter *center;
		center = [NSNotificationCenter defaultCenter];
        
        [center addObserver: g_controller
				   selector: @selector(documentActivateNotification:)
					   name: TKFractalDocument_DocumentActivateNotification
					 object: nil];
        
        [center addObserver: g_controller
				   selector: @selector(documentDeactivateNotification:)
					   name: TKFractalDocument_DocumentDeactivateNotification
					 object: nil];		
	}
	
	return g_controller;
}

- (void) documentActivateNotification: (NSNotification *) notification {
    NSDocument *document = [[notification object] document];
    [self setDocument: document];
}

- (void) documentDeactivateNotification: (NSNotification *) notification {
    [self setDocument: nil];	
}

- (void) show {
	[self setDocument: [[NSDocumentController sharedDocumentController]
						currentDocument]];
    [self showWindow: self];
}

- (void) setParameters:(TKFractalParameters *) params {
	[[self document] setParameters:params];
}

- (TKFractalParameters *) parameters {
	return [[self document] parameters];
}

- (void) setDocument:(NSDocument *) document {
	[super setDocument: document];
	if (document != nil) {
		NSString* title = [NSString stringWithFormat:@"Palette editor: %@", [document displayName]];
		[[self window] setTitle:title];
	}
}

- (void) setPalette:(TKPalette *) aPalette {
	[[self view] setPalette:aPalette];
	palette = aPalette;
}

- (void) windowDidLoad {
    [super windowDidLoad];
	
    [self setShouldCascadeWindows: NO];
    [self setWindowFrameAutosaveName: @"fractalParametersInspectorWindow"];
	
    [self setDocument:[self document]]; // needs to be called to trigger doc linkage first time
	[self setPalette:[[[self document] parameters] palette]];
}

- (void) dealloc {
	NSLog(@"dealloc");
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	
    [center removeObserver: self
					  name: nil
					object: nil];
	
    [super dealloc];	
}


@end
