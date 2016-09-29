//
//  ViewController.m
//  ZYYCodePayDemo
//
//  Created by liguo.chen on 16/9/29.
//  Copyright © 2016年 Slience. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "ZYYCodePayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"一码付";
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor redColor]}];
    
    UIButton *codePayBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 50)];
    codePayBtn.backgroundColor = [UIColor purpleColor];
    [codePayBtn setTitle:@"一码付" forState:UIControlStateNormal];
    [codePayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codePayBtn addTarget:self action:@selector(codePayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codePayBtn];
    
}

-(void)codePayAction {
    ZYYCodePayViewController *payVc = [[ZYYCodePayViewController alloc] init];
    [self.navigationController pushViewController:payVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
