//
//  ViewController.m
//  UberSlider
//
//  Created by YiHui on 15/8/6.
//  Copyright (c) 2015年 Afer. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "LeftMenuView.h"

#define APP_WIDTH [UIScreen mainScreen].bounds.size.width
#define APP_HEIGHT [UIScreen mainScreen].bounds.size.height
#define LEFT_WIDTH 220.0


@interface ViewController () {
    LeftMenuView *_leftView;
    UIView *_blackView;
    BOOL _leftShow;
    BOOL _hiddenStatusBar;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftShow = NO;
    _hiddenStatusBar = NO;
    OneViewController *onwVc = [[OneViewController alloc] init];UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(leftViewVisible)];
    onwVc.navigationItem.leftBarButtonItem = item;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:onwVc];
    nav.view.frame = CGRectMake(0, 20, APP_WIDTH, APP_HEIGHT - 20);
    [self.view addSubview:nav.view];
    
    [self initBlackViewAndLeftView];
}

- (void)initBlackViewAndLeftView {
    
    _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    _blackView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.610];
    _blackView.hidden = YES;
    _blackView.alpha = 0;
    [self.view addSubview:_blackView];
    _leftView = [[LeftMenuView alloc] initWithFrame:CGRectMake(-LEFT_WIDTH, 0, LEFT_WIDTH, APP_HEIGHT)];
    _leftView.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.115 alpha:1.000];
    [self.view addSubview:_leftView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    UIPanGestureRecognizer *pan1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    [_blackView addGestureRecognizer:pan];
    [_leftView addGestureRecognizer:pan1];
    [self.view addGestureRecognizer:pan2];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftViewHidden)];
    [_blackView addGestureRecognizer:tap];
    
}

- (void)panHandle:(UIPanGestureRecognizer *)gesture {
    CGFloat translation = [gesture translationInView:gesture.view].x;
//    NSLog(@"%f", translation);
    // 判断是否为有效滑动
//    CGFloat minimumX = 0;
//    CGFloat maximumX = LEFT_WIDTH;
//    CGFloat distance = maximumX - minimumX;
    if ((translation < 0 && !_leftShow) || (translation > 0 && _leftShow)) {
        return;
    }

    static CGPoint startLocation;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            startLocation = _leftView.center;
            
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            if (ABS(translation) > CGRectGetMaxX(_leftView.bounds)) {
                return;
            }
            _blackView.hidden = NO;
            CGPoint currentLocation = CGPointMake(startLocation.x + translation, startLocation.y);
            CGFloat factor = translation < 0 ? ABS(translation) /  CGRectGetMaxX(_leftView.bounds) : (1 - (( ABS(translation)) /  CGRectGetMaxX(_leftView.bounds)));
            _leftView.center = currentLocation;
            NSLog(@"%f", factor);
            _blackView.alpha = 1 - factor;
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            // 当水平移动距离大于50才进行视图位置切换，否则还原位置
            if (translation > 0) {
                if (ABS(translation) > 20) {
                    [self leftViewVisible];
                } else {
                    [self leftViewHidden];
                }
                
            } else {
                if (ABS(translation) > 60) {
                    [self leftViewHidden];
                } else {
                    [self leftViewVisible];
                }
            }
            
        }
            break;
            
            // 拖动取消
        case UIGestureRecognizerStateCancelled: {
            
            [self leftViewHidden];
        }
            break;
            // 拖动失败
        case UIGestureRecognizerStateFailed: {
            
            [self leftViewVisible];
        }
            break;
        default:
            break;
    }
}



- (void)leftViewVisible {
    _hiddenStatusBar = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _leftShow = YES;
        _leftView.frame = CGRectMake(0, 0, LEFT_WIDTH, APP_HEIGHT);
        _blackView.hidden = NO;
        _blackView.alpha = 1;
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
}

- (void)leftViewHidden {
    _hiddenStatusBar = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _leftShow = NO;
        _leftView.frame = CGRectMake(-LEFT_WIDTH, 0, LEFT_WIDTH, APP_HEIGHT);
        _blackView.hidden = YES;
        _blackView.alpha = 0;
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}

- (BOOL)prefersStatusBarHidden {
    
    return _hiddenStatusBar; //返回NO表示要显示，返回YES将hiden
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

@end
