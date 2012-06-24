//
//  TKFractalParametersInspectorView.m
//  Mandelabra_2
//
//  Created by Tim Kemp on 07/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TKFractalParametersInspectorView.h"


@implementation TKFractalParametersInspectorView 

@synthesize  txtMinRe;
@synthesize  txtMinIm;
@synthesize  txtMaxRe;
@synthesize  txtMaxIm;
@synthesize  btnAutoMaxIm;
@synthesize  txtMaxIter;
@synthesize  txtBailout;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		// initialization code
	}
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

- (void) setDebugLabelText:(NSString *) labelText {
	[DEBUG_txtDocWindowName setStringValue:labelText];
}

@end
