//
//  NSAlert+Additions.m
//  EasyCode
//
//  Created by lijia on 20/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import "NSAlert+Additions.h"

@implementation NSAlert (Additions)
+(instancetype)ec_alertWithStyle:(NSAlertStyle)alertStyle
                     messageText:(NSString *)message
                 informativeText:(NSString *)informative
                     buttonTitle:(NSString *)firstTitle,... {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = message;
    alert.informativeText = informative;
    alert.alertStyle = alertStyle;
    va_list args;
    va_start(args, firstTitle);
    for (NSString *arg = firstTitle; arg != nil; arg = va_arg(args, NSString*))
    {
        [alert addButtonWithTitle:arg];
    }
    va_end(args);
    return alert;
}
@end
