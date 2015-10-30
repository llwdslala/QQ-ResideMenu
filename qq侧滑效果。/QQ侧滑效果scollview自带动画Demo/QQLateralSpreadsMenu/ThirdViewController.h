//
//  ThirdViewController.h
//  QQLateralSpreadsMenu
//
//  Created by siwangxuangao on 15/4/14.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThirdViewControllerDelegate <NSObject>

-(void)pushEnd;

@end

@interface ThirdViewController : UIViewController

@property(nonatomic,weak)id<ThirdViewControllerDelegate>delegate;

@end
