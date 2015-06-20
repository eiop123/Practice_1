//
//  TextViewController.m
//  DispBBS_1
//
//  Created by ChangHsaio ni on 2015/6/21.
//  Copyright (c) 2015年 ChangHsaio ni. All rights reserved.
//

#import "TextViewController.h"
#import "AFNetworking.h"
#import "UIWebView+AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation TextViewController
- (void)viewDidLoad {
    self.webView.delegate=self;

    [super viewDidLoad];
    NSURL *url=[NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:urlRequest progress:nil success:^NSString *(NSHTTPURLResponse *response,NSString *HTML){
        return HTML;
    } failure:^(NSError *error){
        NSLog(@"error:%@",[error localizedDescription] );
    }
     
     ];
    
   
}

#pragma UIdelegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [AFNetworkActivityIndicatorManager.sharedManager incrementActivityCount];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [AFNetworkActivityIndicatorManager.sharedManager decrementActivityCount ];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [AFNetworkActivityIndicatorManager.sharedManager decrementActivityCount];
}

@end
