//
//  MasonryViewController.m
//  CocoaPod
//
//  Created by HanYong on 2018/5/20.
//  Copyright © 2018年 HanYong. All rights reserved.
//

#import "MasonryViewController.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;

@interface MasonryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UILabel *inputLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *dataArray;
    
@end

@implementation MasonryViewController

-(instancetype)init{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
    
    
    WS(weakSelf);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.inputView = [UIView new];
    self.inputView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.inputView];
    
    self.inputLabel = [UILabel new];
    self.inputLabel.text = @"123";
    self.inputLabel.backgroundColor = [UIColor orangeColor];
    [self.inputView addSubview:self.inputLabel];
    
    self.iconImageView = [UIImageView new];
    self.iconImageView.backgroundColor = [UIColor yellowColor];
    [self.inputView addSubview:self.iconImageView];
    
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor redColor];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDdata)];
    self.tableView.mj_footer.tintColor = [UIColor redColor];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(80);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.equalTo(@30);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputView).with.offset(5);
        make.top.equalTo(self.inputView).with.offset(5);
        make.bottom.equalTo(self.inputView).with.offset(-5);
        make.width.equalTo(self.iconImageView.mas_height);
    }];
    
    [self.inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).with.offset(5);
        make.top.equalTo(self.iconImageView.mas_top);
        make.bottom.equalTo(self.iconImageView.mas_bottom);
        make.right.equalTo(self.inputView).with.offset(-5);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).with.offset(5);
        make.bottom.equalTo(self.view).with.offset(-54);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view);
    }];
}

-(void)refreshControlAction{
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中。。。"];
        
        //请求数据
        [self requestData];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }
}

- (void)loadMoreDdata{
    
    [NSThread sleepForTimeInterval:2.0];
    for (int i=0; i<5; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",(int)self.dataArray.count + i + 1];
        [self.dataArray addObject:str];
    }
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

-(void)requestData{
    
    [NSThread sleepForTimeInterval:2.0];
    for (int i=0; i<5; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",(int)self.dataArray.count + i + 1];
        [self.dataArray addObject:str];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
