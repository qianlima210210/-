//
//  PlatformTestController.h
//  SobotKitFrameworkTest
//
//  Created by zhangxy on 2017/9/5.
//  Copyright © 2017年 zhichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlatformTestController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textAppkey;

@property (weak, nonatomic) IBOutlet UITextField *textApiHost;
@property (weak, nonatomic) IBOutlet UISwitch *switView;
@property (weak, nonatomic) IBOutlet UITextField *textUserId;


-(IBAction)startPlatformServer:(id)sender;

-(IBAction)startListServer:(id)sender;

-(IBAction)buttonClick:(UIButton *)sender;


@end
