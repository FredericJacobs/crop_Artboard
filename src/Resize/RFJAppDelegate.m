//
//  RFJAppDelegate.m
//  Resize
//
//  Created by Frederic Jacobs on 16/2/13.
//  Copyright (c) 2013 Frederic Jacobs. All rights reserved.
//

#import "RFJAppDelegate.h"
#import "NSImage+reframing.h"

@implementation RFJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.pasteCount = -10;
    self.working = TRUE;
        
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(convertImage) userInfo:nil repeats:YES];

}

- (IBAction)turnOnOff:(id)sender {
    if (self.working) {
        self.working = FALSE;
        [self.button setTitle:@"Start"];
    }
    else {
        self.working = TRUE;
        [self.button setTitle:@"Stop"];
    }
}

- (void) convertImage {
    if (!self.working) {
        return;
    }
    else {
        if (self.pasteCount == [[NSPasteboard generalPasteboard] changeCount]) {
            return;
        }
        else{
            self.pasteCount = [[NSPasteboard generalPasteboard] changeCount];
            // This means there is a new item here.
            
            // Let's check if it's coming from Sketch, if yes, resize it.
            
            for (NSString *type in [[[[NSPasteboard generalPasteboard] pasteboardItems] lastObject]types]) {
                if ([type isEqualToString:@"com.bohemiancoding.sketch"]) {
                    [self cutlastPasteboardImage];
                }
            }
        }
    }
}

- (void) cutlastPasteboardImage {
    NSImage *image;
    NSArray *classArray = [NSArray arrayWithObject:[NSImage class]];
    NSDictionary *options = [NSDictionary dictionary];
    BOOL ok = [[NSPasteboard generalPasteboard] canReadObjectForClasses:classArray options:options];
    
    if (ok) {
                
        NSArray *objectsToPaste = [[NSPasteboard generalPasteboard]readObjectsForClasses:classArray options:options];
        image = [objectsToPaste objectAtIndex:0];
        self.lastImage = image;
        
        [self pasteResizedImage:image];
        
    }
}


- (void) pasteResizedImage: (NSImage*) image {
    
    if (!image) {
        return;
    }
    
    int margin = [self.textfield.stringValue intValue];
    
    
    NSLog(@"Size of Image before : h:%f w:%f", image.size.height, image.size.width);
    
    image = [image imageFromRect:NSMakeRect(margin, margin, image.size.width - 2*margin, image.size.height - 2*margin)];
    
    NSLog(@"Size of Image after : h:%f w:%f", image.size.height, image.size.width);
    
    [[NSPasteboard generalPasteboard]clearContents];
    [[NSPasteboard generalPasteboard]writeObjects:[NSArray arrayWithObject:image]];
    
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor{
    if ([self.textfield.stringValue isEqualToString:@""]) {
        self.textfield.stringValue = @"0";
    }
    return YES;
}

- (void)controlTextDidChange:(NSNotification *)obj {
    NSString *digitsString = [RFJAppDelegate numericStringFromString:self.textfield.stringValue];
    if (digitsString) {
        self.textfield.stringValue = digitsString;
    } else {
        self.textfield.stringValue = @"";
    }
}

+ (BOOL)stringIsNumber:(NSString *)str {
    BOOL valid;
    double holder;
    NSScanner *scan = [NSScanner scannerWithString: str];
    valid = [scan scanDouble:&holder] && [scan isAtEnd];
    return valid;
}

+ (NSString *)numericStringFromString:(NSString *)string {
    NSString *digitsString = string;
    if (![self stringIsNumber:string]) {
        NSUInteger length = [string length];
        if (length > 0) {
            digitsString = [string substringToIndex:length - 1];
            if (![self stringIsNumber:digitsString]) {
                digitsString = [self numericStringFromString:digitsString];
            }
        }
    }
    return digitsString;
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector{
    
    if( commandSelector == @selector(moveUp:) ){
        self.textfield.intValue ++;
        [self pasteResizedImage:self.lastImage];
        return YES;    // We handled this command; don't pass it on
    }
    else if( commandSelector == @selector(moveDown:) ){
        if (self.textfield.intValue > 0) {
            self.textfield.intValue --;
            [self pasteResizedImage:self.lastImage];
        }
        return YES;
    }

    [self pasteResizedImage:self.lastImage];

    return NO;
}


@end
