//
//  NSImage+reframing.m
//  Resize
//
//  Created by Frederic Jacobs on 17/2/13.
//  Copyright (c) 2013 Frederic Jacobs. All rights reserved.
//

#import "NSImage+reframing.h"

@implementation NSImage (reframing)

- (NSImage *) imageFromRect: (NSRect) rect
{
    NSAffineTransform * xform = [NSAffineTransform transform];
    
    // translate reference frame to map rectangle 'rect' into first quadrant
    [xform translateXBy: -rect.origin.x
                    yBy: -rect.origin.y];
    
    NSSize canvas_size = [xform transformSize: rect.size];
    
    NSImage * canvas = [[NSImage alloc] initWithSize: canvas_size];
    [canvas lockFocus];
    
    [xform concat];
    
    // Get NSImageRep of image
    NSImageRep * rep = [self bestRepresentationForRect:rect context:nil hints:nil];
    
    [rep drawAtPoint: NSZeroPoint];
    
    [canvas unlockFocus];
    return canvas;
}

@end
