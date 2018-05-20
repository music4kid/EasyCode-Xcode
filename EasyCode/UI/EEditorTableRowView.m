//
//  EEditorTableRowView.m
//  EasyCode
//
//  Created by lijia on 20/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import "EEditorTableRowView.h"

@implementation EEditorTableRowView
- (void)drawSelectionInRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        NSRect selectionRect = NSInsetRect(self.bounds, 0, 0);
//        [[NSColor colorWithCalibratedWhite:.65 alpha:1.0] setStroke];
        [[NSColor lightGrayColor] setFill];
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:0 yRadius:0];
        [selectionPath fill];
        [selectionPath stroke];
    }
}
@end
