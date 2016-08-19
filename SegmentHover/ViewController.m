//
//  ViewController.m
//  SegmentHover
//
//  Created by 马锦航 on 16/8/19.
//  Copyright © 2016年 JHMang. All rights reserved.
//

#import "ViewController.h"
#import "TTHoverViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;


@end

@implementation ViewController

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}


#pragma mark - application

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"Demo";
    [self loadSubviews];
    
    [self pushToHoverViewController];
    
}


#pragma mark - view

- (void) loadSubviews {
    [self.view addSubview:self.tableView];
}



#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    cell.textLabel.text = @"悬停";
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self pushToHoverViewController];
            break;
            
        default:
            break;
    }
}







#pragma mark - method



- (void) pushToHoverViewController {
    TTHoverViewController * hoverViewController = [[TTHoverViewController alloc] init];
    [self.navigationController pushViewController:hoverViewController animated:YES];
}


















@end
