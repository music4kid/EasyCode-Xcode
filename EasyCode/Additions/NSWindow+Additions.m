//
//  NSWindow+Additions.m
//  EasyCode
//
//  Created by lijia on 08/02/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import "NSWindow+Additions.h"

@implementation NSWindow (Additions)
- (void)ec_setCornRadius:(CGFloat)raduis {
    self.contentView.wantsLayer = YES;
    self.contentView.layer.cornerRadius = raduis;
    self.contentView.layer.masksToBounds = YES;
}

- (void)ec_fadeInAnimated:(BOOL)animated {
    [self makeKeyAndOrderFront:nil];
    [self.contentView setNeedsDisplay:YES];
    self.contentView.hidden = NO;
    if (animated) {
        [[NSAnimationContext currentContext] setDuration:0.3];
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
            [[self.contentView animator] setAlphaValue:1.0];
        } completionHandler:nil];
    } else {
        self.contentView.alphaValue = 1.0;
    }
}

- (void)hideDone {
    self.contentView.alphaValue = 0.f;
    self.contentView.hidden = YES;
    [self orderOut:nil];
}

- (void)hideDelayed:(NSNumber*)animated {
    if ([animated boolValue]) {
        [[NSAnimationContext currentContext] setDuration:0.3];
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
            [[self.contentView animator] setAlphaValue:0.02];
        } completionHandler:^{
            [self hideDone];
        }];
    } else {
        [self hideDone];
    }
}

- (void)ec_fadeOutAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideDelayed:) object:@(animated)];
    [self performSelector:@selector(hideDelayed:) withObject:@(animated) afterDelay:delay];
}
@end
