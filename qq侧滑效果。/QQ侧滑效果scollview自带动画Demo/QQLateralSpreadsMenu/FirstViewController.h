//
//  FirstViewController.h
//  QQLateralSpreadsMenu
//
//  Created by siwangxuangao on 15/4/10.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FirstViewControllerDelegate <NSObject>

-(void)leftItemBtnClick;

-(void)rightItemBtnClick;



-(void)stateBtnDown1;
-(void)stateBtnDown2;
-(void)stateBtnDown3;
-(void)stateBtnDown4;


@end

@interface FirstViewController : UIViewController


@property(nonatomic,weak)id<FirstViewControllerDelegate>delegate;


@end
