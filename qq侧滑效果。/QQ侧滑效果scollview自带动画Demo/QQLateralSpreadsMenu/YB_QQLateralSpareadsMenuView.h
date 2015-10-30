//
//  YB_QQLateralSpareadsMenuView.h
//  QQLateralSpreadsMenu
//
//  Created by siwangxuangao on 15/4/13.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YB_QQLateralSpareadsMenuView : UIView
//左边的的比率。
@property(nonatomic,assign)CGFloat leftViewRatio;
//左边基数。
@property(nonatomic,assign)CGFloat leftBase;
//动画时间。
@property(nonatomic,assign)NSTimeInterval animationTimer;


//右边的比率。
@property(nonatomic,assign)CGFloat rightViewRatio;
//右边基数。
@property(nonatomic,assign)CGFloat rightBase;
//选择是否显示 左边view；
@property(nonatomic,assign)BOOL  onlyShowLeftView;
//选择是否显示 右边view；
@property(nonatomic,assign)BOOL  onlyShowRightView;
//选择显示全部view。
@property(nonatomic,assign)BOOL  showAllView;
//两边全部关闭。
@property(nonatomic,assign)BOOL  notShowView;

//左边的view；
@property(nonatomic,retain)UIView * leftView;
//右边view；
@property(nonatomic,retain)UIView * rightView;
//中间View；
@property(nonatomic,retain)UIView * middleView;



/**
 *  type 1.
 *
 *  @param leftView             左边是view
 *  @param middleViewController 中间是控制器。
 *  @param rightView            右边是view；
 */
-(void)menuViewLeftView:(UIView*)leftView MiddleView:(UIView*)middleView WithRightView:(UIView*)rightView;


//按钮点击切换左抽屉。
-(void)makeScrollViewContentoffsetWithLeftView;

//按钮点击，切换有抽屉。
-(void)makeScrollViewContentoffsetWithRightView;

//修改坐标。
-(void)chageViewFrame;

@end
