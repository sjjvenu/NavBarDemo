//
//  ViewController.m
//  StatusBarDemo
//
//  Created by tdx on 2017/10/25.
//  Copyright © 2017年 tdx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"首页";
    
    [self.view addSubview:self.webView];
    [self setNavgationBarTransparent:YES];
}

- (UIWebView *)webView
{
    if (_webView == nil)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, self.view.frame.size.width, self.view.frame.size.height+44)];
        _webView.backgroundColor = [UIColor greenColor];
        _webView.scrollView.delegate = self;
        
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    return _webView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y >= 64)
    {
        [UIView animateWithDuration:0.5 animations:^{
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
            [self.navigationItem.titleView setAlpha:1.0];
            [self.navigationItem.titleView setHidden:NO];
            UIColor *backColor = [UIColor greenColor];
            self.navigationController.navigationBar.barTintColor = backColor;
            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:backColor]
                                                          forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.shadowImage = [self imageWithColor:backColor];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            [self setNavgationBarTransparent:YES];
        }];
    }
    [self setNeedsStatusBarAppearanceUpdate];
}


- (void)setNavgationBarTransparent:(BOOL)bTrue
{
    UIColor *backColor = [UIColor greenColor];
    self.navigationController.navigationBar.barTintColor = backColor;
    if (bTrue)
    {
        [self.navigationController.navigationBar setTranslucent:YES];
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.0];
        [self.navigationItem.titleView setAlpha:0.0];
        [self.navigationItem.titleView setHidden:YES];
        //iOS11需要设置以下属性，否则在pushViewController的时候会出现闪屏现象
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
    }
    else
    {
        [self.navigationController.navigationBar setTranslucent:NO];
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
        [self.navigationItem.titleView setAlpha:1.0];
        [self.navigationItem.titleView setHidden:NO];
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:backColor]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [self imageWithColor:backColor];
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
