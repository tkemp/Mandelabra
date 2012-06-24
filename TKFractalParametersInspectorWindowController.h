//
//  TKFractalParametersInspectorWindowController.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 07/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKFractalDocument.h"
#import "Constants.h"
#import "TKFractalParametersInspectorView.h"
#import "TKFractalParameters.h"

@interface TKFractalParametersInspectorWindowController : NSWindowController {
	IBOutlet TKFractalParametersInspectorView* view;
}
@property(readwrite, assign) TKFractalParameters* parameters; // Retrieves directly from the document associated with the inspector.

+ (TKFractalParametersInspectorWindowController *) sharedController;
- (void) show;

@end
