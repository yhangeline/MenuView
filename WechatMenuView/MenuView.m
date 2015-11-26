//
//  MenuView.m
//  WechatMenuView
//
//  Created by yh on 15/11/25.
//  Copyright © 2015年 yh. All rights reserved.
//

#import "MenuView.h"

#define TopToView 10.0f
#define LeftToView 10.0f
#define CellLineEdgeInsets UIEdgeInsetsMake(0, 10, 0, 10)
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight        [UIScreen mainScreen].bounds.size.height

@implementation MenuView
{
    NSArray *_titleArray;
    NSArray *_imageArray;
    CGPoint _origin;
    CGFloat _width;
    TriangleDirection _direct;
    
    UITableView *_tableView;
}

- (id)initWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight Direct:(TriangleDirection)triDirect
{
    if (self = [super init]) {
        _titleArray = [titleArray copy];
        _imageArray = [imageArray copy];
        _origin = origin;
        _width = width;
        _direct = triDirect;
        
        CGFloat height = rowHeight < 44 ? 44 : rowHeight;
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(LeftToView + origin.x, TopToView + origin.y, width, titleArray.count*height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        _tableView.layer.cornerRadius = 5;
        _tableView.bounces = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ide"];
        
        //设置cell举例table的距离
        _tableView.layoutMargins = UIEdgeInsetsMake(0, 5, 0, 5);
        
        //分割线位置
        _tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
        [self addSubview:_tableView];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ide"];
    cell.backgroundColor = [UIColor clearColor];
    
    //设置cell的选中状态
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor blackColor];
    
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    [cell.textLabel sizeToFit];
    
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(MenuItemDidSelected:indexPath:)]) {
        [self.delegate MenuItemDidSelected:tableView indexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissMenuView:nil];
}

- (void)dismissMenuView:(dismissCompletion)completion
{
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.alpha = 0;
        if (_direct == kLeftTriangle) {
            _tableView.frame = CGRectMake(LeftToView + _origin.x, TopToView + _origin.y, 0, 0);
        }
        else
        {
            _tableView.frame = CGRectMake(LeftToView + _tableView.frame.size.width + 5, TopToView + _origin.y, 0, 0);
        }
        _tableView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}

- (void)drawRect:(CGRect)rect
{
    //拿到当前视图准备好的画板
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    
    if (_direct == kLeftTriangle)
    {
        CGContextMoveToPoint(context,
                             (_origin.x + LeftToView) + 10, (_origin.y + TopToView) - 5);//设置起点
        
        CGContextAddLineToPoint(context,
                                (_origin.x + LeftToView) + 5, (_origin.y + TopToView));
        
        CGContextAddLineToPoint(context,
                                (_origin.x + LeftToView) + 15, (_origin.y + TopToView));
    }
    else
    {
        CGContextMoveToPoint(context,
                             (LeftToView +  _tableView.frame.size.width) + 0, (_origin.y + TopToView) - 5);//设置起点
        
        CGContextAddLineToPoint(context,
                                (LeftToView + _tableView.frame.size.width) - 5, (_origin.y + TopToView));
        
        CGContextAddLineToPoint(context,
                                (LeftToView + _tableView.frame.size.width) + 5, (_origin.y + TopToView));
    }
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
//    [self.tableView.backgroundColor setFill]; //设置填充色
//    
//    [self.tableView.backgroundColor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissMenuView:^{
        
    }];
}

@end
