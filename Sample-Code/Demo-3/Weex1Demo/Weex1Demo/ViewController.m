//
//  ViewController.m
//  Weex1Demo
//
//  Created by kai on 16/10/9.
//  Copyright © 2016年 kai. All rights reserved.
//

#import "ViewController.h"
#import <WeexSDK/WeexSDK.h>

@interface ViewController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;

@end

@implementation ViewController {
    NSURL *jsUrl;
}

- (instancetype)initWithJs:(NSString *)filePath {
    self = [super init];
    if (self) {
        NSString *path=[NSString stringWithFormat:@"file://%@/js/%@",[NSBundle mainBundle].bundlePath,filePath];
        NSLog(@"-----path:%@",path);
        jsUrl=[NSURL URLWithString:path];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = self.view.frame;
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    _instance.onFailed = ^(NSError *error) {
        NSLog(@"xxxx");
    };
    _instance.renderFinish = ^(UIView *view) {
        NSLog(@"finish");
    };
    
    if (!jsUrl) {
        return;
    }
    [_instance renderWithURL:jsUrl];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_instance destroyInstance];
}

@end
