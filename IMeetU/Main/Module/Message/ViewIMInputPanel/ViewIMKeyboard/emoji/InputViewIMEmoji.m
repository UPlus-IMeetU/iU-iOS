//
//  InputViewIMEmoji.m
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "InputViewIMEmoji.h"

#import "UINib+Plug.h"
#import "UIScreen+Plug.h"

#import "CellCollectionEmojiEmoji.h"
#import "CellCollectionEmojiStore.h"
#import "CellCollectionEmojiMarket.h"
#import "CellCollectionEmojiSwitch.h"

#import "ModelIMEmojis.h"
#import "ModelEmojiStores.h"
#import "ModelIMEmojiMarkets.h"


#define ReuseIdentifierEmojiEmoji @"CellCollectionEmojiEmoji"
#define ReuseIdentifierEmojiStore @"CellCollectionEmojiStore"
#define ReuseIdentifierEmojiMarket @"CellCollectionEmojiMarket"
#define ReuseIdentifierSwitch @"CellCollectionEmojiSwitch"

@interface InputViewIMEmoji()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionEmoji;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionSwitch;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIButton *btnSetting;
@property (weak, nonatomic) IBOutlet UIButton *btnSending;

@property (nonatomic, assign) CGFloat heightView;
@property (nonatomic, assign) CGFloat heightEmojiView;
@property (nonatomic, assign) CGFloat heightPageControl;
@property (nonatomic, assign) CGFloat heightSwitchView;
@property (nonatomic, assign) CGFloat collectionMarginToTopBottom;

@property (nonatomic, assign) NSInteger countOfPage;
@property (nonatomic, assign) NSInteger countOfEmojiEveryPage;

//每页有多少列表情
@property (nonatomic, assign) int countOfEmojiVertical;
//每页有多少行表情
@property (nonatomic, assign) int countOfEmojiHorizontally;

@property (nonatomic, assign) NSInteger collectionSwitchNowSelectedIndex;

@property (nonatomic, strong) ModelIMEmojis *modelIMEmojis;
@property (nonatomic, strong) ModelEmojiStores *modelEmojiStores;
@property (nonatomic, strong) ModelIMEmojiMarkets *modelIMEmojiMarkets;
@end
@implementation InputViewIMEmoji

+ (instancetype)inputViewWithHeight:(CGFloat)height{
    InputViewIMEmoji *view = [InputViewIM viewWithNibName:@"InputViewIMEmoji" viewClass:[InputViewIMEmoji class]];
    view.heightView = height;
    
    return view;
}

- (void)awakeFromNib{
    
    [self.collectionEmoji registerNib:[UINib xmNibFromMainBundleWithName:@"CellCollectionEmojiEmoji"] forCellWithReuseIdentifier:ReuseIdentifierEmojiEmoji];
    [self.collectionEmoji registerNib:[UINib xmNibFromMainBundleWithName:@"CellCollectionEmojiStore"] forCellWithReuseIdentifier:ReuseIdentifierEmojiStore];
    [self.collectionEmoji registerNib:[UINib xmNibFromMainBundleWithName:@"CellCollectionEmojiMarket"] forCellWithReuseIdentifier:ReuseIdentifierEmojiMarket];
    UICollectionViewFlowLayout *flowLayoutEmoji = [[UICollectionViewFlowLayout alloc] init];
    flowLayoutEmoji.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionEmoji.collectionViewLayout = flowLayoutEmoji;
    self.collectionEmoji.pagingEnabled = YES;
    self.collectionEmoji.delegate = self;
    self.collectionEmoji.dataSource = self;
    self.collectionEmoji.backgroundColor = [UIColor clearColor];
    
    [self.collectionSwitch registerNib:[UINib xmNibFromMainBundleWithName:@"CellCollectionEmojiSwitch"] forCellWithReuseIdentifier:ReuseIdentifierSwitch];
    
    UICollectionViewFlowLayout *flowLayoutSwitch = [[UICollectionViewFlowLayout alloc] init];
    flowLayoutSwitch.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionSwitch.collectionViewLayout = flowLayoutSwitch;
    self.collectionSwitch.delegate = self;
    self.collectionSwitch.dataSource = self;
    self.collectionSwitch.backgroundColor = [UIColor clearColor];
    [self.collectionSwitch selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    
    self.pageControl.numberOfPages = self.countOfPage;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.collectionEmoji) {
        return self.countOfPage*self.countOfEmojiEveryPage;
    }else if (collectionView == self.collectionSwitch){
        return [self.modelIMEmojiMarkets numberOfEmojiSwitch];
    }
    
    return 0;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    if (collectionView == self.collectionEmoji) {
        if (self.collectionSwitchNowSelectedIndex == 0) {
            CellCollectionEmojiEmoji *cellIMG = [self.collectionEmoji dequeueReusableCellWithReuseIdentifier:ReuseIdentifierEmojiEmoji forIndexPath:indexPath];
            if ((indexPath.row+1)%self.countOfEmojiEveryPage == 0){
                [cellIMG setImg:[UIImage imageNamed:@"input_view_panel_emoji_keyboard_del"]];
            }else{
                NSInteger row = indexPath.row - indexPath.row/self.countOfEmojiEveryPage;
                [cellIMG setImg:[self.modelIMEmojis emojiImgPNGWithIndex:row]];
            }
            cell = cellIMG;
        }else if (self.collectionSwitchNowSelectedIndex == 1){
            CellCollectionEmojiStore *cellStore = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifierEmojiStore forIndexPath:indexPath];
            if (indexPath.row == 0) {
                [cellStore setManager];
            }else{
                [cellStore setModel:[self.modelEmojiStores emojiModelForItemAtIndex:indexPath.row-1]];
            }
            cell = cellStore;
        }else{
            
        }
    }else if (collectionView == self.collectionSwitch){
        CellCollectionEmojiSwitch *cellIMG = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifierSwitch forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cellIMG setImg:[UIImage imageNamed:@"input_view_panel_emoji_switch_btn_face"]];
        }else if (indexPath.row == 1){
            [cellIMG setImg:[UIImage imageNamed:@"input_view_panel_emoji_switch_btn_heart"]];
        }else{
            [cellIMG setImgUrl:[self.modelIMEmojiMarkets btnImgUrlForItemAtIndexPath:indexPath]];
        }
        cell = cellIMG;
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x/[UIScreen screenWidth]+0.5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionEmoji) {
        if (collectionView == self.collectionEmoji){
            if (self.collectionSwitchNowSelectedIndex == 0) {
                if ((indexPath.row+1)%self.countOfEmojiEveryPage == 0) {
                    //选中的为删除键
                    if (self.delegateInputView){
                        if ([self.delegateInputView respondsToSelector:@selector(inputViewIMEmojiDeleteEmoji:)]) {
                            [self.delegateInputView inputViewIMEmojiDeleteEmoji:self];
                        }
                    }
                }else{
                    //选中的为表情见
                    NSString *emoji = [self.modelIMEmojis emojiStrWithIndex:indexPath.row];
                    if (self.delegateInputView){
                        if ([self.delegateInputView respondsToSelector:@selector(inputViewIMEmoji:emojiStr:)]) {
                            [self.delegateInputView inputViewIMEmoji:self emojiStr:emoji];
                        }
                    }
                }
            }else if (self.collectionSwitchNowSelectedIndex == 1){
            
            }else{
            
            }
        }
    }else if (collectionView == self.collectionSwitch){
        self.collectionSwitchNowSelectedIndex = indexPath.row;
        self.pageControl.numberOfPages = self.countOfPage;
        [self.collectionEmoji reloadData];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView == self.collectionEmoji) {
        if (self.collectionSwitchNowSelectedIndex == 0) {
            return UIEdgeInsetsMake(self.collectionMarginToTopBottom, 0, self.collectionMarginToTopBottom, 0);
        }else if (self.collectionSwitchNowSelectedIndex == 1){
            return UIEdgeInsetsMake(self.collectionMarginToTopBottom, 0, self.collectionMarginToTopBottom, 0);
        }
    }
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionEmoji) {
        return CGSizeMake(([UIScreen screenWidth])/self.countOfEmojiVertical, (self.heightEmojiView-self.collectionMarginToTopBottom*2)/self.countOfEmojiHorizontally-1);
    }else if (collectionView == self.collectionSwitch){
        return CGSizeMake(40, 35);
    }
    
    return CGSizeZero;
}

- (IBAction)onTouchUpInsideBtnSetting:(id)sender {
}

- (IBAction)onTouchUpInsideBtnSending:(id)sender {
    if (self.delegateInputView){
        if ([self.delegateInputView respondsToSelector:@selector(inputViewIMEmojiSendEmoji:)]) {
            [self.delegateInputView inputViewIMEmojiSendEmoji:self];
        }
    }
}

- (ModelIMEmojis *)modelIMEmojis{
    if (!_modelIMEmojis) {
        _modelIMEmojis = [ModelIMEmojis shareInstance];
    }
    return _modelIMEmojis;
}

- (ModelEmojiStores *)modelEmojiStores{
    if (!_modelEmojiStores) {
        _modelEmojiStores = [ModelEmojiStores getInstance];
    }
    return _modelEmojiStores;
}

- (ModelIMEmojiMarkets *)modelIMEmojiMarkets{
    if (!_modelIMEmojiMarkets) {
        _modelIMEmojiMarkets = [ModelIMEmojiMarkets getInstance];
    }
    return _modelIMEmojiMarkets;
}

- (CGFloat)heightEmojiView{
    return self.heightView - self.heightSwitchView - self.heightPageControl;
}

- (CGFloat)heightPageControl{
    return 20;
}

- (CGFloat)heightSwitchView{
    return 35;
}

- (CGFloat)collectionMarginToTopBottom{
    if (self.collectionSwitchNowSelectedIndex == 0) {
        return 15;
    }
    return 8;
}

- (int)countOfEmojiVertical{
    int count = 0;
    if ([UIScreen is55Screen]) {
        if (self.collectionSwitchNowSelectedIndex == 0) {
            return 9;
        }else{
            return 5;
        }
    }else if ([UIScreen is47Screen]){
        if (self.collectionSwitchNowSelectedIndex == 0) {
            return 8;
        }else{
            return 4;
        }
    }else{
        if (self.collectionSwitchNowSelectedIndex == 0) {
            return 7;
        }else{
            return 4;
        }
    }
    return count;
}

- (int)countOfEmojiHorizontally{
    if (self.collectionSwitchNowSelectedIndex == 0) {
        return 3;
    }
    return 2;
}

- (NSInteger)countOfEmojiEveryPage{
    return self.countOfEmojiVertical*self.countOfEmojiHorizontally;
}

- (NSInteger)countOfPage{
    NSInteger count = 0;
    if (self.collectionSwitchNowSelectedIndex == 0) {
        count = [self.modelIMEmojis numberOfEmoji]/(self.countOfEmojiEveryPage-1);
        if (count*(self.countOfEmojiEveryPage-1) < [self.modelIMEmojis numberOfEmoji]) {
            count ++;
        }
    }else if (self.collectionSwitchNowSelectedIndex == 1) {
        count = ([self.modelEmojiStores numberOfEmoji]+1)/self.countOfEmojiEveryPage;
        if (count*self.countOfEmojiEveryPage < [self.modelEmojiStores numberOfEmoji]+1) {
            count ++;
        }
    }
    return count;
}

@end
