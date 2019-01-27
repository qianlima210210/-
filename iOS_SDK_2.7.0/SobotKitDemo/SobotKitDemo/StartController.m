//
//  StartController.m
//  SobotKitFrameworkTest
//
//  Created by zhangxy on 2017/10/30.
//  Copyright © 2017年 zhichi. All rights reserved.
//

#import "StartController.h"
#import "ViewController.h"
#import "PlatformTestController.h"
#import <SobotKit/SobotKit.h>

@interface StartController ()

@end

@implementation StartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)buttonClick:(UIButton *)sender{
    if(sender.tag == 2){
        [[ZCLibClient getZCLibClient] setPlatformUnionCode:@""];
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //获取Main.storyboard中的第2个视图
        ViewController *secondController = [mainStory instantiateViewControllerWithIdentifier:@"toNormal"];
        [self.navigationController pushViewController:secondController animated:YES];
    }
    if(sender.tag == 1){
        [ZCLibClient getZCLibClient].platformUnionCode = @"1001";
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //获取Main.storyboard中的第2个视图
        PlatformTestController *secondController = [mainStory instantiateViewControllerWithIdentifier:@"toPlat"];
        [self.navigationController pushViewController:secondController animated:YES];
    }
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
