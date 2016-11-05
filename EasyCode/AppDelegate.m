//
//  AppDelegate.m
//  EasyCode
//
//  Created by gao feng on 2016/10/15.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "AppDelegate.h"
#import "EditorWindowController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) EditorWindowController*                 editorOC;
@property (nonatomic, strong) EditorWindowController*                 editorSwift;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)showEditorWindowForOC:(id)sender
{
    if (self.editorOC == nil) {
        self.editorOC = [[EditorWindowController alloc] initWithWindowNibName:@"EditorWindowController"];
        [_editorOC initEditorWindow:EditorTypeOC];
    }
    [_editorOC showWindow:self];
}

- (void)showEditorWindowForSwift:(id)sender
{
    if (self.editorSwift == nil) {
        self.editorSwift = [[EditorWindowController alloc] initWithWindowNibName:@"EditorWindowController"];
        [_editorSwift initEditorWindow:EditorTypeSwift];
    }
    [_editorSwift showWindow:self];
}

- (IBAction)showHowToUse:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"https://github.com/music4kid/EasyCode-Xcode"]];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    if (flag) {
        return NO;
    }
    else
    {
        [self.window makeKeyAndOrderFront:self];
        return YES;
    }
}

@end
