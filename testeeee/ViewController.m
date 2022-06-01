//
//  ViewController.m
//  testeeee
//
//  Created by dizhenchao on 2022/6/1.
//

#import "ViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshNormalHeader.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) UIView *topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50) style:UITableViewStylePlain];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    [self.tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tabView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    self.tabView.contentOffset = CGPointMake(0, -250);
    [self.view addSubview:self.tabView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [self.tabView.mj_header endRefreshing];
        });
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tabView.mj_header = header;
    
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 250)];
    self.topView.backgroundColor = [UIColor grayColor];
    self.topView.alpha = 0.5;
    [self.view addSubview:self.topView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"sss==%ld",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= -scrollView.contentInset.top) {
        CGFloat top = 50 - (scrollView.contentOffset.y + scrollView.contentInset.top);
        self.topView.frame = CGRectMake(0, top, self.view.frame.size.width, 250);
    } else {
        self.topView.frame = CGRectMake(0, 50, self.view.frame.size.width, 250);
    }
}

@end
