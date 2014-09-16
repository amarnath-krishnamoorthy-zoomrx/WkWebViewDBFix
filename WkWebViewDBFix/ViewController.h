//
//  ViewController.h
//  WkWebViewDBFix
//
//  Created by amar tk on 15/09/14.
//  Copyright (c) 2014 StartKoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController<WKScriptMessageHandler>

@property(nonatomic, strong) WKWebView *nextWkView;


@end

