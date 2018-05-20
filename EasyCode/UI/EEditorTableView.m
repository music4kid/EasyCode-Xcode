//
//  EEditorTableView.m
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "EEditorTableView.h"
#import "EEditorTableMenu.h"

@implementation EEditorTableView
-(NSMenu*)menuForEvent:(NSEvent*)event {
    [[self window] makeFirstResponder:self];
    NSPoint menuPoint = [self convertPoint:[event locationInWindow] fromView:nil];
    NSInteger row = [self rowAtPoint:menuPoint];
    if (row != -1) {
        NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:row];
        [self selectRowIndexes:indexSet byExtendingSelection:NO];
        return [self menu];
    } else {
        return [super menu];
    }
}


@end
