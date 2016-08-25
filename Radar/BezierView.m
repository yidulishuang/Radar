//
//  BezierView.m
//  UIBezierPathTest
//
//  Created by HarryLee on 16/8/24.
//  Copyright © 2016年 HarryLee. All rights reserved.
//

#import "BezierView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BezierView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    

    for (int i = 0; i < 4; i++) {
        
        CGFloat radius = self.bounds.size.width / 6.0 * i;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:radius startAngle:i/4.0*2*M_PI endAngle:2*M_PI+i/4.0*2*M_PI clockwise:YES];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(0.f);
        animation.toValue = @(1.f);
        animation.repeatCount = INT_MAX;
        animation.duration = 2.f;
        
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.strokeColor = [UIColor colorWithRed:0 green:0 blue:0.7 alpha:1].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 1;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.path = path.CGPath;
        [shapeLayer addAnimation:animation forKey:@"circleLayerAnimation"];
        
        [self.layer addSublayer:shapeLayer];

    }
    


    /*
    //第一种方法：UIBezierPath循环画扇形，给颜色不同的透明度
    for (int i = 0; i < 90; i++) {
        CGFloat alpha = i * 1.0 / 90;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 startAngle:i * M_PI / 180.f endAngle:(i + 1) * M_PI / 180.f clockwise:YES];
        [path closePath];
        

        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed:0 green:0.6 blue:0 alpha:alpha].CGColor;
        shapeLayer.lineWidth = 0;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.path = path.CGPath;

        [self.layer addSublayer:shapeLayer];
        
    }
    */
    //第二种方法：CoreGraphics颜色渐变
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor whiteColor].CGColor,
                               (id)[UIColor purpleColor].CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (__bridge CFArrayRef)gradientColors,
                                                        gradientLocations);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, self.bounds.size.width / 2.0, self.bounds.size.height/2.0);
    CGContextAddArc(context, self.bounds.size.width / 2.0, self.bounds.size.height/2.0, self.bounds.size.width / 2.0, 0 , 1.0/2 *M_PI, 0);
    CGContextClosePath(context);
    CGContextClip(context);
    
    
    CGPoint endshine;
    CGPoint startshine;
    startshine = CGPointMake(self.bounds.size.width, self.bounds.size.width / 2.0);
    endshine = CGPointMake(self.bounds.size.width / 2.0 ,self.bounds.size.height);
    CGContextDrawLinearGradient(context,gradient , startshine, endshine, kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INT_MAX;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
    
    

}






@end
