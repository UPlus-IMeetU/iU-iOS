//
//  FilterView.m
//  IMeetU
//
//  Created by Spring on 16/7/12.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScreen+Plug.h"
#import <YYKit/YYKit.h>
#import "FilterView.h"
@interface FilterView()
@property (nonatomic, assign) CGFloat chooseAgeMarginLeft;
@property (nonatomic, assign) CGFloat chooseAgeMarginRight;
@property (nonatomic, assign) CGFloat chooseAgeRange;

@property (nonatomic, assign) NSInteger ageFloorSelected;
@property (nonatomic, assign) NSInteger ageCeilingSelected;

@property (weak, nonatomic) IBOutlet UILabel *labelAgeRange;
@property (weak, nonatomic) IBOutlet UIView *viewChooseAgeRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintChooseAgeRangeLength;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintChooseAgeRangeMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintChooseAgeMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintChooseAgeMarginRight;
@property (nonatomic,copy) NSString *formatStr;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,assign) NSInteger min;

@end
@implementation FilterView
+(instancetype)createFilterView{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FilterView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
};


- (void)awakeFromNib {
    _min = 16;
    _max = 40;
    [self initChooseAgeRange];

}

- (void)setModelFilter:(ModelFilter *)modelFilter{
    _modelFilter = modelFilter;
    _ageFloorSelected = modelFilter.selectFloor;
    _ageCeilingSelected = modelFilter.selectCeil;
    [self initChooseAgeRange];
}

- (void)initWithFormat:(NSString *)formatStr andWithFloor:(NSInteger)floor andWithCeil:(NSInteger)ceil{
    _formatStr = formatStr;
    _max = ceil;
    _min = floor;
    [self initChooseAgeRange];
}

- (void)initChooseAgeRange{
    if (!_formatStr) {
        _formatStr = @"%lu岁-%lu岁";
    }
    float slidingRange = [UIScreen screenWidth] - 20*2;
    NSLog(@"ceil = %lu floor = %lu",self.ageCeiling,self.ageFloor);
    float step = slidingRange/(self.ageCeiling-self.ageFloor);
    NSLog(@"step = %f",step);
    NSLog(@"slidingRange = %lu",slidingRange);
    self.constraintChooseAgeMarginLeft.constant = step*(self.ageFloorSelected-self.ageFloor)+20-25;
    self.constraintChooseAgeMarginRight.constant = step*(self.ageCeilingSelected-self.ageFloor)+20-25;
    self.constraintChooseAgeRangeMarginLeft.constant = self.constraintChooseAgeMarginLeft.constant+25;
    self.constraintChooseAgeRangeLength.constant = self.constraintChooseAgeMarginRight.constant-self.constraintChooseAgeMarginLeft.constant;
    [self.labelAgeRange setText:[NSString stringWithFormat:_formatStr, self.ageFloorSelected, self.ageCeilingSelected]];
    
    self.viewChooseAgeLeft.userInteractionEnabled = YES;
    self.viewChooseAgeRight.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGestureRecognizerChooseAgeLeft = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        UIPanGestureRecognizer *gestureRecognizer = sender;
        if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            CGFloat margin = [gestureRecognizer locationInView:self].x-25;
            if (margin < self.constraintChooseAgeMarginRight.constant-step  &&  margin>20-25){
                self.constraintChooseAgeMarginLeft.constant = margin;
                self.constraintChooseAgeRangeMarginLeft.constant = self.constraintChooseAgeMarginLeft.constant+25;
                self.constraintChooseAgeRangeLength.constant = self.constraintChooseAgeMarginRight.constant-self.constraintChooseAgeMarginLeft.constant;
                self.ageFloorSelected = ((margin+25-20)/step+0.5)+self.ageFloor;
                [self.labelAgeRange setText:[NSString stringWithFormat:_formatStr, self.ageFloorSelected, self.ageCeilingSelected]];
                NSLog(@"min = %lu , max = %lu",self.ageFloorSelected,self.ageCeilingSelected);
            }
        }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
            NSLog(@"选择完毕");
        }
    }];
    [self.viewChooseAgeLeft addGestureRecognizer:panGestureRecognizerChooseAgeLeft];
    
    UIPanGestureRecognizer *panGestureRecognizerChooseAgeRight = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        UIPanGestureRecognizer *gestureRecognizer = sender;
        if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            CGFloat margin = [gestureRecognizer locationInView:self].x-25;
            if (margin > self.constraintChooseAgeMarginLeft.constant+step && margin<[UIScreen screenWidth]-20-25){
                self.constraintChooseAgeMarginRight.constant = margin;
                self.constraintChooseAgeRangeLength.constant = self.constraintChooseAgeMarginRight.constant-self.constraintChooseAgeMarginLeft.constant;
                self.ageCeilingSelected = ((margin+25-20)/step+0.5)+self.ageFloor;
                [self.labelAgeRange setText:[NSString stringWithFormat:_formatStr, self.ageFloorSelected, self.ageCeilingSelected]];
            }
        }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
            NSLog(@"选择完毕");
        }
    }];
    [self.viewChooseAgeRight addGestureRecognizer:panGestureRecognizerChooseAgeRight];
}

- (NSInteger)ageFloor{
    return 0 ;
}

- (NSInteger)ageCeiling{
    return _max ;
}

- (NSInteger)ageCeilingSelected{
    if (_ageCeilingSelected > self.ageCeiling) {
        _ageCeilingSelected = self.ageCeiling;
    }
    if (_ageCeilingSelected<=self.ageFloorSelected) {
        _ageCeilingSelected = self.ageFloorSelected;
    }
    return _ageCeilingSelected;
}

- (NSInteger)ageFloorSelected{
    if (_ageFloorSelected < self.ageFloor) {
        _ageFloorSelected = self.ageFloor;
    }
    return _ageFloorSelected;
}
@end
