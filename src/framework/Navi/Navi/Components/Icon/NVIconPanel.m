//
//  NVIconPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "HexColor.h"
#import "NVIconPanel.h"
#import "NVIconSource.h"
#import "NVIconCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"
#import "NVBundle.h"
#import "MSSVGImporter.h"
#import "MSDocument.h"
#import "Util.h"



@interface NVIconPanel ()

@end

@implementation NVIconPanel

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
            [self applySpecToSelections: ((NVIconCollectionItemView *)box).spec];
            [self updateTitle: ((NVIconCollectionItemView *)box).spec.code];
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle:nil];
}

-(void)updateTitle:(NSString*) title{
    self.headerView.controller.infoButton.title = title;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.dataSource;
}

- (void)selectionChange:(MSLayerArray *) layers {}

/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVIconSpec) spec {
    if (spec.code == nil) return;

    MSSVGImporter *importer = [[[NVBundle SketchControllersBundle] classNamed:@"MSSVGImporter"] svgImporter];
    NSData *svgData = [spec.svg dataUsingEncoding: NSUTF8StringEncoding];
    [importer prepareToImportFromData: svgData];
    MSLayer *svgLayer = [importer importAsLayer];
    [svgLayer setName:@"SVG Layer"];
    svgLayer.frame.width = spec.width;
    svgLayer.frame.height = spec.height;
    
    MSDocument *document = [[NSDocumentController sharedDocumentController] currentDocument];
    CGPoint center;
    if (document.currentPage && document.currentPage.currentArtboard) {
        [document.currentPage.currentArtboard addLayer:svgLayer];
    } else {
        [[document currentPage] addLayer:svgLayer];
    }

    MSCanvasView *canvasView = document.contentDrawView;
    center = [canvasView viewCenterInAbsoluteCoordinatesForViewPort:[canvasView viewPort]];
    float shiftX = svgLayer.frame.width / 2;
    float shiftY = svgLayer.frame.height / 2;
    float centerX = center.x - shiftX;
    float centerY = center.y - shiftY;
    CGPoint point = {.x=centerX,.y=centerY};
    [Util position:svgLayer at: point];
    [self.collectionView.toggleDelegate clearActive];
    
    [NVUserInfo fromLayer:svgLayer].iconCode = spec.code;
    
}


@end
