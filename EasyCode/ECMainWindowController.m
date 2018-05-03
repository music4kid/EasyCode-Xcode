//
//  ECMainWindowController.m
//  EasyCode
//
//  Created by lijia on 02/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import "ECMainWindowController.h"
#import "EditorWindowController.h"

NSString *const ECiCloudSyncChangedNotification = @"ECiCloudSyncChangedNotification";

@interface ECMainWindowController () <NSAlertDelegate>
@property (nonatomic, weak)   IBOutlet NSButton *useicloudBtn;
@property (nonatomic, strong) EditorWindowController* editorOC;
@property (nonatomic, strong) EditorWindowController* editorSwift;
@end

@implementation ECMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    _useicloudBtn.state = [ESharedUserDefault boolForKey:kUseiCloudSync];
}

- (IBAction)showEditorWindowForOC:(id)sender {
    if (self.editorOC == nil) {
        self.editorOC = [[EditorWindowController alloc] initEditorWindowForType:ECSourceTypeOC];
    }
    [_editorOC showWindow:self];
}

- (IBAction)showEditorWindowForSwift:(id)sender {
    if (self.editorSwift == nil) {
        self.editorSwift = [[EditorWindowController alloc] initEditorWindowForType:ECSourceTypeSwift];
    }
    [_editorSwift showWindow:self];
}

- (IBAction)useiCloudCheck:(NSButton*)sender {
    BOOL useiCloud = (sender.state == NSOnState);
    if (useiCloud) {
        id ubiq = [[NSFileManager defaultManager] ubiquityIdentityToken];
        if (ubiq) {
            [ESharedUserDefault setBool:YES forKey:kUseiCloudSync];
            [[NSNotificationCenter defaultCenter] postNotificationName:ECiCloudSyncChangedNotification object:nil];
        } else {
            [ESharedUserDefault setBool:NO forKey:kUseiCloudSync];
            sender.state = NSOffState;
            //Alert Note
        }
    } else {
        id ubiq = [[NSFileManager defaultManager] ubiquityIdentityToken];
        if (ubiq) {
            NSAlert *warningAlert = [NSAlert ec_alertWithStyle:NSWarningAlertStyle
                                                   messageText:NSLocalizedString(@"iCloud_Attention", nil)
                                               informativeText:NSLocalizedString(@"iCloud_Attention_Message", nil)
                                                   buttonTitle:NSLocalizedString(@"Button_OK_Title",nil),
                                                               NSLocalizedString(@"Button_Cancel_Title", nil),
                                     nil];
            
            [warningAlert beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse returnCode) {
                if (returnCode == NSAlertFirstButtonReturn) { //OK
                    [ESharedUserDefault setBool:NO forKey:kUseiCloudSync];
                    [[NSNotificationCenter defaultCenter] postNotificationName:ECiCloudSyncChangedNotification object:nil];
                }
            }];
        } else {
            [ESharedUserDefault setBool:NO forKey:kUseiCloudSync];
        }
    }
}

- (IBAction)showHowToUse:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"https://github.com/music4kid/EasyCode-Xcode"]];
}


@end
