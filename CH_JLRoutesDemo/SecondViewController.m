//
//  SecondViewController.m
//  CH_JLRoutesDemo
//
//  Created by 陈浩 on 2017/6/29.
//  Copyright © 2017年 陈浩. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"第二模块";
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"跳转" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:1];
//    btn.frame = CGRectMake(100, 200, 100, 100);
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)jump
{
    NSString *url =  [NSString stringWithFormat:@"%@://%@/%@/%@/%@/%@",@"JLRoutesTwo", @"DestinationController", @"123", @"456", @"789", @"0"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:nil completionHandler:nil];
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
