//
//  ControllerIMChatMsg.m
//  IMeetU
//
//  Created by zhanghao on 16/6/29.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ControllerIMChatMsg.h"
#import "UIStoryboard+Plug.h"
#import "UserDefultAccount.h"

#import "ViewIMInputPanel.h"

@interface ControllerIMChatMsg ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldContext;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *msgs;

@property (nonatomic, strong) ViewIMInputPanel *viewIMInputPanel;
@end

@implementation ControllerIMChatMsg

+ (instancetype)controller{
    ControllerIMChatMsg *controller = [UIStoryboard xmControllerWithName:xmStoryboardNameMessage indentity:@"ControllerIMChatMsg"];
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.viewIMInputPanel];
    [self.viewIMInputPanel initFrame];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.msgs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellWithIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellWithIdentifier"];
    }
    cell.textLabel.text = self.msgs[indexPath.row];
    
    return cell;
}

- (IBAction)onTouchUpInsideBtnSend:(id)sender {
    
}

- (IBAction)onTouchUpInsideBtnBack:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)msgs{
    if (!_msgs) {
        _msgs = [NSMutableArray array];
    }
    return _msgs;
}

- (void)onNewMessage:(NSArray *)msgs{
    
}

- (ViewIMInputPanel *)viewIMInputPanel{
    if (!_viewIMInputPanel) {
        _viewIMInputPanel = [ViewIMInputPanel viewIMInputPanel];
    }
    return _viewIMInputPanel;
}

@end
