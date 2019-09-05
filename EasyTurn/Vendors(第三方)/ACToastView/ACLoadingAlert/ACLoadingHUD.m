//
//  ACLoadingHUD.m
//  FFLoadingViewExample
//
//  Created by zhangMo on 2017/11/7.
//  Copyright © 2017年 organization. All rights reserved.
//

#import "ACLoadingHUD.h"

#define kLoadingDefaultColor  [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0]
#define kSuccessDefaultColor  [UIColor colorWithRed:67/255.0 green:188/255.0 blue:113/255.0 alpha:1.0]
#define kFailureDefaultColor  [UIColor colorWithRed:248/255.0 green:88/255.0 blue:88/255.0 alpha:1.0]

#define kAnimationDrawCircle    @"kAnimationDrawCircle"
#define kAnimationDrawSuccess   @"kAnimationDrawSuccess"
#define kAnimationDrawFailure   @"kAnimationDrawFailure"
#define kAnimationName          @"animationName"

static CGFloat lineWidth = 2.0f;
static CGFloat circleDuriation = 0.5f;
static CGFloat checkDuration = 0.2f;

@interface ACLoadingHUD ()<CAAnimationDelegate>

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *loadingLayer;
@property (nonatomic, strong) CAShapeLayer *successLayer;
@property (nonatomic, strong) CAShapeLayer *failureLayer;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, copy) LoadingCompleteBlock finishBlock;

@end

@implementation ACLoadingHUD

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
        [self createSubViewsAndConstraints];
    }
    return self;
}

#pragma mark - Defaults
- (void)setupDefaults {
    _lineWidth = lineWidth;
    _loadingColor = kLoadingDefaultColor;
    _successColor = kSuccessDefaultColor;
    _failureColor = kFailureDefaultColor;
}

- (NSTimeInterval)animationTime {
    return circleDuriation + checkDuration + 0.8 * circleDuriation;
}

#pragma mark - Create Subviews
- (void)createSubViewsAndConstraints {
    _loadingLayer = [CAShapeLayer layer];
    _loadingLayer.fillColor = [UIColor clearColor].CGColor;
    _loadingLayer.strokeColor = _loadingColor.CGColor;
    _loadingLayer.lineWidth = _lineWidth;
    _loadingLayer.frame = self.bounds;
    _loadingLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_loadingLayer];
    
    _successLayer = [CAShapeLayer layer];
    _successLayer.fillColor = [UIColor clearColor].CGColor;
    _successLayer.strokeColor = _successColor.CGColor;
    _successLayer.lineWidth = _lineWidth;
    _successLayer.frame = self.bounds;
    _successLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_successLayer];
    
    _failureLayer = [CAShapeLayer layer];
    _failureLayer.fillColor = [UIColor clearColor].CGColor;
    _failureLayer.strokeColor = _failureColor.CGColor;
    _failureLayer.lineWidth = _lineWidth;
    _failureLayer.frame = self.bounds;
    _failureLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_failureLayer];
}

- (void)createDisplayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - Setting Methods
- (void)setLineWidth:(CGFloat)lineWidth {
    if (lineWidth > 0) {
        _lineWidth = lineWidth;
    }else {
        _lineWidth = lineWidth;
    }
    _loadingLayer.lineWidth = _lineWidth;
    _successLayer.lineWidth = _lineWidth;
    _failureLayer.lineWidth = _lineWidth;
}

- (void)setLoadingColor:(UIColor *)loadingColor {
    if (loadingColor) {
        _loadingColor = loadingColor;
    }else {
        _loadingColor = kLoadingDefaultColor;
    }
    _loadingLayer.strokeColor = _loadingColor.CGColor;
}

- (void)setSuccessColor:(UIColor *)successColor {
    if (successColor) {
        _successColor = successColor;
    }else {
        _successColor = kSuccessDefaultColor;
    }
    _successLayer.strokeColor = _successColor.CGColor;
}

- (void)setFailureColor:(UIColor *)failureColor {
    if (failureColor) {
        _failureColor = failureColor;
    }else {
        _failureColor = kFailureDefaultColor;
    }
    _failureLayer.strokeColor = _failureColor.CGColor;
}

#pragma mark - Public Methods
- (void)startLoading {
    [_loadingLayer removeAllAnimations];
    _loadingLayer.path = nil;
    [_successLayer removeAllAnimations];
    _successLayer.path = nil;
    [_failureLayer removeAllAnimations];
    _failureLayer.path = nil;
    
    [self createDisplayLink];
}

- (void)endLoading {
    [_loadingLayer removeAllAnimations];
    _loadingLayer.path = nil;
    [_successLayer removeAllAnimations];
    _successLayer.path = nil;
    [_failureLayer removeAllAnimations];
    _failureLayer.path = nil;
    
    [self cancelDisplayLink];
    [self removeFromSuperview];
}

- (void)finishWithSuccess:(LoadingCompleteBlock)block {
    _finishBlock = block;
    [self cancelDisplayLink];
    //动画
    [self drawCircleAnimationWithSuccess:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.8 * circleDuriation * NSEC_PER_SEC);
    __weak ACLoadingHUD *weakSelf = self;
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        __strong ACLoadingHUD *strongSelf = weakSelf;
        [strongSelf drawSuccessAnimation];
    });
}

- (void)finishWithFailure:(LoadingCompleteBlock)block {
    _finishBlock = block;
    [self cancelDisplayLink];
    //动画
    [self drawCircleAnimationWithSuccess:NO];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.8 * circleDuriation * NSEC_PER_SEC);
    __weak ACLoadingHUD *weakSelf = self;
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        __strong ACLoadingHUD *strongSelf = weakSelf;
        [strongSelf drawFailureAnimation];
    });
}

#pragma mark - Private Methods
// draw Animation
- (void)drawLoadingAnimation {
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 + _progress * M_PI * 2;
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress)/0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    
    CGRect rectSelf = self.bounds;
    CGFloat radius = CGRectGetHeight(rectSelf) / 2.0f;
    CGFloat centerX = rectSelf.size.width / 2.0f;
    CGFloat centerY = rectSelf.size.width / 2.0f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    _loadingLayer.path = path.CGPath;
    _loadingLayer.strokeColor = _loadingColor.CGColor;
}

- (void)drawCircleAnimationWithSuccess:(BOOL)success {
    CGRect rectSelf = self.bounds;
    CGFloat radius = CGRectGetHeight(rectSelf) / 2.0f;
    CGFloat centerX = rectSelf.size.width / 2.0f;
    CGFloat centerY = rectSelf.size.width / 2.0f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    _loadingLayer.path = path.CGPath;
    if (success) {
        _loadingLayer.strokeColor = _successColor.CGColor;
    }else {
        _loadingLayer.strokeColor = _failureColor.CGColor;
    }
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnimation.duration = circleDuriation;
    circleAnimation.fromValue = @(0.0f);
    circleAnimation.toValue = @(1.0f);
    circleAnimation.delegate = self;
    [circleAnimation setValue:kAnimationDrawCircle forKey:kAnimationName];
    [_loadingLayer addAnimation:circleAnimation forKey:nil];
}

- (void)drawSuccessAnimation {
    CGFloat width = self.bounds.size.width;
    UIBezierPath *successPath = [UIBezierPath bezierPath];
    [successPath moveToPoint:CGPointMake(width/3.1578, width/2)];
    [successPath addLineToPoint:CGPointMake(width/2.0618, width/1.57894)];
    [successPath addLineToPoint:CGPointMake(width/1.3953, width/2.7272)];
    _successLayer.path = successPath.CGPath;
    _successLayer.strokeColor = _successColor.CGColor;
    
    CABasicAnimation *successAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    successAnimation.duration = checkDuration;
    successAnimation.delegate = self;
    successAnimation.fromValue = @(0.0f);
    successAnimation.toValue = @(1.0f);
    [successAnimation setValue:kAnimationDrawSuccess forKey:kAnimationName];
    [_successLayer addAnimation:successAnimation forKey:nil];
}

- (void)drawFailureAnimation {
    CGFloat width = self.bounds.size.width;
    UIBezierPath *failurePath = [UIBezierPath bezierPath];
    [failurePath moveToPoint: CGPointMake(width/3.5, width/3.5)];
    [failurePath addLineToPoint: CGPointMake(width - width/3.5, width - width/3.5)];
    [failurePath moveToPoint: CGPointMake(width - width/3.5, width/3.5)];
    [failurePath addLineToPoint: CGPointMake(width/3.5, width - width/3.5)];
    _failureLayer.path = failurePath.CGPath;
    _failureLayer.strokeColor = _failureColor.CGColor;
    
    CABasicAnimation *failureAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    failureAnimation.duration = checkDuration;
    failureAnimation.delegate = self;
    failureAnimation.fromValue = @(0.0f);
    failureAnimation.toValue = @(1.0f);
    [failureAnimation setValue:kAnimationDrawFailure forKey:kAnimationName];
    [_failureLayer addAnimation:failureAnimation forKey:nil];
}

- (void)displayLinkAction {
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self drawLoadingAnimation];
}

// speed
- (CGFloat)speed {
    if (_endAngle > M_PI) {
        return 0.3/60.0f;
    }
    return 2/60.0f;
}

- (void)cancelDisplayLink {
    [_displayLink invalidate];
    _displayLink = nil;
}

#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *value = [anim valueForKey:kAnimationName];
    if ([value isEqualToString:kAnimationDrawSuccess] || [value isEqualToString:kAnimationDrawFailure]) {
        if (self.finishBlock != NULL) {
            self.finishBlock();
        }
    }
}

#pragma mark - dealloc
- (void)dealloc {
    NSLog(@"<< HUD dealloc >>");
}

@end
