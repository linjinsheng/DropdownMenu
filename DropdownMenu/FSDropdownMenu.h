//
//  FSDropdownMenu.h
//  FSIPM
//
//  Created by nickwong on 18/12/11.
//  Copyright © 2018年 nickwong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSDropdownMenu;

@protocol FSDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(FSDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(FSDropdownMenu *)menu;
@end

@interface FSDropdownMenu : UIView
@property (nonatomic, weak) id<FSDropdownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

@end
