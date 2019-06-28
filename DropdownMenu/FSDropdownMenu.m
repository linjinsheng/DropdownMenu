//
//  FSDropdownMenu.m
//  FSIPM
//
//  Created by nickwong on 18/12/11.
//  Copyright © 2018年 nickwong. All rights reserved.
//

#import "FSDropdownMenu.h"

@interface FSDropdownMenu()
/**
 *  将来用来显示具体内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;
@end

@implementation FSDropdownMenu

- (UIImageView *)containerView
{
    if (!_containerView) {
        // 添加一个图片控件
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.layer.cornerRadius = 5;
        containerView.userInteractionEnabled = YES; //开启互动
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        self.layer.shadowOffset =  CGSizeMake(2, 2);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowColor =  [UIColor blackColor].CGColor;
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc]init];
}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    // 调整内容的位置
    content.x = 0;
    content.y = 0;
    
    // 设置高度
    self.containerView.height = CGRectGetMaxY(content.frame);
    // 设置宽度
    self.containerView.width = CGRectGetMaxX(content.frame);
    
    // 添加内容到图片中
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}

/**
 *  显示
 */
- (void)showFrom:(UIView *)from
{
    //  1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整灰色图片的位置
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame)-10;
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    // 通知外界，自己显示了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
        
    }
}

/**
 *  销毁
 */
- (void)dismiss
{
    [self.content removeFromSuperview];
    self.content = nil;
    
    self.contentController = nil;
    
    [self removeFromSuperview];
    
    // 通知外界，自己被销毁了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

- (void)dealloc
{
    NSLog(@"view dealloc");
}

@end
