//
//  ViewController.m
//  Radar
//
//  Created by HarryLee on 16/8/24.
//  Copyright © 2016年 HarryLee. All rights reserved.
//

#import "ViewController.h"
#import "BezierView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BezierView *bezierView = [[BezierView alloc] init];
    bezierView.bounds = CGRectMake(0, 0, 200, 200);
    bezierView.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
    bezierView.startAngle = 45;
    bezierView.endAngle = 135;
    bezierView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bezierView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
