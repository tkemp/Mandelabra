//
//  TKFractalParametersInspectorWindowController.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 07/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKFractalParametersInspectorWindowController.h"

static TKFractalParametersInspectorWindowController *g_controller;

@implementation TKFractalParametersInspectorWindowController

+ (TKFractalParametersInspectorWindowController *) sharedController {
	if (g_controller == nil) {
		g_controller = [[TKFractalParametersInspectorWindowController alloc] initWithWindowNibName:@"TKFractalParametersInspectorWindow"];
		
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
		[view setDebugLabelText:[document displayName]];
		[[self window] setTitle:[document displayName]];
	}
}

- (void) windowDidLoad {
    [super windowDidLoad];
	
    [self setShouldCascadeWindows: NO];
    [self setWindowFrameAutosaveName: @"fractalParametersInspectorWindow"];
	
    [self setDocument: [self document]]; // needs to be called to trigger doc linkage first time
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
