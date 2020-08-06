//
//  TestViewController.m
//  YGWeakFind_Example
//
//  Created by wyg on 2020/8/6.
//  Copyright © 2020 gjzxwyg@163.com. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property(nonatomic,strong)CADisplayLink *link;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //随便写一个会导致控制器无法释放的代码
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(test)] ;
    
       [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.link = link;
}

-(void)test
{
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    NSArray *viewcontrollers=self.navigationController.viewControllers;
     
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
        {
            //push方式
           [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
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
