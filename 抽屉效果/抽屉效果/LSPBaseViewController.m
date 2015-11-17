//
//  LSPBaseViewController.m
//  抽屉效果
//
//  Created by mac on 15-10-2.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPBaseViewController.h"
#define MAXOFFSET 60
#define LEFTMARGIN -220
#define RIGHTMARGIN 220
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
@interface LSPBaseViewController ()
@property (assign,nonatomic) BOOL isDraging;
@end

@implementation LSPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildView];
    
    [_mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (_mainView.frame.origin.x > 0) {
        
        _rightView.hidden = YES;
        _leftView.hidden = NO;
        
    }
    else if (_mainView.frame.origin.x < 0)
    {
        _leftView.hidden = YES;
        _rightView.hidden = NO;
    }
}
- (void)addChildView
{
    UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:leftView];
    _leftView = leftView;
    
    UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    rightView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:rightView];
    _rightView = rightView;
    
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor redColor];
    [self.view addSubview:mainView];
    _mainView = mainView;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    
   // CGRect touchFrame = _mainView.frame;
    
    CGFloat offsetX = currentPoint.x - previousPoint.x;
    
    //touchFrame.origin.x += offsetX;
    
   // _mainView.frame = touchFrame;
    
   // CGRect currentFrame = [self currentFrameFormOffset:offsetX];
    
    //_mainView.frame = currentFrame;
    
    _mainView.frame = [self currentFrameFormOffset:offsetX];
}

- (CGRect)currentFrameFormOffset:(CGFloat)offsetX
{
   // CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat offsetY = offsetX * MAXOFFSET / SCREENW;
    
    CGFloat scale = (SCREENH - 2 * offsetY) / SCREENH;
    if (_mainView.frame.origin.x < 0) {
        scale = (SCREENH + 2 * offsetY) / SCREENH;
    }
    CGRect realFrame = _mainView.frame;
//    CGFloat frameX = _mainView.frame.origin.x + offsetX;
//    CGFloat frameY = offsetY;
//    CGFloat frameW = self.view.bounds.size.width;
//    CGFloat frameH;
    realFrame.origin.x += offsetX;
    realFrame.origin.y = (SCREENH - realFrame.size.height) * 0.5;
    realFrame.size.width = realFrame.size.width * scale;
    realFrame.size.height = realFrame.size.height * scale;
    
   // CGRect rect = CGRectMake(frameX, frameY, frameW, frameH);
    _isDraging = YES;
    return realFrame;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isDraging == NO && _mainView.frame.origin.x != 0) {
        _mainView.frame = self.view.bounds;
    }
    
    /*
     _mainView.frame.origin.x
     
     CGRectGetMidX(_mainView.frame) > SCREENW * 0.5
     
     CGRectGetMidX(_mainView.frame) < SCREENW * 0.5
     
     */
    
    CGFloat margin = 0;
    
    if (_mainView.frame.origin.x > SCREENW * 0.5) {
        
        margin = RIGHTMARGIN;
        
    }else if (CGRectGetMaxX(_mainView.frame) < SCREENW * 0.5)
    {
        margin = LEFTMARGIN;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
       
        if (margin) {
            
            // CGFloat dragin = _mainView.frame.origin.x - SCREENW * 0.5;
            
            CGFloat offsetX = margin - _mainView.frame.origin.x;
            
            _mainView.frame = [self currentFrameFormOffset:offsetX];
        }
        else
        {
            _mainView.frame = self.view.bounds;
        }

        
        
    }];
    
    _isDraging = NO;
}


@end
