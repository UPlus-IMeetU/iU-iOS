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

@interface ControllerIMChatMsg ()<UITableViewDelegate, UITableViewDataSource, ViewIMInputPanelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *msgs;

@property (weak, nonatomic) IBOutlet ViewIMInputPanel *viewIMInputPanel;

@property (weak, nonatomic) IBOutlet UIButton *btnVoice;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UIButton *btnPhotos;
@property (weak, nonatomic) IBOutlet UIButton *btnEmoji;

@property (weak, nonatomic) IBOutlet UIView *viewKeyboardWrap;
@property (nonatomic, weak) IBOutlet UIView *textViewContentWrap;
@property (weak, nonatomic) IBOutlet YYTextView *yyTextViewContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constarintViewIMInputPanelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constarintViewIMInputPanelMarginBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewKeyboardWidth;

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
    
    self.viewIMInputPanel.superController = self;
    self.viewIMInputPanel.delegateInputPanel = self;
    
    self.viewIMInputPanel.btnVoice = self.btnVoice;
    self.viewIMInputPanel.btnEmoji = self.btnEmoji;
    self.viewIMInputPanel.btnCamera = self.btnCamera;
    self.viewIMInputPanel.btnPhotos = self.btnPhotos;
    self.viewIMInputPanel.yyTextViewContent = self.yyTextViewContent;
    self.viewIMInputPanel.viewKeyboardWrap = self.viewKeyboardWrap;
    self.viewIMInputPanel.textViewContentWrap = self.textViewContentWrap;
    
    self.constarintViewIMInputPanelMarginBottom.constant = -220;
    self.viewIMInputPanel.constraintViewInputViewHeight = self.constarintViewIMInputPanelHeight;
    self.viewIMInputPanel.constarintViewIMInputPanelMarginBottom = self.constarintViewIMInputPanelMarginBottom;
    
    self.constraintViewKeyboardWidth.constant = [UIScreen mainScreen].bounds.size.width;
    [self.viewIMInputPanel initial];
}

- (void)viewDidAppear:(BOOL)animated{
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.viewIMInputPanel closeKeyboard];
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


- (void)viewIMInputPanel:(ViewIMInputPanel *)view sendTxt:(NSString *)txt{
    NSLog(@"====================%@", txt);
}
@end
