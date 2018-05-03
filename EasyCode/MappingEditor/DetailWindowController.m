//
//  DetailWindowController.m
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "DetailWindowController.h"

@interface DetailWindowController () <NSTextFieldDelegate, NSWindowDelegate, NSControlTextEditingDelegate>
@property (nonatomic, strong) ECSnippetEntry*                 curEntry;
@end

@implementation DetailWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    _edited = NO;
    
    [self updateEntryDisplay];
    self.window.delegate = self;
    [self.window center];
}

- (void)windowWillClose:(NSNotification *)notification
{
    if (_delegate) {
        if (_editMode == DetailEditorModeUpdate) {
            [_delegate onSnippetUpdated:_curEntry];
        }
        else if(_editMode == DetailEditorModeInsert)
        {
            [_delegate onSnippetInserted:_curEntry];
        }
    }
    _edited = NO;
}

- (void)initWithEntry:(ECSnippetEntry*)entry
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
        NSString* changedValue = [textField stringValue];
        if ([_curEntry.key isEqualToString:changedValue] == NO) {
            _edited = YES;
        }
        _curEntry.key = changedValue;
    }
    else if(textField == _txtCode)
    {
        NSString* changedValue = [textField stringValue];
        if ([_curEntry.code isEqualToString:changedValue] == NO) {
            _edited = YES;
        }
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

- (void)setEditMode:(DetailEditorMode)editMode {
    _editMode = editMode;
    if (_editMode == DetailEditorModeUpdate) {
        [_txtCode becomeFirstResponder];
    } else {
        [_txtKey becomeFirstResponder];
    }
}
@end
