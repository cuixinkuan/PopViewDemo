//
//  CCPopView.m
//  PopViewDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import "CCPopView.h"

#define SCREEN_WIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

#define LeftView 10.0f
#define TopToView 10.0f

@interface CCPopView  ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,copy)NSMutableArray * titledataArr;
@property(nonatomic,copy)NSMutableArray * imagedataArr;

@property(nonatomic,copy)void(^action)(NSInteger index);

@end

CCPopView * backgroundView;
UITableView * tableView;

@implementation CCPopView

#pragma mark - initializer - 
- (instancetype)init {
    if (self = [super init]) {
        //
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        [self setNeedsDisplay];
    }
    return self;
}

#pragma mark - privote method -

+ (void)addPopViewWithWindowFrame:(CGRect)frame
                     titleDataArr:(NSMutableArray *)titleDataArr
                     imagedataArr:(NSMutableArray *)imagedataArr
                           action:(void (^)(NSInteger))action
                         animated:(BOOL)animate {
  
    if (backgroundView != nil) {
        [CCPopView hiden];
    }
    UIWindow * window = [[[UIApplication sharedApplication] windows] firstObject];
    backgroundView = [[CCPopView alloc] initWithFrame:window.bounds];
    backgroundView.action = action;
    backgroundView.titledataArr = titleDataArr;
    backgroundView.imagedataArr = imagedataArr;
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.7;
    [window addSubview:backgroundView];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 70 - 20.0*titleDataArr.count, frame.size.width, 40 * titleDataArr.count) style:0];
    tableView.dataSource = backgroundView;
    tableView.delegate = backgroundView;
    tableView.layer.masksToBounds = YES;
    tableView.layer.cornerRadius = 10.0f;
    tableView.layer.anchorPoint = CGPointMake(1.0, 0);
    tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    tableView.rowHeight = 40.0f;
    [window addSubview:tableView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundclick:)];
    [backgroundView addGestureRecognizer:tap];
    if (animate == YES) {
        backgroundView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 0.5;
            tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    
}

+ (void)tapBackgroundclick:(UITapGestureRecognizer *)gesture {
    [CCPopView hiden];
}

+ (void)hiden {
    if (backgroundView != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            tableView.transform = CGAffineTransformMakeScale(0.000001, 0.000001);
        } completion:^(BOOL finished) {
            [backgroundView removeFromSuperview];
            [tableView removeFromSuperview];
            backgroundView = nil;
            tableView = nil;
        }];
    }
}

#pragma mark - tableViewdatasource,tableViewDelegate - 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titledataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString * identifier = @"cell1";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:self.imagedataArr[indexPath.row]];
    cell.textLabel.text = _titledataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.action) {
        self.action(indexPath.row);
    }
    [CCPopView hiden];
}

#pragma mark - draw up triangle - 
- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    // draw up paths
    CGContextBeginPath(context);
    CGFloat location = SCREEN_WIDTH;
    CGContextMoveToPoint(context, location - LeftView - 10, 70);//起点
    CGContextAddLineToPoint(context, location - 2*LeftView - 10, 60);
    CGContextAddLineToPoint(context, location - TopToView*3 - 10, 70);
    CGContextClosePath(context);
    
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end
