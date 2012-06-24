//
//  TKMandelabraAppController.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 07/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKMandelabraAppController.h"

@implementation TKMandelabraAppController

- (IBAction) showFractalParametersInspector:(id) sender {
	[[TKFractalParametersInspectorWindowController sharedController] show];
}

- (IBAction) showPaletteEditor:(id) sender {
	[[TKPaletteEditorWindowController sharedController] show];
}

@end
