//
//  UIBarButtonItem+UIBarButtonItem.h
//  PYbiaotoulashen
//
//  Created by Apple on 16/7/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (UIBarButtonItem)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
