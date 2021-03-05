//
//  MSLayoutGrid.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

@interface MSLayoutGrid : NSObject
{
}

- (void)setColumnWidth:(double)arg1;
- (void)setGutterWidth:(double)arg1;
- (long long)totalNumberOfGutters;
- (void)setGuttersOutside:(BOOL)arg1;
- (void)setTotalWidth:(double)arg1;
- (void)setNumberOfColumns:(double)arg1;
- (void)determineAppropriateColumnWidth;
- (id)verticalGuidesForRulerData:(id)arg1 inRect:(struct CGRect)arg2;
- (id)horizontalGuidesForRulerData:(id)arg1 inRect:(struct CGRect)arg2;

@end

