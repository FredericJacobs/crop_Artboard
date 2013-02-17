//
//  RFJAppDelegate.h
//  Resize
//
//  Created by Frederic Jacobs on 16/2/13.
//  Copyright (c) 2013 Frederic Jacobs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RFJAppDelegate : NSObject <NSApplicationDelegate, NSTextFieldDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet NSTextField *textfield;
@property BOOL working;
@property (nonatomic, retain) IBOutlet NSButton *button;
@property (nonatomic, retain) NSImage *lastImage;
@property int pasteCount;
@property NSString *lastNumber;

@end
