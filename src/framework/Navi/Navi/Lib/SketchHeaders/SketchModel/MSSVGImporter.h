//
//  MSSVGImporter.h
//  Navi
//
//  Created by QIANSC on 2020/11/30.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

@class NSString, SVGElement, SVGImporter;

@interface MSSVGImporter : NSObject
{
    SVGImporter *_importer;
    SVGElement *_graph;
}

+ (id)svgImporter;
@property(retain, nonatomic) SVGElement *graph; // @synthesize graph=_graph;
@property(retain, nonatomic) SVGImporter *importer; // @synthesize importer=_importer;
- (BOOL)shouldCollapseSinglePage;
- (BOOL)shouldExpandPages;
- (id)secondPhaseSubtitleForValue:(long long)arg1 maximum:(long long)arg2;
- (id)firstPhaseSubtitle;
- (void)finishImporting;
- (void)scale:(double)arg1 rootGroup:(id)arg2;
- (id)importAsLayer;
- (void)importIntoPage:(id)arg1 name:(id)arg2 progress:(id)arg3;
- (unsigned long long)prepareToImportFromXMLString:(id)arg1;
- (unsigned long long)prepareToImportFromData:(id)arg1;
- (unsigned long long)prepareToImportFromURL:(id)arg1 error:(id *)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
