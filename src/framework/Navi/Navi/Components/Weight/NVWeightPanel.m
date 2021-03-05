//
//  NVWeightPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "HexColor.h"
#import "NVWeightPanel.h"
#import "NVWeightSource.h"
#import "NVWeightCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSTextLayer.h"
#import "MSLayerArray.h"
#import "MSTextLayer.h"

@interface NVWeightPanel ()

@end

@implementation NVWeightPanel

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView.toggleDelegate afterReload:^(void){
        // 一般是数据更新时 整体重绘 需要根据选中项重新选择
         [self selectionChange:self.selections];
    }];

    [self.collectionView.toggleDelegate onChange:^(NVToggleBox * box) {
        // 选择变化时 应用到selections 且改更新title
        if (box == nil) {
            [self updateTitle:nil];
        }else{
            [self applySpecToSelections: ((NVWeightCollectionItemView *)box).spec];
            [self updateTitle: ((NVWeightCollectionItemView *)box).spec.code];
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle:nil];
    // 切换模式
    [self.modeButton setTarget:self];
    [self.modeButton setAction:@selector(modeButtonClick:)];
}

-(void)modeButtonClick:(NSSegmentedControl*) button{
    // [self.collectionView.source setMode: button.selectedSegment];
}

-(void)updateTitle:(NSString*) title{
    self.headerView.controller.infoButton.title = title;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.dataSource;
}

- (void)selectionChange:(MSLayerArray *) layers {
    self.selections = layers;
    if (layers != nil && layers.firstLayer != nil){
        [self.collectionView.dataSource setShapeMode:[layers.firstLayer className]];
    }

    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    NSString *title = nil;
    for(MSLayer *layer in layers) {
        if (![NVLayer isTextLayer:layer]){
            continue;
        }
        NSString* fontWeightCode = [NVUserInfo fromLayer:layer].fontWeightCode;
        // for(NSString *textCode in textCodes) {
            for(NSView *view in self.collectionView.subviews) {
                if ([view isKindOfClass:[NVToggleBox class]]) {
                    NVWeightCollectionItemView *item = ((NVWeightCollectionItemView *)view);
                    if([item.spec.code isEqual:fontWeightCode]) {
                        // 找到和specCode对应的indexPath
                        [indexPaths addObject: item.indexPath];
                        // 校准一下颜色s
                        // [self applyColor:NSColorFromRGBString(item.spec.defaultColor) toLayer:layer];
                        [self applyWeight:item.spec.iosFont toLayer:layer];
                        title = item.spec.code;
                    }
                }
            }
        // }
    }
    [self.collectionView.toggleDelegate clearActive];
    if (indexPaths.count > 0) {
        [self.collectionView.toggleDelegate setActives:indexPaths];
        if (indexPaths.count == 1) // 当选中项>2时候 不显示title
            [self updateTitle:title];
    }
}

/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVWeightSpec) spec {
    if (self.selections) {
        for(MSLayer *layer in self.selections) {
            if ([NVLayer isTextLayer:layer]) {
                [NVUserInfo fromLayer:layer].fontWeightCode = spec.code;
            }
            // [self applyColor:NSColorFromRGBString(spec.defaultColor) toLayer:layer];
            [self applyWeight:spec.iosFont toLayer:layer];
        }
    }
}

/* 应用color到图层上 */
-(void)applyWeight:(double) fontWeight toLayer:(MSTextLayer*) layer{
    if ([NVLayer isTextLayer:layer]) {
        // layer.fontSize = fontSize;
//        NSFontManager *manager = [NSFontManager sharedFontManager];

//        NSLog(@"### font1 %ld %f", (long)[manager weightOfFont:layer.font], fontWeight / 100);
//        // NSFont *f = layer.font;
//        [self setWeight:fontWeight / 100 toFont:layer.font];
//        // layer.font = f;
//
        
        NSMutableDictionary *attr = [[layer.font fontDescriptor].fontAttributes mutableCopy];
        if (fontWeight > 500) {
            [attr setValue:@"PingFangSC-Medium" forKey:@"NSFontNameAttribute"];
        } else {
            [attr setValue:@"PingFangSC-Regular" forKey:@"NSFontNameAttribute"];
        }
        NSFontDescriptor *fontDescriptor = [NSFontDescriptor fontDescriptorWithFontAttributes: attr];
        NSFont *font = [NSFont fontWithDescriptor: fontDescriptor size: layer.fontSize];

        layer.font =  font;
        
    }
}

-(void)setWeight:(int)weight toFont:(NSFont*)font{
   NSFontManager *manager = [NSFontManager sharedFontManager];
   long currentWeight = [manager weightOfFont:font];
   while( currentWeight != weight )
   {
      if( currentWeight >= weight )
      {
         [manager convertWeight:NO ofFont:font];
         currentWeight--;
      }
      else
      {
          [manager convertWeight:YES ofFont:font];
          currentWeight++;
      }
   }
}


/* 应用color到图层上 */
-(void)applyColor:(NSColor*) color toLayer:(MSTextLayer*) layer{
    if ([NVLayer isTextLayer:layer]) {
        MSColor *c = layer.textColor;
        c.red = color.redComponent;
        c.green = color.greenComponent;
        c.blue = color.blueComponent;
        layer.textColor = c;
    }
}


@end
