//
//  FSProSortViewController.m
//  FSIPM
//
//  Created by nickwong on 18/12/11.
//  Copyright © 2018年 nickwong. All rights reserved.
//

#import "FSProSortViewController.h"
#import "FSDropdownMenu.h"
// 活动选择按钮行宽
#define  actBtnRowWidth 80
// 活动选择按钮行高
#define  actBtnRowHeight 40
// 消息正文字体
#define titleTextFont [UIFont systemFontOfSize:15 weight:UIFontWeightRegular]

@interface FSProSortViewController ()<FSDropdownMenuDelegate>

@property (nonatomic, copy) NSString *selectedSortStr;
@property (nonatomic, assign) NSInteger selectedSortType;

/** 排序数组 */
@property (nonatomic, strong) NSMutableArray *sortArray;

/** 排序Type数组 */
@property (nonatomic, strong) NSMutableArray *sortTypeArray;

@end

@implementation FSProSortViewController

/** 排序数组 */
- (NSMutableArray *)sortArray
{
    if (_sortArray == nil)
    {
        _sortArray = [NSMutableArray array];
    }
    
    return _sortArray;
}

/** 排序Type数组 */
- (NSMutableArray *)sortTypeArray
{
    if (_sortTypeArray == nil)
    {
        _sortTypeArray = [NSMutableArray array];
    }
    
    return _sortTypeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.96];
    
    CGFloat btnW = actBtnRowWidth;
    CGFloat btnH = actBtnRowHeight;
    CGFloat btnX = 0;
    
    FSNSUserDefault(FSUser);
        
    _sortArray = [FSUser objectForKey:@"sortArray"];
    _sortTypeArray = [FSUser objectForKey:@"sortTypeArray"];
    
    NSUInteger sortTypeCount = _sortArray.count;
    
    for (NSUInteger i = 0; i<sortTypeCount; i++) {
        UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 传递模型
        [sortBtn setTitle:_sortArray[i] forState:UIControlStateNormal];
        
        [sortBtn setTitleColor:[Tools getColor:@"4A556A" isSingleColor:YES] forState:UIControlStateNormal];
        [sortBtn setTitleColor:[Tools getColor:@"F6B65B" isSingleColor:YES] forState:UIControlStateHighlighted];
        sortBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.96];
        
        sortBtn.titleLabel.font = titleTextFont;
        
        sortBtn.width = btnW;
        sortBtn.height = btnH;
        sortBtn.x = btnX;
        sortBtn.y = i * btnH ;
        [sortBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        sortBtn.tag = [_sortTypeArray[i]integerValue];
        [self.view addSubview:sortBtn];
    }
    
    for (NSUInteger i = 1; i<sortTypeCount; i++)
    {
        UIView *gapView = [[UIView alloc]init];
        gapView.width = btnW;
        gapView.height = 1;
        gapView.x = btnX;
        gapView.y = i * btnH ;
        
        gapView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8];
        [self.view addSubview:gapView];
    }
}

- (void)buttonClick:(UIButton *)button
{
    NSString *selectedSort = button.titleLabel.text;;
    NSString *selectedSortType = [NSString stringWithFormat:@"%ld",(long)button.tag];
    
    //发送活动城市改变通知
    [FSNotificationCenter postNotificationName:SortTypeDidChangeNotification object:nil userInfo:@{@"selectedSort":selectedSort,@"selectedSortType":selectedSortType}];
    
    if (_didSelectedSortTypeHandler != nil)
    {
        _didSelectedSortTypeHandler();
    }
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

@end
