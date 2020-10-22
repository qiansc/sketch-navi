//
//  NVColorPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorPanel.h"
#import "NVCollectionController.h"
#import "NVColorSource.h"
#import "NVColorCollectionItemView.h"
#import "HexColor.h"

@interface NVColorPanel ()

@end

@implementation NVColorPanel {
    NVColorSpec spec;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建NVCollectionController 并把他的视图指向到xib存在的那个collectionView上去
    NVCollectionController *c = [[NVCollectionController alloc]init];
    [c setCollectionView: self.collectionView];
    // 绑定重绘
    c.afterResize = ^(float width, float height) {
        [self resetConstraint];
    };
    [self.collectionView.toggleDelegate onChange:^(NVToggleBox * box) {
        if (box == nil) {
            spec.specCode = nil;
        }else{
            /**下面代码临时实现 还要重构 */
            spec = ((NVColorCollectionItemView *)box).spec;
            if (self.selections) {
                for(MSLayer *layer in self.selections) {
                    NSMutableDictionary *d = [NSMutableDictionary new];
                    d[@"colorCode"] = spec.specCode;
                    layer.userInfo = d;
                    NSColor *color = NSColorFromRGBString(spec.hex);
                    if (layer.style.fills[0]) {
                        layer.style.fills[0].color.red = color.redComponent;
                        layer.style.fills[0].color.green = color.greenComponent;
                        layer.style.fills[0].color.blue = color.blueComponent;
                    }
                }
            }
        }
        [self update];
    }];
    if (self.selections == nil) self.selections = @[];
    [self update];
}

-(void)update {
    self.headerView.infoButton.title = spec.specCode;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.source;
}

- (void)selectionChange:(NSArray<MSLayer*>*) layers {
    /*下面代码临时实现 还要重构 */
    self.selections = layers;

    NSIndexPath *indexPath = nil;
    for(MSLayer *layer in layers) {
        if(layer.userInfo && layer.userInfo[@"colorCode"]) {
            NSString *colorCode = layer.userInfo[@"colorCode"];
            for(NSView *view in self.collectionView.subviews) {
                if ([view isKindOfClass:[NVColorCollectionItemView class]]) {
                    if([((NVColorCollectionItemView *)view).spec.specCode isEqual:colorCode]) {
                        indexPath = ((NVColorCollectionItemView *)view).indexPath;
                    }
                }
            }
            
            NSColor *color = NSColorFromRGBString(colorCode);
            if (layer.style.fills[0]) {
                layer.style.fills[0].color.red = color.redComponent;
                layer.style.fills[0].color.green = color.greenComponent;
                layer.style.fills[0].color.blue = color.blueComponent;
            }
        }
    }
    
    if (indexPath) {
        [self.collectionView.toggleDelegate setActive:indexPath];
    } else {

        [self.collectionView.toggleDelegate clearActive];
    }
}

@end
