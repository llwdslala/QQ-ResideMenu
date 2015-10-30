//
//  FirstViewController.m
//  QQLateralSpreadsMenu
//
//  Created by siwangxuangao on 15/4/10.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

#import "ThirdViewController.h"

@interface FirstViewController ()<SecondViewControllerDelegate,ThirdViewControllerDelegate>
{
    UIButton * _selectedBtn;
    block _myBlock;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor=[UIColor purpleColor];
    
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"xingxing_yellow"] forState:UIControlStateNormal];
    button.frame=CGRectMake(20 ,10, 75,40);
    button.backgroundColor=[UIColor blueColor];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * button2=[UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:[UIImage imageNamed:@"xingxing_yellow"] forState:UIControlStateNormal];
    button2.frame=CGRectMake(250, 10, 60, 40);
    button2.backgroundColor=[UIColor yellowColor];
    [button2 setTitle:@"右边" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClickTwo) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem * leftBar=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIBarButtonItem * rightBar=[[UIBarButtonItem alloc]initWithCustomView:button2];
    
    
    self.navigationItem.leftBarButtonItem=leftBar;
    
    self.navigationItem.rightBarButtonItem=rightBar;

    for(int i=0;i<4;i++){
    
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[NSString stringWithFormat:@"stye%d",i+1] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"选中%d",i+1] forState:UIControlStateSelected];
        btn.frame=CGRectMake(100,100+(i*80), 100, 60);
        btn.backgroundColor=[UIColor blueColor];
        btn.tag=100+i;
        [btn addTarget:self action:@selector(BtnDown:) forControlEvents:UIControlEventTouchUpInside];
        button.selected=NO;
        
        [self.view addSubview:btn];

    }

    

}



-(void)BtnDown:(UIButton*)btn{
    _selectedBtn.selected=NO;
    btn.selected=YES;
    _selectedBtn=btn;
    
    switch (btn.tag) {
        case 100:
            [self.delegate stateBtnDown1];
            break;
        case 101:
              [self.delegate stateBtnDown2];
            break;
        case 102:
              [self.delegate stateBtnDown3];
            break;
        case 103:
              [self.delegate stateBtnDown4];
            break;
        default:
            break;
    }
    
    
    
    




}



-(void)buttonClick{

    NSLog(@"左面点击方法");
    
    
    [self.delegate leftItemBtnClick];

    
}
-(void)buttonClickTwo{

    
    NSLog(@"y-=-==-=右侧电极犯法");
    
    [self.delegate rightItemBtnClick];


}

-(void)leftViewButtonClick:(block)endBlock{


    
    ThirdViewController * third=[[ThirdViewController alloc]init];
    
    [self.navigationController pushViewController:third animated:YES];
    third.delegate=self;
    
   _myBlock=endBlock;
    
    
}


-(void)pushEnd{

    _myBlock();

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
