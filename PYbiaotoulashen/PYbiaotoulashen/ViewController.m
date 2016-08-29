//
//  ViewController.m
//  PYbiaotoulashen
//
//  Created by Apple on 16/7/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "RootViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
- (IBAction)buttonAction:(UIButton *)sender {
    RootViewController *rootVC = [[RootViewController alloc] init];
    [self.navigationController pushViewController:rootVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
