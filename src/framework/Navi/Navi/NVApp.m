//
//  NVApp.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/10.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVApp.h"
#import "NVAppCache.h"

@implementation NVApp{
    MSDocument * document;
}
+(instancetype)prepareInit{
    NVApp * app = [NVApp new];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:app selector:@selector(delayInit) userInfo:nil repeats:NO];
    return app;
}

+(instancetype)currentApp{
    MSDocument* doc = [[NSDocumentController sharedDocumentController] currentDocument];
    if (doc){
        NVApp *app = [NVAppCache getAppWith:doc];
        if (app) {
            return app;
        }
        return [[NVApp alloc] initWithCurrentDocument];
    }
    return nil;
}


-(void)delayInit{
    [self initWithCurrentDocument];
    [self startUp];
}

-(instancetype)initWithCurrentDocument{
    document = [[NSDocumentController sharedDocumentController] currentDocument];
    [NVAppCache cacheApp:self with:document];
    return self;
}

-(void)startUp{
    
}

@end
