//
//  YB_QQLateralSpareadsMenuView.m
//  QQLateralSpreadsMenu
//
//  Created by siwangxuangao on 15/4/13.
//  Copyright (c) 2015年 youbinbin. All rights reserved.
//

#import "YB_QQLateralSpareadsMenuView.h"

#pragma mark - 宏定义。

//左边默认比率。
#define LeftViewCoefficient 0.7

//右边默认比率。
#define RightViewCoefficient 0.3

//默认动画时间。
#define TheDefaultAnimationTime 0.3

//边界距离。
#define LeftBoundaryDistance 10
#define RightBoundaryDistance 10



//左边变化率基数。
#define  LeftBASE 1000 //1000~~3000
//右边 变化率基数。
#define RightBASE 400  //400~~1000


@interface YB_QQLateralSpareadsMenuView()<UIScrollViewDelegate>
{
//     封装的Scrollview；
      UIScrollView * _scrollView;
    
//    判断是否正在动画。
    BOOL _yesAnimationing;
    
    
//  判断是否是切换屏幕后的。第一次滑动。
    
    BOOL firstChage;
    
    
//    判断是那个按钮点击的。
    BOOL isleftClick;
    BOOL isRightClick;
    
    
// 缩小后 添加蒙版
    UIButton * _coverButton;

    
}

@end
@implementation YB_QQLateralSpareadsMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"back@3x"]];
        
        
        
        self.leftBase=LeftBASE;
        self.rightBase=RightBASE;
        
        self.leftViewRatio=LeftViewCoefficient;
        self.rightViewRatio=RightViewCoefficient;
//        动画时间。
        
        self.animationTimer=TheDefaultAnimationTime;
        
        [self createScrollView];
//默认 第一次 是显示 左右两边。
        self.showAllView=YES;
        
        _yesAnimationing=YES;
//        左边按钮是否 可以点击。
        isleftClick=YES;
//        右边 按钮是否可以点击。
        isRightClick=YES;
        

        
        [self chageViewFrame];
        
        
    }
    return self;

}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
  
    [self chageViewFrame];
    
}

-(void)setAnimationTimer:(NSTimeInterval)animationTimer{
    _animationTimer=animationTimer;
}


-(void)setNotShowView:(BOOL)notShowView{
    _notShowView=notShowView;
    
    if (notShowView) {
        _scrollView.contentInset=UIEdgeInsetsMake(0,
                                                  0,
                                                  0,
                                                  0);
        
        self.showAllView=NO;
        self.onlyShowLeftView=NO;
        self.onlyShowRightView=NO;

    }
}

//显示两边view；
-(void)setShowAllView:(BOOL)showAllView{
    
    _showAllView=showAllView;
    
    if (showAllView) {
      
        _scrollView.contentInset=UIEdgeInsetsMake(0,
                                                  _scrollView.frame.size.width*
                                                  self.leftViewRatio,
                                                  0,
                                                  _scrollView.frame.size.width*
                                                  self.rightViewRatio);
        
        self.notShowView=NO;
        self.onlyShowLeftView=NO;
        self.onlyShowRightView=NO;
        
    }

}


//是否显左边或者右边view。
-(void)setOnlyShowLeftView:(BOOL)onlyShowLeftView{

    _onlyShowLeftView=onlyShowLeftView;
    
    if (onlyShowLeftView) {
        
        _scrollView.contentInset=UIEdgeInsetsMake(0,
                                                  _scrollView.frame.size.width*
                                                  self.leftViewRatio,
                                                  0,
                                                  0);
        
        self.notShowView=NO;
        self.showAllView=NO;
        self.onlyShowRightView=NO;
    }
}

//只显示左边 或者右边。

-(void)setOnlyShowRightView:(BOOL)onlyShowRightView{

    _onlyShowRightView=onlyShowRightView;
    
    if (onlyShowRightView) {

        _scrollView.contentInset=UIEdgeInsetsMake(0,
                                                  0,
                                                  0,
                                                   _scrollView.frame.size.width*self.rightViewRatio);
        self.notShowView=NO;
        self.showAllView=NO;
        self.onlyShowLeftView=NO;
    }
}
//判断有没有设置 基数。左边
-(void)setLeftBase:(CGFloat)leftBase{
    _leftBase=LeftBASE;
    NSNumber *numeb=[NSNumber numberWithFloat:leftBase];
    
    if (numeb!=nil) {

        _leftBase=leftBase;

    }
}
//判断有没有设置 基数。右边。
-(void)setRightBase:(CGFloat)rightBase{

    _rightBase=RightBASE;
    
    NSNumber *numeb=[NSNumber numberWithFloat:rightBase];

    if (numeb!=nil) {
  
        _rightBase=rightBase;
        
    }

}



//左边view
-(void)setLeftView:(UIView *)leftView{
    _leftView=leftView;
    if (_scrollView!=nil) {
        [_scrollView addSubview:_leftView];
    }
}
//右边view
-(void)setRightView:(UIView *)rightView{
    _rightView=rightView;
    if (_scrollView!=nil) {
        [_scrollView addSubview:_rightView];
    }
}
//中间view
-(void)setMiddleView:(UIView *)middleView{
    _middleView=middleView;
    if (_scrollView!=nil) {
        [_scrollView addSubview:_middleView];
    }
}



//判断有没有给左边的滑出的view分配比率。
-(void)setLeftViewRatio:(CGFloat)leftViewRatio{
    
    _leftViewRatio=LeftViewCoefficient;
    
//    判断是 否为空。
    NSNumber * number=[NSNumber numberWithInteger:leftViewRatio];
    if (number!=nil) {
        _leftViewRatio=leftViewRatio;
        
    }
}

//判断有没有给右边边的滑出的view分配比率。
-(void)setRightViewRatio:(CGFloat)rightViewRatio{
    
    _rightViewRatio=RightViewCoefficient;
    
//    判断是否为空。
    NSNumber * number=[NSNumber numberWithInteger:rightViewRatio];
    
    if (number!=nil) {
        _rightViewRatio=rightViewRatio;
    }
}

-(void)createScrollView{

    _scrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
    
    _scrollView.delegate=self;
//    不显示滑动条。
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
//    分页。
    _scrollView.pagingEnabled=YES;
    
//    
    _scrollView.scrollEnabled=YES;
    _scrollView.contentOffset=CGPointMake(0, 0);

    
    
    // 没有弹性效果。
    _scrollView.bounces=NO;
    
    [self addSubview:_scrollView];
}
//添加视图。
-(void)menuViewLeftView:(UIView *)leftView MiddleView:(UIView *)middleView WithRightView:(UIView *)rightView{
    
    if(leftView!=nil){
        
        [_scrollView addSubview:leftView];
           _leftView=leftView;
    
    }
    
    if (rightView!=nil) {
        
        
        [_scrollView addSubview:rightView];

        _rightView=rightView;
    }
    
    
    if (middleView!=nil) {
        
        
        [_scrollView addSubview:middleView];
        
        _middleView=middleView;
        
    }
    
}

#pragma mark - 刷新UI

-(void)chageViewFrame{
    firstChage=YES;
//
    _scrollView.frame=self.bounds;
    
    CGFloat Width=_scrollView.frame.size.width;
    CGFloat Height=_scrollView.frame.size.height;

    
////
    _scrollView.contentSize=
                CGSizeMake(_scrollView.frame.size.width,
                            _scrollView.frame.size.height);
    
    
    self.onlyShowLeftView=self.onlyShowLeftView;
    self.onlyShowRightView=self.onlyShowRightView;
    self.showAllView=self.showAllView;
    self.notShowView=self.notShowView;

    _scrollView.contentOffset=CGPointMake(0, 0);

     /**
     *  leftViewFrame
     */
    _leftView.transform=CGAffineTransformIdentity;
    _leftView.frame=CGRectMake(-Width*_leftViewRatio,
                               0,
                               Width*_leftViewRatio,
                               Height);
    
    _leftView.transform=CGAffineTransformMakeScale(_leftViewRatio, _leftViewRatio);

    /**
     *  rightViewFrame
     */
    _rightView.transform=CGAffineTransformIdentity;
    _rightView.backgroundColor=[UIColor redColor];
    
    _rightView.frame=CGRectMake(Width,
                               0,
                               Width*_rightViewRatio,
                               Height);
    _rightView.transform=CGAffineTransformMakeScale(_rightViewRatio, _rightViewRatio);

    
    /**
     *  centerFrame
     */
    
    _middleView.frame=_scrollView.bounds;
    
}

#pragma mark- //切换左抽屉。


-(void)makeScrollViewContentoffsetWithLeftView{
//
    isleftClick=YES;
    isRightClick=NO;
    
    
    NSLog(@"%.2f",    _scrollView.contentOffset.x
          );
//    偏移量 小于0 显示左边抽屉。收起左边抽屉。
    if (_scrollView.contentOffset.x<0&&_yesAnimationing) {
        _yesAnimationing=NO;
        

        [UIView animateWithDuration:_animationTimer animations:^{
            
            _scrollView.contentOffset=CGPointMake(0, 0);
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            
        }completion:^(BOOL finished) {
            
            [self leftViewWithBtnClick];
            _yesAnimationing=YES;
            
            isRightClick=YES;
            
            if (_coverButton!=nil) {
                [_coverButton removeFromSuperview];
                _coverButton=nil;
            }
            
        }];
        
        
        
        
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        

    }
//没有显示 左边抽屉。 让它显示左边抽屉。

    if (_scrollView.contentOffset.x>=0&&_yesAnimationing) {
        
        _yesAnimationing=NO;
        


        CGFloat X=_scrollView.frame.size.width*_leftViewRatio;
        
        [UIView animateWithDuration:_animationTimer animations:^{
            
            _scrollView.contentOffset=CGPointMake(-X, 0);
            [_scrollView setContentOffset:CGPointMake(-X, 0) animated:NO];

            
        }completion:^(BOOL finished) {
            
            [self leftViewWithBtnClick];
            _yesAnimationing=YES;
            
            isRightClick=YES;
            
            [self creatCoverButton];
            
        }];
        
        

    }    
}


//创建蒙版按钮。
-(void)creatCoverButton{
    
        CGSize size=_scrollView.frame.size;
    
    if ((_scrollView.contentOffset.x==-size.width*_leftViewRatio||
        _scrollView.contentOffset.x==size.width*_rightViewRatio)&&_coverButton==nil) {
        
        _coverButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _coverButton.frame=_middleView.bounds;
        [_coverButton addTarget:self action:@selector(ButtonDonw:) forControlEvents:UIControlEventTouchUpInside];
        [_middleView addSubview:_coverButton];
        
    }

}

-(void)ButtonDonw:(UIButton*)btn{
//    覆盖上一层。
    CGSize size=_scrollView.frame.size;
    
    if (_scrollView.contentOffset.x==-size.width*_leftViewRatio) {
        
        [self makeScrollViewContentoffsetWithLeftView];
        
    }
    
    if (_scrollView.contentOffset.x==size.width*_rightViewRatio) {
        [self makeScrollViewContentoffsetWithRightView];
        
    }

    [btn removeFromSuperview];
    
}

#pragma mark- //切换右抽屉。

-(void)makeScrollViewContentoffsetWithRightView{
    isRightClick=YES;
    isleftClick=NO;
//    偏移量大于0 显示 右边抽屉。收起右边抽屉。
    if (_scrollView.contentOffset.x>0&&_yesAnimationing) {
        
        _yesAnimationing=NO;
        
        
        [UIView animateWithDuration:_animationTimer animations:^{
            
            _scrollView.contentOffset=CGPointMake(0, 0);
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            
            
        }completion:^(BOOL finished) {
            [self rightViewWithBtnClick];
            
            _yesAnimationing=YES;
            
            isleftClick=YES;
            
            if (_coverButton!=nil) {
                [_coverButton removeFromSuperview];
                _coverButton=nil;
            }
            
            
        }];
        

    }
    
//当前没有偏移量 就是 没有显示 抽屉。显示右边抽屉。
    if (_scrollView.contentOffset.x==0&&_yesAnimationing) {
        
        _yesAnimationing=NO;
        

        
        
        CGFloat X=_scrollView.frame.size.width*_rightViewRatio;
        
        
        [UIView animateWithDuration:_animationTimer animations:^{
            
            _scrollView.contentOffset=CGPointMake(X, 0);
            [_scrollView setContentOffset:CGPointMake(X, 0) animated:NO];
            
        }completion:^(BOOL finished) {
            [self rightViewWithBtnClick];
            
            _yesAnimationing=YES;
            
            isleftClick=YES;
            
            
            [self creatCoverButton];
        }];
        

        

    }
    
}

#pragma mark - scrollViewDelegate;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x<scrollView.frame.size.width*_rightViewRatio-RightBoundaryDistance) {
        scrollView.pagingEnabled=YES;
    }
    if (scrollView.contentOffset.x>scrollView.frame.size.width*_leftViewRatio+LeftBoundaryDistance) {
        scrollView.pagingEnabled=YES;
    }
    
    
    CGSize size=_scrollView.frame.size;
    
    if (scrollView.contentOffset.x<=0&&isleftClick) {
        
#pragma mark - 偏移辆判断左边。

        [self customAnimationWithLeftView];
        
            
    }else if(scrollView.contentOffset.x>=0&&scrollView.contentOffset.x<=size.width*_rightViewRatio&&isRightClick){

#pragma mark- 偏移量判断 右边。
        [self customAnimationWithRightView];
        
    }

//    看看 是否需要加层蒙版。
    CGFloat leftContentOffSetX=_scrollView.frame.size.width*_leftViewRatio;
    CGFloat rightContentoffSetX=_scrollView.frame.size.width*_rightViewRatio;
    
    if (scrollView.contentOffset.x<=-leftContentOffSetX) {

        [self creatCoverButton];
        
    }
    if (scrollView.contentOffset.x>=rightContentoffSetX) {
        
        [self creatCoverButton];
        
    }
    
    if (_scrollView.contentOffset.x==0) {
        
        if (_coverButton!=nil) {
            [_coverButton removeFromSuperview];
            _coverButton =nil;
        }
        
    }
    
    
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    
    [self leftViewWithBtnClick];
    [self rightViewWithBtnClick];
//  由于这个方法调用不固定。。
    CGFloat leftContentOffSetX=_scrollView.frame.size.width*_leftViewRatio;
    CGFloat rightContentoffSetX=_scrollView.frame.size.width*_rightViewRatio;
    
    //    判断偏移量。
    if (scrollView.contentOffset.x<=-leftContentOffSetX) {

        [self creatCoverButton];
        
        scrollView.pagingEnabled=NO;
        
    }
    if (scrollView.contentOffset.x>=rightContentoffSetX) {
        
        [self creatCoverButton];
        scrollView.pagingEnabled=NO;
        
    }
    
    if (scrollView.contentOffset.x==0) {

        if(_coverButton!=nil) {
            [_coverButton removeFromSuperview];
            _coverButton=nil;
        }
        
    }
    
}


#pragma mark- 左边判断不能划开，能够点击打开。

-(void)leftViewWithBtnClick{
    

    if (_scrollView.contentOffset.x==-_scrollView.frame.size.width*_leftViewRatio) {
        //        判断是否 不需要 左边划出。 但是 确实 有左边view。
        if (!_onlyShowLeftView&&(_onlyShowRightView||_notShowView)) {
            UIEdgeInsets edge=_scrollView.contentInset;
            
            
            _scrollView.contentInset=UIEdgeInsetsMake(edge.top,
                                                      _scrollView.frame.size.width*_leftViewRatio,
                                                      edge.bottom,
                                                      edge.right);
        }
    }else if(_scrollView.contentOffset.x==0){
        //        判断是否 不需要 左边划出。 但是 确实 有左边view。
        if (!_onlyShowLeftView&&(_onlyShowRightView||_notShowView)) {
            
            UIEdgeInsets edge=_scrollView.contentInset;
            
            _scrollView.contentInset=UIEdgeInsetsMake(edge.top,
                                                      0,
                                                      edge.bottom,
                                                      edge.right);
            
        }
    }
    
    CGFloat leftContentOffSetX=_scrollView.frame.size.width*_leftViewRatio;
    CGFloat rightContentoffSetX=_scrollView.frame.size.width*_rightViewRatio;
    
    //    判断偏移量。
    if (_scrollView.contentOffset.x<=-leftContentOffSetX) {
        
        _scrollView.pagingEnabled=NO;
        
    }
    if (_scrollView.contentOffset.x>=rightContentoffSetX) {
        
        _scrollView.pagingEnabled=NO;
        
    }
    
    
    
}

#pragma mark- 判断右边 不能划开。能够点击打开。

-(void)rightViewWithBtnClick{
    
    NSLog(@"%.2f",_scrollView.contentOffset.x);
    NSLog(@"%.2f",_scrollView.frame.size.width*_rightViewRatio);
    
    NSLog(@"%@",NSStringFromUIEdgeInsets(_scrollView.contentInset));
    
    
    if (_scrollView.contentOffset.x>=_scrollView.frame.size.width*_rightViewRatio) {
        
        //        判断是否 不需要 左边划出。 但是 确实 有右边view。
        if (!_onlyShowRightView&&(_onlyShowLeftView||_notShowView)) {
            UIEdgeInsets edge=_scrollView.contentInset;
            
            _scrollView.contentInset=UIEdgeInsetsMake(edge.top,
                                                      edge.left,
                                                      edge.bottom,
                                                      _scrollView.frame.size.width*_rightViewRatio);
            NSLog(@"%@",NSStringFromUIEdgeInsets(_scrollView.contentInset));
        }
    }else if(_scrollView.contentOffset.x==0){
        //        判断是否 不需要 左边划出。 但是 确实 有右边view。
        if (!_onlyShowRightView&&(_onlyShowLeftView||_notShowView)) {
            
            UIEdgeInsets edge=_scrollView.contentInset;
            
            _scrollView.contentInset=UIEdgeInsetsMake(edge.top,
                                                      edge.left,
                                                      edge.bottom,
                                                      0);
            
        }
    }
    
    CGFloat leftContentOffSetX=_scrollView.frame.size.width*_leftViewRatio;
    CGFloat rightContentoffSetX=_scrollView.frame.size.width*_rightViewRatio;
    
    //    判断偏移量。
    if (_scrollView.contentOffset.x<=-leftContentOffSetX) {
        
        _scrollView.pagingEnabled=NO;
        
    }
    if (_scrollView.contentOffset.x>=rightContentoffSetX) {
        
        _scrollView.pagingEnabled=NO;
        
    }
    
    
}

#pragma  mark -  左边view 滑动等变化率。

-(void)customAnimationWithLeftView{

    //用来记录倍率 最小值。
    //左边
    float  minNumber=(0+_leftBase)/((_scrollView.frame.size.width*_leftViewRatio)+_leftBase);

    
    _leftView.hidden=NO;
    _rightView.hidden=YES;
    
    CGSize size=_scrollView.frame.size;
    
    CGFloat alpha=-_scrollView.contentOffset.x/(size.width*_leftViewRatio);
    
    CGFloat exChage=((-_scrollView.contentOffset.x+_leftBase)/
                     ((size.width*_leftViewRatio)+_leftBase));
    
    
    
    if (exChage<0) {
        exChage=-exChage;
    }
    
    //            改变它的 缩放至。
    self.leftView.transform=CGAffineTransformMakeScale(exChage, exChage);

    
    
    CGFloat X=_scrollView.contentOffset.x;
    
    //            改变坐标。X-(500*(1-exChage)) 是想他 缩出去屏幕点。
    
    self.leftView.frame=CGRectMake(X-(200*(1-exChage)),
                                   self.leftView.frame.origin.y,
                                   self.leftView.frame.size.width,
                                   self.leftView.frame.size.height);
    //        改变它的都明度。
    self.leftView.alpha=alpha;
    
    //        用来记录最初的 比率是多少。。
    if (minNumber>exChage) {
            minNumber=exChage;

    }
    
    //        得到最后。的 centerView 的变化率。
    float lastNumber=1.0+minNumber;
    //            改变缩放值
    _middleView .transform=CGAffineTransformMakeScale(lastNumber-exChage,lastNumber-exChage);
    
    //            改变坐标。
    _middleView.frame=CGRectMake(0,
                                 _middleView.frame.origin.y,
                                 _middleView.frame.size.width,
                                 _middleView.frame.size.height);
    

    if (_scrollView.contentOffset.x==0||_scrollView.contentOffset.x==-size.width*_leftViewRatio) {
        
        [self leftViewWithBtnClick];
        
    }
}
#pragma  mark - 右边view 滑动 等变化率。
-(void)customAnimationWithRightView{
    
    CGSize size=_scrollView.frame.size;

    //右边。
    float  maxNumber=(0+_rightBase)/((_scrollView.frame.size.width*_rightViewRatio)+_rightBase);
    
    _leftView.hidden=YES;
    _rightView.hidden=NO;

    CGFloat alpha=_scrollView.contentOffset.x/(size.width*_rightViewRatio);
    
    //           变化率
    float exChage=(_scrollView.contentOffset.x+_rightBase)/((_scrollView.frame.size.width*_rightViewRatio)+_rightBase);
    
    _rightView.transform=CGAffineTransformMakeScale(exChage,exChage);
    
    //        用来记录最初的 比率是多少。。
    if (maxNumber>exChage) {
        
        maxNumber=exChage;
    }
    //        得到最后。的 centerView 的变化率。
    float lastNumber=1.0+maxNumber;
    
    //            改变缩放值
    _middleView .transform=CGAffineTransformMakeScale(lastNumber-exChage,lastNumber-exChage);
    //            改变坐标。
    
    CGFloat middleX=_scrollView.frame.size.width-_middleView.frame.size.width;
    
    
    _middleView.frame=CGRectMake(middleX,
                                 _middleView.frame.origin.y,
                                 _middleView.frame.size.width,
                                 _middleView.frame.size.height);
    
    //        改变它的都明度。
    self.rightView.alpha=alpha;
    self.rightView.transform=CGAffineTransformMakeScale(exChage, exChage);


    self.rightView.frame=CGRectMake(middleX+_middleView.frame.size.width,
                                    self.rightView.frame.origin.y,
                                    self.rightView.frame.size.width+(200*(1-exChage)),
                                    self.rightView.frame.size.height);
    
    if (_scrollView.contentOffset.x==0||_scrollView.contentOffset.x==size.width*_rightViewRatio) {
     
        [self rightViewWithBtnClick];
 
    }

    
    
}



@end
