//
//  ViewController.m
//  PopViewDemo
//
//  Created by admin on 16/1/11.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import "ViewController.h"
#import "CCPopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)addclick:(id)sender {
    // create a popview
    NSMutableArray * titdataArr = [NSMutableArray arrayWithObjects:@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱", nil];
    NSMutableArray * imagedataArr = [NSMutableArray arrayWithObjects:@"saoyisao.png",@"jiahaoyou.png",@"taolun.png",@"diannao.png",@"diannao.png",@"shouqian.png", nil];
    [CCPopView addPopViewWithWindowFrame:CGRectMake(self.view.bounds.size.width - 100 , 64, 150, 200) titleDataArr:titdataArr imagedataArr:imagedataArr action:^(NSInteger index) {
        // invoke the action
    } animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
