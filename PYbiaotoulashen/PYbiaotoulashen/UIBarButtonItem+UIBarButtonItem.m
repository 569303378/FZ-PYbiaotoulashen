//
//  UIBarButtonItem+UIBarButtonItem.m
//  PYbiaotoulashen
//
//  Created by Apple on 16/7/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIBarButtonItem+UIBarButtonItem.h"

@implementation UIBarButtonItem (UIBarButtonItem)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}
@end
