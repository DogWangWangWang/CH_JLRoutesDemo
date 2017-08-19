//
//  DestinationController.m
//  CH_JLRoutesDemo
//
//  Created by 陈浩 on 2017/6/29.
//  Copyright © 2017年 陈浩. All rights reserved.
//

#import "DestinationController.h"

@interface DestinationController ()

@end

@implementation DestinationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"目的视图";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我回调" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:1];
    btn.frame = CGRectMake(100, 200, 100, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lbl = [[UILabel alloc]init];
    lbl.backgroundColor = [UIColor lightGrayColor];
    lbl.text = [NSString stringWithFormat:@"%@%@%@%@",self.paramOne,self.paramTwo,self.paramThree,self.paramFour];
    lbl.frame = CGRectMake(100, CGRectGetMaxY(btn.frame) + 50, 250,50);
    [self.view addSubview:lbl];
    // Do any additional setup after loading the view.
}

-(void)jump{
    // NSString *url = @"Route://NaviPop/SettingViewController?userId=99999";
    NSString *url = [NSString stringWithFormat:@"%@://NaviPop/%@/%@/%@/%@/%@",@"JLRoutesOne",@"FirstViewController", self.paramOne,self.paramTwo,self.paramThree,self.paramFour];
    //若有中文传输需要进行转义
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<10.0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    }

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
