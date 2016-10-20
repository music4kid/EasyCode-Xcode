//
//  EditorWindowController.m
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "EditorWindowController.h"
#import "ESharedUserDefault.h"
#import "EShortcutEntry.h"
#import "DetailWindowController.h"

@interface EditorWindowController () <NSTableViewDataSource, NSTabViewDelegate, DetailWindowEditorDelegate, NSWindowDelegate>
@property (nonatomic, strong) NSMutableDictionary*                  mappingDic;
@property (nonatomic, strong) NSMutableArray*                       mappingList;
@property (nonatomic, assign) EditorType                            editorType;

@property (nonatomic, strong) NSImage*                 imgEdit;
@property (nonatomic, strong) NSImage*                 imgAdd;
@property (nonatomic, strong) NSImage*                 imgRemove;

@property (nonatomic, strong) DetailWindowController*               detailEditor;

@end

@implementation EditorWindowController

- (void)initEditorWindow:(EditorType)editorType {
    self.editorType = editorType;
    
    self.imgEdit = [NSImage imageNamed:@"edit"];
    self.imgAdd = [NSImage imageNamed:@"add"];
    self.imgRemove = [NSImage imageNamed:@"remove"];
    
    self.mappingList = @[].mutableCopy;
    
    if (_editorType == EditorTypeOC) {
        self.mappingDic = [_UD readMappingForOC].mutableCopy;
        self.window.title = @"Objective-C";
    }
    else if(_editorType == EditorTypeSwift)
    {
        self.mappingDic = [_UD readMappingForSwift].mutableCopy;
        self.window.title = @"Swift";
    }
    
    NSArray* keys = self.mappingDic.allKeys;
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString* str1 = obj1;
        NSString* str2 = obj2;
        return [str1 compare:str2];
    }];
    for (NSString* key in keys) {
        EShortcutEntry* entry = [EShortcutEntry new];
        entry.key = key;
        entry.code = _mappingDic[key];
        [_mappingList addObject:entry];
    }
    [self sortMappingList];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [_tableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
    
    self.window.delegate = self;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    NSInteger selectedRow = [_tableView selectedRow];
    NSTableRowView *myRowView = [_tableView rowViewAtRow:selectedRow makeIfNecessary:NO];
    [myRowView setEmphasized:NO];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    EShortcutEntry* entry = _mappingList[row];
    
    if( [tableColumn.identifier isEqualToString:@"cShortcut"] )
    {
        cellView.textField.stringValue = entry.key;
        return cellView;
    }
    if( [tableColumn.identifier isEqualToString:@"cCode"] )
    {
        cellView.textField.stringValue = entry.code;
        cellView.textField.textColor = [NSColor colorWithWhite:0.5 alpha:1];
        return cellView;
    }
    if( [tableColumn.identifier isEqualToString:@"cEditCode"] )
    {
        NSButton* btn = (NSButton*)cellView;
        btn.image = _imgEdit;
        [btn setTarget:self];
        [btn setAction:@selector(onEditCodeClick:)];
        return cellView;
    }
    if( [tableColumn.identifier isEqualToString:@"cAdd"] )
    {
        NSButton* btn = (NSButton*)cellView;
        btn.image = _imgAdd;
        [btn setTarget:self];
        [btn setAction:@selector(onAddEntryClick:)];
        return cellView;
    }
    if( [tableColumn.identifier isEqualToString:@"cRemove"] )
    {
        NSButton* btn = (NSButton*)cellView;
        btn.image = _imgRemove;
        [btn setTarget:self];
        [btn setAction:@selector(onRemoveEntryClick:)];
        return cellView;
    }
    
    return cellView;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.mappingList count];
}

- (void)onEditCodeClick:(id)sender
{
    NSButton* btn = sender;
    NSInteger row = [_tableView rowForView:btn];
    EShortcutEntry* entry = _mappingList[row];
    if (entry) {
        [self.detailEditor initWithMappingEntry:entry];
        self.detailEditor.editMode = DetailEditorModeUpdate;
        [self.detailEditor showWindow:self];
    }
}

- (void)onAddEntryClick:(id)sender
{
    EShortcutEntry* entry = [EShortcutEntry new];
    [self.detailEditor initWithMappingEntry:entry];
    self.detailEditor.editMode = DetailEditorModeInsert;
    [self.detailEditor showWindow:self];
}

- (void)onRemoveEntryClick:(id)sender
{
    NSButton* btn = sender;
    NSInteger row = [_tableView rowForView:btn];
    EShortcutEntry* entry = _mappingList[row];
    if (entry) {
        [_mappingList removeObject:entry];
        [self sortMappingList];
        [_tableView reloadData];
        
        [self saveMapping];
    }
}

- (DetailWindowController*)detailEditor
{
    if (_detailEditor == nil) {
        self.detailEditor = [[DetailWindowController alloc] initWithWindowNibName:@"DetailWindowController"];
        _detailEditor.delegate = self;
    }
    return _detailEditor;
}

#pragma mark - DetailWindowEditorDelegate
- (void)onEntryInserted:(EShortcutEntry*)entry {
    if (entry.key.length > 0 && entry.code.length > 0) {
        [_mappingList addObject:entry];
        [self sortMappingList];
        [_tableView reloadData];
        
        [self saveMapping];
    }
}

- (void)onEntryUpdated:(EShortcutEntry*)entry {
    [self sortMappingList];
	[_tableView reloadData];
    
    [self saveMapping];
}

- (void)windowWillClose:(NSNotification *)notification
{
    [self saveMapping];
}

#pragma mark - Other
- (void)saveMapping
{
    NSMutableDictionary* newMapping = @{}.mutableCopy;
    for (EShortcutEntry* entry in _mappingList) {
        [newMapping setObject:entry.code forKey:entry.key];
    }
    
    if (_editorType == EditorTypeOC) {
        [_UD saveMappingForOC:newMapping];
    }
    else if(_editorType == EditorTypeSwift)
    {
        [_UD saveMappingForSwift:newMapping];
    }
}

- (void)sortMappingList
{
    if (_mappingList.count == 0) {
        EShortcutEntry* testEntry = [EShortcutEntry new];
        testEntry.key = @"key";
        testEntry.code = @"code";
        [_mappingList addObject:testEntry];
    }
    
    [_mappingList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        EShortcutEntry* entry1 = obj1;
        EShortcutEntry* entry2 = obj2;
        return [entry1.key compare:entry2.key];
    }];
}

@end
