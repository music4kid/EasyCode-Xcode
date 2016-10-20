//
//  DetailWindowController.m
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "DetailWindowController.h"

@interface DetailWindowController () <NSTextFieldDelegate, NSWindowDelegate, NSControlTextEditingDelegate>
@property (nonatomic, strong) EShortcutEntry*                 curEntry;

@end

@implementation DetailWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self updateEntryDisplay];
    
    self.window.delegate = self;

}

- (void)windowWillClose:(NSNotification *)notification
{
    if (_delegate) {
        if (_editMode == DetailEditorModeUpdate) {
            [_delegate onEntryUpdated:_curEntry];
        }
        else if(_editMode == DetailEditorModeInsert)
        {
            [_delegate onEntryInserted:_curEntry];
        }
    }
}

- (void)initWithMappingEntry:(EShortcutEntry*)entry
{
    self.curEntry = entry;
    
    [self updateEntryDisplay];
}

- (void)updateEntryDisplay
{
    self.window.title = [NSString stringWithFormat:@"Create New"];
    if (_curEntry.key.length > 0) {
        self.window.title = [NSString stringWithFormat:@"Edit %@", _curEntry.key];
    }
    
    [self.txtKey setStringValue:@""];
    if (_curEntry.key.length > 0) {
        [self.txtKey setStringValue:_curEntry.key];
    }

    [self.txtCode setStringValue:@""];
    if (_curEntry.code.length > 0) {
        [self.txtCode setStringValue:_curEntry.code];
    }
    
    _txtKey.delegate = self;
    _txtCode.delegate = self;
    
    [_txtKey becomeFirstResponder];
}

- (void)controlTextDidChange:(NSNotification *)notification {
    NSTextField *textField = [notification object];
    
    if (textField == _txtKey) {
        _curEntry.key = [textField stringValue];
    }
    else if(textField == _txtCode)
    {
        _curEntry.code = [textField stringValue];
    }
}

- (BOOL)control:(NSControl*)control textView:(NSTextView*)textView doCommandBySelector:(SEL)commandSelector
{
    BOOL result = NO;

    if (control == _txtCode) {
        if (commandSelector == @selector(insertNewline:))
        {
            [textView insertNewlineIgnoringFieldEditor:self];
            result = YES;
        }
        else if (commandSelector == @selector(insertTab:))
        {
            [textView insertTabIgnoringFieldEditor:self];
            result = YES;
        }
    }
    
    return result;
}

@end
