//
//  TKFractalParametersInspectorView.h
//  Mandelabra_2
//
//  Created by Tim Kemp on 07/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TKFractalParametersInspectorView : NSView {
	IBOutlet NSTextField* txtMinRe;
	IBOutlet NSTextField* txtMinIm;
	IBOutlet NSTextField* txtMaxRe;
	IBOutlet NSTextField* txtMaxIm;
	IBOutlet NSButton* btnAutoMaxIm;
	IBOutlet NSTextField* txtMaxIter;
	IBOutlet NSTextField* txtBailout;
	
	IBOutlet NSTextField* DEBUG_txtDocWindowName;
}
@property(readwrite, assign) NSTextField* txtMinRe;
@property(readwrite, assign) NSTextField* txtMinIm;
@property(readwrite, assign) NSTextField* txtMaxRe;
@property(readwrite, assign) NSTextField* txtMaxIm;
@property(readwrite, assign) NSButton* btnAutoMaxIm;
@property(readwrite, assign) NSTextField* txtMaxIter;
@property(readwrite, assign) NSTextField* txtBailout;

- (void) setDebugLabelText:(NSString *) labelText;

@end
