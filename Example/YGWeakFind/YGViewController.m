//
//  YGViewController.m
//  YGWeakFind
//
//  Created by gjzxwyg@163.com on 08/06/2020.
//  Copyright (c) 2020 gjzxwyg@163.com. All rights reserved.
//

#import "YGViewController.h"
#import "TestViewController.h"

@interface YGViewController ()

@end

@implementation YGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.navigationController pushViewController:[TestViewController new] animated:YES];
    
    [self presentViewController:[TestViewController new] animated:YES completion:nil];
}

@end
