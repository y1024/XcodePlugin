//
//  XcodePlugin.m
//  XcodePlugin
//
//  Created by 杜晓星 on 16/1/11.
//  Copyright © 2016年 杜晓星. All rights reserved.
//

#import "XcodePlugin.h"
#import "Xcode3TargetMembershipDataSource+Hook.h"
#import "NSView+Hierarchy.h"

@interface XcodePlugin()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation XcodePlugin

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPluginsMenu) name:NSMenuDidChangeItemNotification object:nil];
 
        [Xcode3TargetMembershipDataSource hook];
        
    }
    return self;
}


- (void)addPluginsMenu
{
    NSMenu *mainMenu = [NSApp mainMenu];
    if (!mainMenu) {
        return;
    }
    // 增加一个"Plugins"菜单到"Window"菜单前面
    NSMenuItem *pluginsMenuItem = [mainMenu itemWithTitle:@"Plugins"];
    if (!pluginsMenuItem) {
        pluginsMenuItem = [[NSMenuItem alloc] init];
        pluginsMenuItem.title = @"Plugins";
        pluginsMenuItem.submenu = [[NSMenu alloc] initWithTitle:pluginsMenuItem.title];
        NSInteger windowIndex = [mainMenu indexOfItemWithTitle:@"Window"];
        [mainMenu insertItem:pluginsMenuItem atIndex:windowIndex];
    }
    [self addAutoAllTargetsMenuItemWith:pluginsMenuItem];
    
//    [self addSandboxMenuItemWith:pluginsMenuItem];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSMenuDidChangeItemNotification object:nil];
}
/**
 *  添加 自动链接所有target item
 *
 *  @param pluginsMenuItem
 */
- (void)addAutoAllTargetsMenuItemWith:(NSMenuItem*)pluginsMenuItem
{
    NSMenuItem *subMenuItem = [[NSMenuItem alloc] init];
    subMenuItem.title = @"AutoAdd  All Targets";
    subMenuItem.target = self;
    subMenuItem.action = @selector(toggleMenu:);
    subMenuItem.state = NSOnState;
    [pluginsMenuItem.submenu addItem:subMenuItem];
}

- (void)addSandboxMenuItemWith:(NSMenuItem*)pluginsMenuItem
{
    NSMenuItem *subMenuItem = [[NSMenuItem alloc] init];
    subMenuItem.title = @"Sandbox";
    subMenuItem.target = self;
    subMenuItem.action = @selector(SandboxMenuClick);
    [pluginsMenuItem.submenu addItem:subMenuItem];
}


- (void)toggleMenu:(NSMenuItem *)menuItem
{
    //改变菜单选中状态
    menuItem.state = !menuItem.state;
    
    //重新交换函数
    [Xcode3TargetMembershipDataSource hook];
    
    [[[NSApp mainWindow] contentView] dumpWithIndent:@""];
}

- (void)SandboxMenuClick
{
}

#pragma mark - Open Finder
- (void)openFinderWithFilePath:(NSString *)path{
    if (!path.length) {
        return ;
    }
    NSString *open = [NSString stringWithFormat:@"open %@",path];
    const char *str = [open UTF8String];
    system(str);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
