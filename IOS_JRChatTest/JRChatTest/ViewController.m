//
//  ViewController.m
//  JRChatTest
//
//  Created by ma qianli on 2019/1/25.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "ViewController.h"
#import <SobotKit/SobotKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //  初始化配置信息
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    initInfo.appKey = @"2c571948e96247fead08f23b6bb01c92";
    initInfo.userId = @"请输入用户的ID";
    
    //界面信息
    ZCKitInfo *uiInfo=[ZCKitInfo new];
    uiInfo.navcBarHidden = YES;
    uiInfo.topViewBgColor = UIColor.redColor;//导航栏背景颜色
    
    //是否直接显示转人工按钮
    //uiInfo.isShowTansfer = NO;
    
//    uiInfo.topViewTextColor = UIColor.blackColor;//导航栏文字颜色(返回，标题)
    
//    //自定义返回按钮上的图片
    //NSString *backPath = [[NSBundle mainBundle]pathForResource:@"back@2x.png" ofType:nil];
//    uiInfo.topBackNolImg = backPath;
//    uiInfo.topBackSelImg = backPath;
//
//    //自定义more按钮上的图片
    //NSString *morePath = [[NSBundle mainBundle]pathForResource:@"more@2x" ofType:@"png"];
//    uiInfo.moreBtnNolImg = morePath;
//    uiInfo.moreBtnSelImg = morePath;
    
    //人工客服按钮上的图片
//    uiInfo.turnBtnNolImg = morePath;
//    uiInfo.turnBtnSelImg = morePath;
    
    
    [[ZCLibClient getZCLibClient] setLibInitInfo:initInfo];
    
    // 智齿SDK初始化启动事例
    [ZCSobot startZCChatVC:uiInfo with:self target:nil pageBlock:^(id object, ZCPageBlockType type) {
        NSLog(@"%zd", type);
    } messageLinkClick:^(NSString *link) {
        
    }];
}

@end
