//
//  MenuController.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Menu.h"
#import "Config.h"

@implementation Menu

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPreferredContentSize:CGSizeMake(40, 450)];
    [self.view setAutoresizingMask:NSViewNotSizable];
    [self initButton];
}
-  (void)viewWillLayout {
//    [self setPreferredContentSize:CGSizeMake(40, 450)];
//    self.view.window.contentMinSize = CGSizeMake(40, 450);
//    self.view.window.contentMaxSize = CGSizeMake(40, 450);
    if (self.delegate) {
        [self.delegate viewWillLayoutSize:[NSString stringWithFormat:@"%f,%f", self.view.frame.size.width, self.view.frame.size.height]];
    }
}

+ (instancetype)viewControllerFromNIB {
    
    // 这里一般都写 bundle:[NSBundle mainBundle] 但是以framework形式加载时候会出错
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    
    return[[Menu alloc] initWithNibName:@"Menu" bundle:resourceBundlePath];
    // return [[MenuController alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    // [[NSBundle mainBundle] loadNibNamed:@"MenuBtn" owner:self topLevelObjects:nil];
}
- (void)viewDidAppear{
//    [self.view setFrameSize:NSMakeSize(40, 450)];
//    [self setPreferredContentSize:CGSizeMake(40, 450)];
//    self.view.window.contentMinSize = CGSizeMake(40, 450);
//    self.view.window.contentMaxSize = CGSizeMake(40, 450);
}
- (void)didReceiveMemoryWarning {
    // [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillTransitionToSize:(NSSize)newSize {
    
}

- (void)initButton {

    [self.headStack addView:[Util separtorBox] inGravity: NSStackViewGravityBottom];

    NSBundle *frameworkBundle = [NSBundle bundleForClass:[Menu class]];

    NSArray<NSDictionary*>* options = [Config MenuOption];
    
    for(NSDictionary *option in options) {

        NSString *id = option[@"id"];
        NSURL *iconUrl = [NSURL fileURLWithPath:[frameworkBundle pathForResource: id ofType:@"png"]];
        NSURL *activeUrl = [NSURL fileURLWithPath:[frameworkBundle pathForResource:  [id stringByAppendingFormat:@"%@", @"-active"] ofType:@"png"]];

        NSButton *button = [self createButton:option[@"name"] icon: iconUrl activeIcon: activeUrl];

        NSStackViewGravity gravity = option[@"gravity"] ? [option[@"gravity"] longValue] : NSStackViewGravityTop;

        [self.headStack addView:button inGravity: gravity];
        [self.headStack addView:[Util separtorBox] inGravity: gravity];

        button.identifier = id;

        [button setTarget:self];
        [button setAction:@selector(buttonClick:)];

        if([id  isEqual: @"main"]) {
            self.mainButton = button;
        }

    }
}

-(void)buttonClick:(NSButton*)button {
    if (self.delegate) {
        [self.delegate onButtonClick: button];
    }
}

- (NSButton*)createButton:(NSString*) name icon: (NSURL *) iconUrl activeIcon:(NSURL *) activeIconUrl {
    NSButton *button = [[NSButton alloc]initWithFrame:NSMakeRect(0, 0, 40, 40)];
    [button setImage:[Util createImage:iconUrl withSize: NSMakeSize(40, 40)]];
    [button setAlternateImage:[Util createImage:activeIconUrl withSize: NSMakeSize(40, 40)]];
    [button setBordered:NO];
    [button sizeToFit];
    [button setToolTip: name];
    [button setButtonType: NSButtonTypeToggle]; //NSButtonTypeMomentaryChange
    return button;
}

@end
