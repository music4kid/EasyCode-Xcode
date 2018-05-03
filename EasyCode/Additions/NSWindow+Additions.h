//
//  NSWindow+Additions.h
//  EasyCode
//
//  Created by lijia on 08/02/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSWindow (Additions)
- (void)ec_setCornRadius:(CGFloat)raduis;
- (void)ec_fadeInAnimated:(BOOL)animated;
- (void)ec_fadeOutAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;
@end
