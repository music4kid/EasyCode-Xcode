//
//  AppDelegate.h
//  EasyCode
//
//  Created by gao feng on 2016/10/15.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ECMainWindowController;
@interface AppDelegate : NSObject <NSApplicationDelegate>
//icloud
@property (nonatomic, strong) id ubiquityToken;
@property (nonatomic, strong) NSURL *ubiquityURL;
@property (nonatomic, strong) ECMainWindowController* mainController;
+(instancetype)sharedInstance;
@end

