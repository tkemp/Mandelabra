//
//  TKMandelabraAppController.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 07/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKFractalParametersInspectorWindowController.h"
#import "TKPaletteEditorWindowController.h"

@interface TKMandelabraAppController : NSObject {

}

- (IBAction) showFractalParametersInspector:(id) sender;
- (IBAction) showPaletteEditor:(id) sender;

@end
