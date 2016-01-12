//
//  CCPopView.h
//  PopViewDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPopView : UIView
/**
 *  create a popview control
 *
 *  @param frame        frame of the popview
 *  @param titleDataArr the name of cell
 *  @param imagedataArr the imageviewname of cell
 *  @param action       block
 *  @param animate      animating
 */
+ (void)addPopViewWithWindowFrame:(CGRect)frame
                     titleDataArr:(NSMutableArray *)titleDataArr
                     imagedataArr:(NSMutableArray *)imagedataArr
                           action:(void(^)(NSInteger index))action
                         animated:(BOOL)animate;
/**
 *  manual hidden
 */
+ (void)hiden;


@end
