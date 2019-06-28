//
//  FSProSortViewController.h
//  FSIPM
//
//  Created by nickwong on 18/12/11.
//  Copyright © 2018年 nickwong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSProSortViewController : UIViewController

@property (nonatomic, copy) void(^didSelectedSortTypeHandler)(void);

@end
