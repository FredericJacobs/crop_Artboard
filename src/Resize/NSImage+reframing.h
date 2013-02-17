//
//  NSImage+reframing.h
//  Resize
//
//  Created by Frederic Jacobs on 17/2/13.
//  Copyright (c) 2013 Frederic Jacobs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (reframing)

- (NSImage *) imageFromRect: (NSRect) rect;

@end
