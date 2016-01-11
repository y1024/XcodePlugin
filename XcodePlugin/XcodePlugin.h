//
//  XcodePlugin.h
//  XcodePlugin
//
//  Created by 杜晓星 on 16/1/11.
//  Copyright © 2016年 杜晓星. All rights reserved.
//

#warning /Users/duxiaoxing/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins 插件存放地址

#import <AppKit/AppKit.h>

@class XcodePlugin;

static XcodePlugin *sharedPlugin;

@interface XcodePlugin : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end