//
//  UINavigationController+YGWeakFind.m
//  YYKitDemo
//
//  Created by wyg on 2020/3/12.
//  Copyright © 2020 ibireme. All rights reserved.
//

#import "UINavigationController+YGWeakFind.h"

#import <objc/runtime.h>


@implementation UINavigationController (YGWeakFind)

+(void)load
{
     static dispatch_once_t onceToken;
   
       dispatch_once(&onceToken, ^{
           
           [self swizellSel:@selector(popViewControllerAnimated:) with:@selector(YG_popViewControllerAnimated:)];
           
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


- (UIViewController *)YG_popViewControllerAnimated:(BOOL)animated
{
    UIViewController *popVC = [self YG_popViewControllerAnimated:animated];
    
    extern const char *YGWEAKFINDFLAG ;
    
    objc_setAssociatedObject(popVC, YGWEAKFINDFLAG, @(YES), OBJC_ASSOCIATION_ASSIGN);
    
    return popVC;
    
}


@end
