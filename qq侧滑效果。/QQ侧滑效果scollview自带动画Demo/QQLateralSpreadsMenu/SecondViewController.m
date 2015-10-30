//
//  SecondViewController.m
//  QQLateralSpreadsMenu
//
//  Created by siwangxuangao on 15/4/10.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "SecondViewController.h"

#import "YB_QQLateralSpareadsMenuView.h"
#import "FirstViewController.h"



@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,FirstViewControllerDelegate>
{
    
    YB_QQLateralSpareadsMenuView * BKview;
    FirstViewController * first;
    
    UIView * view1;
    UIView * view2;
    
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    

    
   view1=[[UIView alloc]init];

    
    view2=[[UIView alloc]init];

    
     first=[[FirstViewController alloc]init];
        first.title=@"hahahahah";
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:first];
    
    first.delegate=self;
    
    

    
    __strong id firsts=first;
    
    self.delegate=firsts;
    
    [self addChildViewController:nav];
    BKview=[[YB_QQLateralSpareadsMenuView alloc]initWithFrame:self.view.bounds];
    
    [BKview menuViewLeftView:view1 MiddleView:nav.view WithRightView:view2];
    
    BKview.animationTimer=0.3;
    
    BKview.notShowView=YES;

    [self.view addSubview:BKview];
    
//    
    [BKview chageViewFrame];
//
    
    [self makeUItableView];
    
}



#pragma mark- FIRSTviewControllerDelegate;
-(void)leftItemBtnClick{


    [BKview makeScrollViewContentoffsetWithLeftView];

}

-(void)rightItemBtnClick{

    [BKview makeScrollViewContentoffsetWithRightView];

}


-(void)stateBtnDown1{
    BKview.onlyShowLeftView=YES;
    [BKview chageViewFrame];
    


}

-(void)stateBtnDown2{

    BKview.onlyShowRightView=YES;
    [BKview chageViewFrame];

}

-(void)stateBtnDown3{
    BKview.notShowView=YES;
    [BKview chageViewFrame];


}
-(void)stateBtnDown4{

    BKview.showAllView=YES;
    [BKview chageViewFrame];

}





-(void)makeUItableView{
    
    
    UITableView * table=[[UITableView alloc]initWithFrame:view1.bounds];
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor=[UIColor clearColor];
    
    [view1 addSubview:table];
    
    
    UITableView *  table2=[[UITableView alloc]initWithFrame:view2.bounds];
    table2.delegate=self;
    table2.dataSource=self;
    table2.backgroundColor=[UIColor clearColor];
    [view2 addSubview:table2];

}


#pragma mark uiTableViewDelegate;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{



    return 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * stic=@"indexPath";

    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:stic];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stic];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   [BKview makeScrollViewContentoffsetWithLeftView];
    
    [self.delegate leftViewButtonClick:^{
        
        BKview.notShowView=YES;
        [BKview chageViewFrame];
        
    }];
    



}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{

    
    BKview.frame=self.view.bounds;
    
    [BKview chageViewFrame];


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
