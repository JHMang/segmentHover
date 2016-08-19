//
//  TTHoverViewController.m
//  SegmentHover
//
//  Created by 马锦航 on 16/8/19.
//  Copyright © 2016年 JHMang. All rights reserved.
//

#import "TTHoverViewController.h"

@interface TTHoverViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>


/// **************************************尺寸适配宏****************************************
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y

#define RectMaxX(f)                         CGRectGetMaxX(f)
#define RectMaxY(f)                         CGRectGetMaxY(f)
#define RectMinX(f)                         CGRectGetMinX(f)
#define RectMinY(f)                         CGRectGetMinY(f)


#define RectX(f)                            (f.origin.x)
#define RectY(f)                            (f.origin.y)
#define RectBottom(f)                       (f.origin.y + f.size.height)
#define RectTrailing(f)                     (f.origin.x + f.size.width)

#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)



@property (nonatomic,strong) UIView * headerView;

@property (nonatomic,strong) UISegmentedControl * segmentControl;
@property (nonatomic,strong) UIScrollView * bottomLine;
@property (nonatomic,strong) UITableView * tableView;



@end

@implementation TTHoverViewController

#pragma mark - 懒加载

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
        _headerView.backgroundColor = [UIColor yellowColor];
    }
    return _headerView;
}

//  系统segment
- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"商品",@"评价",@"详情"]];
        _segmentControl.frame = CGRectMake(0, RectBottom(self.headerView.frame), ScreenWidth, 40);
        _segmentControl.tintColor = [UIColor clearColor];
        _segmentControl.backgroundColor = [UIColor whiteColor];
        NSDictionary * selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor greenColor]};
        [_segmentControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        
        NSDictionary * unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]};
        [_segmentControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        
        [_segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}


-(UIScrollView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIScrollView alloc] init];
        _bottomLine.frame = CGRectMake(0, RectBottom(self.segmentControl.frame), ScreenWidth, 3);
        _bottomLine.delegate = self;
        _bottomLine.backgroundColor = [UIColor whiteColor];
        [_bottomLine addSubview:[self flagView]];
    }
    return _bottomLine;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(self.headerView.frame.size.height+self.segmentControl.frame.size.height+self.bottomLine.frame.size.height, 0, 0, 0);
    }
    return _tableView;
}



#pragma mark - application


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"悬停效果";
    
    [self loadSubviews];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
}


#pragma mark - view

- (void) loadSubviews {
    
    [self.view addSubview:self.tableView];

    [self.view addSubview:self.headerView];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.bottomLine];
    
}


- (UIView *) flagView {
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, ScreenWidth/self.segmentControl.numberOfSegments, self.segmentControl.frame.size.height);
    view.backgroundColor = [UIColor greenColor];
    return view;
}




#pragma mark - tableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.frame = CGRectMake(0, 0, ScreenWidth, 40);
    return cell;
}


#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
        CGFloat headerHeight = self.headerView.frame.size.height;
        CGFloat segmentHeight = self.segmentControl.frame.size.height;
        CGFloat offSet_y = scrollView.contentOffset.y;
        offSet_y += headerHeight+segmentHeight;
        
        if (offSet_y<=0) {
            self.headerView.frame = RectSetY(self.headerView.frame, 0);
            self.segmentControl.frame = RectSetY(self.segmentControl.frame, RectBottom(self.headerView.frame));
            _bottomLine.frame = CGRectMake(0, RectBottom(self.segmentControl.frame), ScreenWidth, 3);
            return;
        }
        if (offSet_y>=headerHeight) {
            self.headerView.frame = RectSetY(self.headerView.frame, 0-headerHeight);
            self.segmentControl.frame = RectSetY(self.segmentControl.frame, RectBottom(self.headerView.frame));
            _bottomLine.frame = CGRectMake(0, RectBottom(self.segmentControl.frame), ScreenWidth, 3);
            return;
        }
        
        self.headerView.frame = RectSetY(self.headerView.frame, 0-offSet_y);
        self.segmentControl.frame = RectSetY(self.segmentControl.frame, RectBottom(self.headerView.frame));
        _bottomLine.frame = CGRectMake(0, RectBottom(self.segmentControl.frame), ScreenWidth, 3);
    }
    
}


#pragma mark - action


- (void) segmentControlAction:(UISegmentedControl *) segmentControl {
    [self.bottomLine setContentOffset:CGPointMake(-self.segmentControl.selectedSegmentIndex*(ScreenWidth/self.segmentControl.numberOfSegments), 0) animated:YES];
}



















@end
