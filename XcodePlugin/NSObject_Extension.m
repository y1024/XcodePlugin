//
//  NSObject_Extension.m
//  XcodePlugin
//
//  Created by 杜晓星 on 16/1/11.
//  Copyright © 2016年 杜晓星. All rights reserved.
//


#import "NSObject_Extension.h"
#import "XcodePlugin.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[XcodePlugin alloc] initWithBundle:plugin];
        });
    }
}
@end
