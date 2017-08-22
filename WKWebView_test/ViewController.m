//
//  ViewController.m
//  WKWebView_test
//
//  Created by 王克博 on 2017/8/22.
//  Copyright © 2017年 wkb. All rights reserved.
//

#define defScreenHeight [UIScreen mainScreen].bounds.size.height
#define defScreenWidth [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import <WebKit/WebKit.h>       //使用wkWebView需要引用库

@interface ViewController ()

@property (strong, nonatomic) WKWebView * wkWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //懒得写导航条
    UILabel * navView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, defScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    navView.textColor = [UIColor blackColor];
    navView.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    navView.text = @"WKWebView学习";
    navView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:navView];
    
    NSString * htmlStr = [NSString stringWithFormat:@"%@",@"<button onclick=\"window.webkit.messageHandlers.close.postMessage('alert')\">Copy 点击出现弹框</button>"];
                          
    //WKWebView创建
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.minimumFontSize = 18;
    
    _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, defScreenWidth, defScreenWidth) configuration:config];
//    NSURL * url = [NSURL URLWithString:@"https://testshare.startvshow.com/starshow5.0/news/v5/detail.html?new_id=7944"];
//    NSURL * url = [NSURL URLWithString:htmlStr];
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    [_wkWebView loadRequest:request];
    [_wkWebView loadHTMLString:htmlStr baseURL:nil];
    [self.view addSubview:_wkWebView];
    
    
    [config.userContentController addScriptMessageHandler:self name:@"close"];
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alert" message:[NSString stringWithFormat:@"点击了js中的按钮!\n方法名为：%@\n传递的参数为：%@",message.name,message.body] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
