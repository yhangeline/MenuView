//
//  MenuView.h
//  WechatMenuView
//
//  Created by yh on 15/11/25.
//  Copyright © 2015年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dismissCompletion)(void);



typedef enum : NSUInteger {
    kLeftTriangle,
    kRightTriangle,
} TriangleDirection;

@protocol MenuViewDelegate <NSObject>

- (void)MenuItemDidSelected:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;

@end


@interface MenuView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<MenuViewDelegate>delegate;

@property (nonatomic, copy) void(^selectedBlock)(NSInteger index);

/**
 *  初始化方法
 *
 *  @param titleArray 每个title
 *  @param imageArray 每个title对应的imageName
 *  @param origin     菜单的起始点
 *  @param width      菜单的宽度
 *  @param rowHeight  每个item的高度
 *  @param direct     TriangleDirection三角位置kLeftTriangle左，kRightTriangle右
 */
- (id)initWithTitleArray:(NSArray*)titleArray imageArray:(NSArray*)imageArray origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight Direct:(TriangleDirection)triDirect;

/**
 *  隐藏
 *
 *  @param completion 隐藏后block
 */
- (void)dismissMenuView:(dismissCompletion)completion;

@end
