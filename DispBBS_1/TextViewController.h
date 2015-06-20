//
//  TextViewController.h
//  DispBBS_1
//
//  Created by ChangHsaio ni on 2015/6/21.
//  Copyright (c) 2015年 ChangHsaio ni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,weak)IBOutlet UIWebView *webView;
@property(nonatomic,strong)NSString *urlString;

@end
