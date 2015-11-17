//
//  LSPBaseViewController.h
//  抽屉效果
//
//  Created by mac on 15-10-2.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPBaseViewController : UIViewController
@property (nonatomic,weak,readonly) UIView *leftView;
@property (nonatomic,weak,readonly) UIView *rightView;
@property (nonatomic,weak,readonly) UIView *mainView;
@end
