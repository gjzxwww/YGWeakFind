//
//  UIViewController+YGWeakFind.m
//  YYKitDemo
//
//  Created by wyg on 2020/3/12.
//  Copyright © 2020 ibireme. All rights reserved.
//

#import "UIViewController+YGWeakFind.h"
#import <objc/runtime.h>

const char *YGWEAKFINDFLAG = "YGWEAKFINDFLAG";

@implementation UIViewController (YGWeakFind)
+(void)load
{
     static dispatch_once_t onceToken;
   
       dispatch_once(&onceToken, ^{
           
           [self swizellSel:@selector(viewWillAppear:) with:@selector(YG_viewWillAppear:)];
            [self swizellSel:@selector(viewDidDisappear:) with:@selector(YG_viewDidDisappear:)];
            [self swizellSel:@selector(dismissViewControllerAnimated:completion:) with:@selector(YG_dismissViewControllerAnimated:completion:)];
           
       });
       
}

+(void)swizellSel:(SEL)orginSel with:(SEL)changeSel
{
    Class class = [self class];
    Method orginMethod = class_getInstanceMethod(class, orginSel);
    Method changeMethod = class_getInstanceMethod(class, changeSel);
    
    BOOL didAdd = class_addMethod(class, orginSel, method_getImplementation(changeMethod), method_getTypeEncoding(changeMethod));
    
    if (didAdd)
    {
        class_replaceMethod(class, changeSel, method_getImplementation(orginMethod), method_getTypeEncoding(orginMethod));
    }else
    {
        method_exchangeImplementations(orginMethod, changeMethod);
    }
    
    
    
}


//绑定一个判断值
-(void)YG_viewWillAppear:(BOOL)animated
{
    [self YG_viewWillAppear:animated];
    
    objc_setAssociatedObject(self, YGWEAKFINDFLAG, @(NO), OBJC_ASSOCIATION_ASSIGN);
}

-(void)YG_viewDidDisappear:(BOOL)animated
{
    [self YG_viewDidDisappear:animated];
    
    BOOL isFlagYes =  [objc_getAssociatedObject(self, YGWEAKFINDFLAG) boolValue];
    if (isFlagYes)
    {
        [self willDealloc];
    }
}


-(void)YG_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    objc_setAssociatedObject(self, YGWEAKFINDFLAG, @(YES), OBJC_ASSOCIATION_ASSIGN);
    [self YG_dismissViewControllerAnimated:flag completion:completion];
    
}

-(void)willDealloc
{
    __weak typeof (self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         __strong typeof (self) strongSelf = weakSelf;
        
        if (strongSelf!=nil)
        {
             NSLog(@"存在内存泄漏----%@",strongSelf);
        }
       
    });
}
@end
