//
//  ThirdViewController.m
//  CH_JLRoutesDemo
//
//  Created by 陈浩 on 2017/6/29.
//  Copyright © 2017年 陈浩. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"第三模块";
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"跳转" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:1];
//    btn.frame = CGRectMake(100, 200, 100, 100);
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
}

- (void)jump
{
    NSString *url =  [NSString stringWithFormat:@"%@://%@/%@/%@/%@/%@",@"JLRoutesThree", @"DestinationController", @"123", @"456", @"789", @"0"];
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
