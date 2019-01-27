//
//  PlatformTestController.m
//  SobotKitFrameworkTest
//
//  Created by zhangxy on 2017/9/5.
//  Copyright © 2017年 zhichi. All rights reserved.
//

#import "PlatformTestController.h"
#import <SobotKit/SobotKit.h>
#import "ViewController.h"

@interface PlatformTestController ()

@end

@implementation PlatformTestController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //     [self hideTabBar:YES];
    self.navigationController.toolbarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark 设置默认APPKEY
    NSString *appKey_Text = [[NSUserDefaults standardUserDefaults] valueForKey:@"appKey_Text"];
            appKey_Text = @"1ff3e4ff91314f5ca308e19570ba24bb";// 请注册Appkey
   
    _textAppkey.text = appKey_Text;
    
    _textUserId.text=@"";
    
    
    self.title = @"智齿SDK平台版本";
    
    UIGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere1:)];
    [self.view addGestureRecognizer:tap];
    
    [ZCLibClient getZCLibClient].platformUnionCode = @"1001";
    
}


//屏幕点击事件
- (void)didTapAnywhere1:(UITapGestureRecognizer *)recognizer {
    [_textAppkey resignFirstResponder];
    [_textUserId resignFirstResponder];
    
    
}


-(IBAction)startPlatformServer:(id)sender{
    //  初始化配置信息
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    // 获取AppKey
    initInfo.appKey = _textAppkey.text;
    initInfo.userId = _textUserId.text;
//    initInfo.userId = @"569";
    initInfo.platformKey = @"私钥（电商版使用）";
    [[ZCLibClient getZCLibClient] setLibInitInfo:initInfo];
    
    
    ZCKitInfo *uiInfo=[ZCKitInfo new];
    uiInfo.navcBarHidden = YES;
    // 测试模式
//    [ZCSobot setShowDebug:YES];
    
    // 智齿SDK初始化启动事例
    [ZCSobot startZCChatVC:uiInfo
                      with:self
                    target:nil
                 pageBlock:^(ZCChatController *object,ZCPageBlockType type){
                     
                 } messageLinkClick:nil];
    
}


-(IBAction)startListServer:(id)sender{
    ZCLibInitInfo *info = [ZCLibClient getZCLibClient].libInitInfo;
    if(!info){
        info = [ZCLibInitInfo new];
    }
    info.userId = _textUserId.text;
    info.apiHost = _textApiHost.text;;
    [[ZCLibClient getZCLibClient] setLibInitInfo:info];
    
    ZCKitInfo *uiInfo=[ZCKitInfo new];
    uiInfo.navcBarHidden = YES;
   
    uiInfo.customBannerColor = [UIColor redColor];
    uiInfo.topBackNolColor = [UIColor clearColor];
    
    
    [ZCSobot startZCChatListView:uiInfo with:self onItemClick:^(ZCUIChatListController *object, ZCPlatformInfo *info) {
        [ZCSobot startZCChatVC:uiInfo with:object target:nil pageBlock:^(id object, ZCPageBlockType type) {
            
        } messageLinkClick:nil];
    }];
}



-(IBAction)cloaseAPP:(id)sender{
    
//    [[ZCLibClient getZCLibClient] removePush:^(NSString *uid, NSData *token, NSError *error) {
//        
//    }];
}

-(IBAction)buttonClick:(UIButton *)sender{
    if(sender.tag == 13){
//        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        //获取Main.storyboard中的第2个视图
//        ViewController *secondController = [mainStory instantiateViewControllerWithIdentifier:@"oldSettingVC"];
//        [self.navigationController popToViewController:secondController animated:YES];
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
