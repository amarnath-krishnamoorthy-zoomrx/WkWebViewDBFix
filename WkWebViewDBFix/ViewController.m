//
//  ViewController.m
//  WkWebViewDBFix
//
//  Created by amar tk on 15/09/14.
//  Copyright (c) 2014 StartKoding. All rights reserved.
//

#import "ViewController.h"

#define APPLICATION_DOC_DIRECTORY                   [NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]]


@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    [self copyIndexFile];
    [self loadWkWebview];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)copyIndexFile
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/index.html", APPLICATION_DOC_DIRECTORY]]) {
        NSError *error;
        if (![[NSFileManager defaultManager] copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"index.html"] toPath:[NSString stringWithFormat:@"%@/index.html", APPLICATION_DOC_DIRECTORY] error:&error]) {
            NSLog(@"File copy error : %@", error);
        }
    }
}

-(void) loadWkWebview
{
    WKWebViewConfiguration *wkWebViewConfiguration = [[WKWebViewConfiguration alloc] init];
    [wkWebViewConfiguration.userContentController addScriptMessageHandler:self name:@"handlerName"];
    
    CGRect webViewFrame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    _nextWkView = [[WKWebView alloc] initWithFrame:webViewFrame configuration:wkWebViewConfiguration];
    [self.view addSubview:_nextWkView];
    
    NSString *indexPage = [NSString stringWithFormat:@"%@/index.html", APPLICATION_DOC_DIRECTORY];
    NSURL *url = [NSURL fileURLWithPath:indexPage];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [_nextWkView loadRequest:request];
    
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"JS Message :%@", (NSDictionary *)message.body);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
