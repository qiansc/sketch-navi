//
//  NVLogin.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/1.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLogin.h"
#import "Util.h"
#import "MSDocument.h"
#import "NVURL.h"
#import "NVUserData.h"
#import "NVSpec.h"

@implementation NVLogin {
    MSDocument *document;
    NSString *cookieFile;
    NSDictionary *userData;
    NSDictionary *config;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    config = [Util loadConfig];
    
    if (config == nil) {
        [Util message:@"插件配置损坏，请联系运营处理..."];
        return;
    }

    [self initLoginPanel];
    [self.codeButton setTarget:self];
    [self.codeButton setAction:@selector(onCodeButtonClick:)];

    [self.loginButton setTarget:self];
    [self.loginButton setAction:@selector(onLoginButtonClick:)];
    
    [self.logoutButton setTarget:self];
    [self.logoutButton setAction:@selector(loginOut:)];
    
    document = [[[NSApplication sharedApplication] orderedDocuments] firstObject];
    cookieFile = [NVUserData cookieFileURL].path;
    
    [self checkLogin];
}

- (void)checkLogin {
    userData = [NVUserData userData];
    if (userData[@"username"]) {
        self.usernameField.stringValue = [NSString stringWithFormat:@"%@%@", userData[@"username"], userData[@"domain"]];
        [self.accountLoginView setHidden:YES];
        [self.accountUserView setHidden:NO];
    } else {
        [self.accountLoginView setHidden:NO];
        [self.accountUserView setHidden:YES];
    }
}

- (void)loginSuccess{
    BOOL ret = [NVUserData saveUserData:@{
        @"username": self.nameField.stringValue,
        @"domain": self.domainButton.selectedItem.title,
        @"source": @"baiduboxapp",
        @"group": @"FC",
        @"version": @"12.1.5"
    }];
    
    BOOL specRet = [NVSpec fetchAllVersion];
    
    if (ret && specRet) {
        [self checkLogin];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SPEC_UPDATE" object:nil userInfo:@{}];
    } else {
        self.infoField.stringValue = @"登录信息获取失败，请联系运营协助...";
        [self.infoView setHidden:NO];
    }
    
}

- (void)initLoginPanel{
    self.nameField.stringValue = @"";
    self.codeField.stringValue = @"";
    self.codeButton.enabled = YES;
    [self setCodeFieldEnabled: NO];
    self.infoView.wantsLayer = YES;
    self.infoView.layer.backgroundColor = [NSColor unemphasizedSelectedContentBackgroundColor].CGColor;
    [self.infoView setHidden:YES];
}


- (void)loginOut:(NSButton*)sender {
    userData = @{};
    BOOL ret = [NVUserData saveUserData:userData];
    if (!ret) {
        self.infoField.stringValue = @"退出登录过程中存在异常，如有需要请联系运营协助...";
    }
    [self initLoginPanel];
    [self checkLogin];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SPEC_UPDATE" object:nil userInfo:@{}];
    
}

- (void)setCodeFieldEnabled:(BOOL) status{
    if (status) {
        self.codeField.editable = YES;
        self.codeField.backgroundColor = [NSColor textBackgroundColor];
    } else {
        self.codeField.editable = NO;
        self.codeField.backgroundColor = [NSColor unemphasizedSelectedContentBackgroundColor];
    }
}

- (void)onLoginButtonClick:(NSButton*)sender {
    if (self.codeField.stringValue.length < 3) {
        [Util message:@"请先获取并输入收到的验证码！"];
        return;
    }
    [self.infoView setHidden:NO];
    self.infoField.textColor = [NSColor secondaryLabelColor];
    self.infoField.stringValue = @"登录中，请稍候...";
    NSString *tpl = [NSString stringWithFormat:@"%@%@", config[@"host"], config[@"loginAPI"]];
    NSString *url = [NSString stringWithFormat:tpl, self.codeField.stringValue];
    [NVURL request:@{
        @"url": url,
        @"cookie-jar": cookieFile
    } completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            self.infoField.stringValue = @"无法连接至账户服务器，请检查网络状态后重试！";
            [self.infoView setHidden:NO];
        } else {
            [self processCodeVerifyResponse:data];
        }
    }];
}

- (void)onCodeButtonClick:(NSButton*)sender {
    if (self.nameField.stringValue.length < 3) {
        self.infoField.stringValue = @"请输入账户！";
        [self.infoView setHidden:NO];
        return;
    }
    [self.infoView setHidden:NO];
    self.infoField.textColor = [NSColor secondaryLabelColor];
    self.infoField.stringValue = @"请求中，请稍候...";
    NSString *tpl = [NSString stringWithFormat:@"%@%@", config[@"host"], config[@"codeAPI"]];
    NSString *mail = [NSString stringWithFormat:@"%@%@", self.nameField.stringValue, @"@baidu.com"];
    NSString *url = [NSString stringWithFormat:tpl, mail];
    [NVURL request:@{
        @"url": url,
        @"cookie-jar": cookieFile
    } completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            self.infoField.stringValue = @"无法连接至账户服务器，请检查网络状态后重试！";
            [self.infoView setHidden:NO];
        } else {
            [self processLoginVerifyResponse:data];
        }
    }];
}

- (void)processCodeVerifyResponse:(NSData*) data {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if (json) {
        if ([json[@"status"] intValue] == 1) {
            self.infoField.stringValue = json[@"msg"] ? json[@"msg"] : json[@"data"];
            [self.infoView setHidden:NO];
        } else if ([json[@"status"] intValue] == 0 && json[@"data"][@"no"]){
            self.infoField.stringValue=@"";
            [self.infoView setHidden:YES];
            [self loginSuccess];
            
        }
    } else {
        self.infoField.stringValue = @"网络或数据返回异常，请稍后重试！";
        [self.infoView setHidden:NO];
    }
}

- (void)processLoginVerifyResponse:(NSData*) data {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if (json && json[@"data"] && json[@"data"][@"no"]) {
        self.infoField.stringValue = [NSString stringWithFormat:@"验证码已经发送！请注意查收（序号：%@）", json[@"data"][@"no"]];
        [self.infoView setHidden:NO];
        [self setCodeFieldEnabled: YES];
    } else {
        self.infoField.stringValue = @"网络或数据返回异常，请稍后重试！";
        [self.infoView setHidden:NO];
    }
}

//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//    }];

// /openapi/uikit/client?action=verifyVersion&version=1.1

@end
