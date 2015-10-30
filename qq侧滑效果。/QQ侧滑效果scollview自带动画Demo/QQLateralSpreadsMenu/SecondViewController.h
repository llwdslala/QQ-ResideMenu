//
//  SecondViewController.h
//  QQLateralSpreadsMenu
//
//  Created by siwangxuangao on 15/4/10.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)();


@protocol SecondViewControllerDelegate <NSObject>

-(void)leftViewButtonClick:(block)endBlock;

@end

@interface SecondViewController : UIViewController
@property(nonatomic,retain)UIButton * leftButton;

@property(nonatomic,weak)id<SecondViewControllerDelegate>delegate;

@property(nonatomic,weak)block myblock;

@end
