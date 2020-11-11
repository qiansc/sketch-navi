//
//  MSGradient.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/10.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

@interface MSGradient: NSObject

@property(retain, nonatomic) NSMutableArray *stops; // @synthesize stops=_stops;
@property(nonatomic) struct CGPoint to; // @synthesize to=_to;
@property(nonatomic) long long gradientType; // @synthesize gradientType=_gradientType;
@property(nonatomic) struct CGPoint from; // @synthesize from=_from;
@property(nonatomic) double elipseLength; // @synthesize elipseLength=_elipseLength;

@end


@interface MSGradientStop: NSObject

@property(retain, nonatomic) MSColor *color; // @synthesize color=_color;
@property(nonatomic) double position;

@end
