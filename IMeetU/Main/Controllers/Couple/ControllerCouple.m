#import "ControllerCouple.h"
#import "UIViewAdditions.h"
#import "UIScreen+Plug.h"
#import "UINib+Plug.h"
#import "UIColor+Plug.h"

#import "CoupleViewCell.h"
#import "MJRefresh.h"
#import "MJIUHeader.h"

#import "FilterView.h"
#import "ModelFilter.h"

#import "ControllerMyVoice.h"

#define Couple 10001
#define Square 10002
#define ScreenWidth [UIScreen screenWidth]
#define ScreenHeight [UIScreen screenHeight]
@interface ControllerCouple ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *backScrollView;
@property (nonatomic,strong) UITableView *squareTableView;
@property (nonatomic,strong) UITableView * coupleTableView;
@property (nonatomic,assign) NSUInteger type;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *choiceButton;
@property (nonatomic,strong) UIView *filterView;
@property (nonatomic,strong) UIView *filterChildView;
@end
@implementation ControllerCouple

+ (instancetype)shareControllerCouple{
    static ControllerCouple *controller;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[ControllerCouple alloc] init];
    });
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self prepareUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)prepareData{
    
}


- (void)prepareUI{
    [self.view addSubview:self.backScrollView];
    self.type = Couple;
    [_changeButton setShowsTouchWhenHighlighted:YES];
    [_backScrollView addSubview:self.squareTableView];
    [_backScrollView addSubview:self.coupleTableView];
    [_backScrollView addSubview:self.filterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeButtonClick:(id)sender {
    //切换成广场
    if (self.type == Couple) {
        self.type = Square;
        [_backScrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
        [UIView animateWithDuration:1 animations:^{
            _choiceButton.alpha = 0;
        }];
    }else{
    //切换成一半
        self.type = Couple;
        [_backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [UIView animateWithDuration:1 animations:^{
            _choiceButton.alpha = 1;
        }];
    }
}

- (UITableView *)squareTableView{
    if (!_squareTableView) {
        _squareTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, _backScrollView.height) style:UITableViewStylePlain];
        _squareTableView.backgroundColor = [UIColor often_EEEEEE:1];
        _squareTableView.delegate = self;
        _squareTableView.dataSource = self;
        _squareTableView.tag = Square;
        __weak typeof (self) weakSelf = self;
        _squareTableView.mj_header = [MJIUHeader headerWithRefreshingBlock:^{
            [weakSelf.squareTableView.mj_header endRefreshing];
        }];
        [((MJIUHeader *)_squareTableView.mj_header) initGit];
               _squareTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_squareTableView registerNib:[UINib xmNibFromMainBundleWithName:@"SquareViewCell"] forCellReuseIdentifier:@"SquareViewCell"];


    }
    return _squareTableView;
}


- (UITableView *)coupleTableView{
    if (!_coupleTableView) {
        _coupleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _backScrollView.height) style:UITableViewStylePlain];
        _coupleTableView.backgroundColor = [UIColor often_EEEEEE:1];
        _coupleTableView.delegate = self;
        _coupleTableView.dataSource = self;
        _coupleTableView.tag = Couple;
        __weak typeof (self) weakSelf = self;
        _coupleTableView.mj_header = [MJIUHeader headerWithRefreshingBlock:^{
            [weakSelf.coupleTableView.mj_header endRefreshing];
        }];
        _coupleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [((MJIUHeader *)_coupleTableView.mj_header) initGit];
        _coupleTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.coupleTableView.mj_footer endRefreshing];
        }];
        MJRefreshBackNormalFooter *footer = (MJRefreshBackNormalFooter *)_coupleTableView.mj_footer;
        footer.stateLabel.textColor = [UIColor colorWithR:128 G:128 B:128 A:1];
        footer.stateLabel.font = [UIFont systemFontOfSize:12];
        [_coupleTableView registerNib:[UINib xmNibFromMainBundleWithName:@"CoupleViewCell"] forCellReuseIdentifier:@"CoupleViewCell"];
    }
    return _coupleTableView;
}


- (UIScrollView *)backScrollView{
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 49 - 64)];
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.pagingEnabled = YES;
        _backScrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
        _backScrollView.delegate = self;
    }
    return _backScrollView;
}

- (UIView *)filterView{
    if (!_filterView) {
        _filterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _backScrollView.height)];
        _filterView.backgroundColor =  [UIColor colorWithR:0 G:0 B:0 A:0.5];
        _filterChildView = [[UIView alloc] initWithFrame:CGRectMake(0, -200, ScreenWidth, 200)];
        [_filterView addSubview:_filterChildView];
        FilterView *ageFilterView = [FilterView createFilterView];
        ageFilterView.frame = CGRectMake(0, 0, ScreenWidth, 100);
        ageFilterView.topicLabel.text = @"年龄范围:";
        [ageFilterView initWithFormat:@"%lu岁-%lu岁" andWithFloor:16 andWithCeil:40];
        [_filterChildView addSubview:ageFilterView];
        
        FilterView *rangeFilterView = [FilterView createFilterView];
        rangeFilterView.frame = CGRectMake(0, 100, ScreenWidth, 100);
        rangeFilterView.topicLabel.text = @"距离范围:";
        rangeFilterView.viewChooseAgeLeft.hidden = YES;
        [rangeFilterView initWithFormat:@"%lukm-%lukm" andWithFloor:0 andWithCeil:100];
        [_filterChildView addSubview:rangeFilterView];
        _filterView.alpha = 0;
    }
    return _filterView;
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    NSInteger pageInt = floor(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (pageInt == 0) {
        [_changeButton setImage:[UIImage imageNamed:@"cp_nav_btn_half"] forState:UIControlStateNormal];
    }else if(pageInt == 1){
         [_changeButton setImage:[UIImage imageNamed:@"cp_nav_btn_public"] forState:UIControlStateNormal];
    }
}
#pragma mark UITableViewDelegate,UITableViewDataSourse
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView.tag == Couple) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CoupleViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"SquareViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
//    cell.layer.transform = CATransform3DMakeScale(0.97, 0.97, 1);
//    //x和y的最终值为1
//    [UIView animateWithDuration:0.5 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//        //cell.alpha=1;
//    }];

    return cell;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == Couple) {
        return 20;
    }else{
        return 15;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == Couple) {
        return 107;
    }else{
        return 127;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ControllerMyVoice *myVoice = [[ControllerMyVoice alloc] init];
    [self.navigationController pushViewController:myVoice animated:YES];
}



- (IBAction)choiceButtonClick:(id)sender {
    if (_filterView.alpha == 0) {
        [UIView animateWithDuration:.5 animations:^{
            _filterView.alpha = 1;
            _filterChildView.frame = CGRectMake(0, 0, ScreenWidth, 200);
        }];
    }else{
        [UIView animateWithDuration:.5 animations:^{
            _filterView.alpha = 0;
            _filterChildView.frame = CGRectMake(0, -200, ScreenWidth, 200);
        }];
    }
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
