//
//  NVApp.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/10.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVApp.h"
#import "MSDocument.h"

@implementation NVApp{
    MSDocument * document;
}

static NSMutableDictionary *cache;

+(instancetype)prepareInit{
    NVApp * app = [NVApp new];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:app selector:@selector(delayInit) userInfo:nil repeats:NO];
    return app;
}

+(instancetype)currentApp{
    MSDocument* doc = [[NSDocumentController sharedDocumentController] currentDocument];
    if (doc){
        NVApp *app = [NVApp getAppWith:doc];
        if (app) {
            return app;
        }
        return [[NVApp alloc] initWithCurrentDocument];
    }
    return nil;
}


-(instancetype)initWithCurrentDocument{
    document = [[NSDocumentController sharedDocumentController] currentDocument];
    [NVApp cacheApp:self with:document];
    return self;
}

-(void)startUp{
    
}

-(void)delayInit{
    [self initWithCurrentDocument];
    [self startUp];
}

+(void)cacheApp:(NVApp*) app with:(MSDocument*) document {
    if (cache == nil) cache = [NSMutableDictionary new];
    NSString * key = [NSString stringWithFormat:@"%lu",[document hash]];
    cache[key] = app;
}
+(instancetype)getAppWith:(MSDocument*) document {
    NSString * key = [NSString stringWithFormat:@"%lu",[document hash]];
    return cache[key];
}

@end
