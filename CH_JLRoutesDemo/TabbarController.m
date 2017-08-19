//
//  TabbarController.m
//  CH_JLRoutesDemo
//
//  Created by 陈浩 on 2017/6/29.
//  Copyright © 2017年 陈浩. All rights reserved.
//

#import "TabbarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "JLRoutes.h"
#import "NavigationController.h"
#import <objc/runtime.h>

@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *one = [[FirstViewController alloc]init];
    NavigationController *nav1 = [[NavigationController alloc]initWithRootViewController:one];
    nav1.tabBarItem.title = @"模块一";
    [self addChildViewController:nav1];
    
    SecondViewController *two = [[SecondViewController alloc]init];
    NavigationController *nav2 = [[NavigationController alloc]initWithRootViewController:two];
    nav2.tabBarItem.title = @"模块二";
    [self addChildViewController:nav2];
    
    ThirdViewController *three = [[ThirdViewController alloc]init];
    NavigationController *nav3 = [[NavigationController alloc]initWithRootViewController:three];
    nav3.tabBarItem.title = @"模块三";
    [self addChildViewController:nav3];
    
    
    /**
     注册block 
     
     这段代码并不一定要写在这，可以在很多地方，只要 [JLRoutes routeURL:url];这段代码执行之前就行，因为[JLRoutes routeURL:url]是block回调，如果没有注册之前执行的话会出现野指针闪退
     

     @param parameters 这个字典是根据url生成的
    
     */
    [[JLRoutes globalRoutes]addRoute:@"/:toController/:paramOne/:paramTwo/:paramThree/:paramFour" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        Class class = NSClassFromString(parameters[@"toController"]);
        UIViewController *vc = [[class alloc]init];
        NSURL *headUrl = parameters[JLRouteURLKey];
        NSString *head = [headUrl.absoluteString componentsSeparatedByString:@"://"].firstObject;
        if ([head isEqualToString:@"JLRoutesOne"]) {
            [nav1 pushViewController:vc animated:YES];
        }else if ([head isEqualToString:@"JLRoutesTwo"]){
            [nav2 pushViewController:vc animated:YES];
        }else if([head isEqualToString:@"JLRoutesThree"]){
            [nav3 pushViewController:vc animated:YES];
        }
        
        return YES;
    }];
    
    //回调
    [[JLRoutes routesForScheme:@"JLRoutesOne"] addRoute:@"/NaviPop/:toController/:paramOne/:paramTwo/:paramThree/:paramFour" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        Class aclass = NSClassFromString(parameters[@"toController"]);
        if (aclass) {
            UIViewController *currentVc = [self currentViewController];
            if (currentVc.navigationController) {
                for (UIViewController *vc in currentVc.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[aclass class]]) {
                        
                        [self paramToVc:vc param:parameters];
                        [currentVc.navigationController popToViewController:vc animated:YES];
                    }
                }
            }else{
                [currentVc dismissViewControllerAnimated:YES completion:^{
                }];
            }
        }
        
        return YES;
    }];
    
    [[JLRoutes routesForScheme:@"JLRoutesOne"] addRoute:@"/:toController/:paramOne/:paramTwo/:paramThree/:paramFour" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        //获取到跳转前的视图
        UIViewController *currentVc = [self currentViewController];
        UIViewController *v = [[NSClassFromString(parameters[@"toController"]) alloc] init];
        [self paramToVc:v param:parameters];
        [currentVc.navigationController pushViewController:v animated:YES];
        return YES;
    }];
    
    [[JLRoutes routesForScheme:@"JLRoutesTwo"] addRoute:@"/:toController/:paramOne/:paramTwo/:paramThree/:paramFour" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        UIViewController *currentVc = [self currentViewController];
        UIViewController *v = [[NSClassFromString(parameters[@"toController"]) alloc] init];
        [self paramToVc:v param:parameters];
        [currentVc.navigationController pushViewController:v animated:YES];
        return YES;
    }];
    
    
}



//界面传参
-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    // runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

//获取当前控制器
-(UIViewController *)currentViewController{
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [UIApplication sharedApplication].keyWindow.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}


    // Do any additional setup after loading the view.

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
