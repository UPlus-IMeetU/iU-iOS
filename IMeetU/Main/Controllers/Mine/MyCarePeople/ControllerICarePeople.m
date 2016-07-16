//
//  ControllerICarePeople.m
//  IMeetU
//
//  Created by Spring on 16/7/15.
//  Copyright © 2016年 zhanghao. All rights reserved.
//
#import "XMHttpCouple.h"
#import "EnumHeader.h"
#import "XMNetworkErr.h"

#import <YYKit/YYKit.h>
#import "ModelCoupleList.h"
#import "ModelCouple.h"
#import "CoupleViewCell.h"

#import "ControllerICarePeople.h"


#import "UIViewAdditions.h"
#import "UIScreen+Plug.h"
#import "UINib+Plug.h"
#import "UIColor+Plug.h"
#import "MJRefresh.h"
#import "MJIUHeader.h"
#import "ControllerMineMain.h"
#define ScreenWidth [UIScreen screenWidth]
#define ScreenHeight [UIScreen screenHeight]
@interface ControllerICarePeople ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * coupleTableView;
@property (nonatomic,strong) NSMutableArray *coupleListArray;
@property (nonatomic,strong) XMNetworkErr *xmNetworkErr;
@end

@implementation ControllerICarePeople

- (void)viewDidLoad {
    _coupleListArray = [NSMutableArray array];
    [super viewDidLoad];
    [self prepareData];
    [self prepareUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)prepareUI{
    [self.view addSubview:self.coupleTableView];
}

- (void)prepareData{
    //加载数据
    _coupleListArray = [NSMutableArray array];
    [self loadData];
}

- (void)loadData{
    __weak typeof(self) weakSelf = self;
    [[XMHttpCouple http] xmGetMyCareAboutPeopleWithBlock:^(NSInteger code, id response, NSURLSessionDataTask *task, NSError *error) {
        [_coupleTableView.mj_header endRefreshing];
        if (code == 200) {
            [_xmNetworkErr destroyView];
            ModelCoupleList *modelCoupleList = [ModelCoupleList modelWithJSON:response];
                [weakSelf.coupleListArray removeAllObjects];
                weakSelf.coupleListArray = [NSMutableArray arrayWithArray:modelCoupleList.users];
            [weakSelf.coupleTableView reloadData];
        }else{
            if (!_xmNetworkErr) {
                _xmNetworkErr = [[XMNetworkErr viewWithSuperView:self.view y:80 titles:@[@"呜呜，内容加载失败了",@"点击重新加载"] callback:^(XMNetworkErr *view) {
                    [weakSelf loadData];
                }] showView];
            }
        }
    }];
}


- (UITableView *)coupleTableView{
    if (!_coupleTableView) {
        _coupleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        _coupleTableView.backgroundColor = [UIColor often_EEEEEE:1];
        _coupleTableView.delegate = self;
        _coupleTableView.dataSource = self;
        __weak typeof (self) weakSelf = self;
        _coupleTableView.mj_header = [MJIUHeader headerWithRefreshingBlock:^{
            [weakSelf loadData];
        }];
        _coupleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [((MJIUHeader *)_coupleTableView.mj_header) initGit];
        [_coupleTableView registerNib:[UINib xmNibFromMainBundleWithName:@"CoupleViewCell"] forCellReuseIdentifier:@"CoupleViewCell"];
    }
    return _coupleTableView;
}

#pragma mark UITableViewDelegate,UITableViewDataSourse
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"CoupleViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ModelCouple *modelCouple = _coupleListArray[indexPath.row];
        ((CoupleViewCell*)cell).modelCouple = modelCouple;
  
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _coupleListArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 107;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        ModelCouple *modelCouple = _coupleListArray[indexPath.row];
        ControllerMineMain *mainMain = [ControllerMineMain controllerWithUserCode:[NSString stringWithFormat:@"%ld",modelCouple.user_code] getUserCodeFrom:MineMainGetUserCodeFromParam];
        [self.navigationController pushViewController:mainMain animated:YES];
  }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
