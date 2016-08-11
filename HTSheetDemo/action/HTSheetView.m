//
//  HTSheetView.m
//  HTSheetDemo
//
//  Created by taotao on 8/10/16.
//  Copyright © 2016 taotao. All rights reserved.
//

#import "HTSheetView.h"

#define kScreenSize                 [UIScreen mainScreen].bounds.size
#define kSheetHeightPercent         0.3
#define kBtnHeight                  30
#define kBtnWidth                   50




@interface HTSheetView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,weak)UIView  *sheetPicker;
@property (nonatomic,weak)UIPickerView  *picker;
@property (nonatomic,strong)NSArray *items;
@property (nonatomic,copy) DoneBlock doneBlock;
@property (nonatomic,copy) CancelBlock cancelBlock;
@end



@implementation HTSheetView
- (instancetype) initWithTitle:(NSString*)title items:(NSArray*)items done:(DoneBlock)done cancel:(CancelBlock) cancel
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self != nil) {
        self.items = items;
        self.doneBlock = done;
        self.cancelBlock = cancel;
        [self setupUI];
    }
    return self;
}

- (void)show
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    CGFloat pickerY = kScreenSize.height * (1 - kSheetHeightPercent);
    CGRect pickerF = {{0,pickerY},self.sheetPicker.frame.size};
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
        self.sheetPicker.frame = pickerF;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)disappear
{
    CGFloat pickerY = kScreenSize.height;
    CGRect pickerF = {{0,pickerY},self.sheetPicker.frame.size};
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
        self.sheetPicker.frame = pickerF;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    NSString *title = self.items[row];
    label.text = title;
    return label;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.items count];
}

#pragma mark - setup ui
- (void)setupUI
{
    //coverview init
    self.alpha = 0.0;
    self.backgroundColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    [self addTarget:self action:@selector(tapCoverView) forControlEvents:UIControlEventTouchDown];
    
    //sheet view init
    UIView *sheet = [[UIView alloc] init];
    [self addSubview:sheet];
    self.sheetPicker = sheet;
    CGFloat y = kScreenSize.height;
    CGFloat sheetHeight = kScreenSize.height * kSheetHeightPercent;
    CGFloat sheetWidth = kScreenSize.width;
    CGRect sheetF = CGRectMake(0, y, sheetWidth, sheetHeight);
    sheet.frame = sheetF;
    
    //picker view init
    UIPickerView *picker = [[UIPickerView alloc] init];
    [picker setDelegate:self];
    [picker setDataSource:self];
    picker.backgroundColor = [UIColor whiteColor];
    [self.sheetPicker addSubview:picker];
    CGRect pickerF = CGRectMake(0, 0, sheetWidth, sheetHeight);
    picker.frame = pickerF;
    self.picker = picker;
    
    //confirm button
    UIButton *confirmBtn = [[UIButton alloc] init];
    [confirmBtn addTarget:self action:@selector(tapConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    CGFloat confirmX = sheetWidth - kBtnWidth;
    CGRect confirmF = CGRectMake(confirmX, 0, kBtnWidth, kBtnHeight);
    confirmBtn.frame = confirmF;
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sheetPicker addSubview:confirmBtn];
    
    //confirm button
    UIButton *cancelmBtn = [[UIButton alloc] init];
    [cancelmBtn addTarget:self action:@selector(tapCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    CGRect cancelF = CGRectMake(0, 0, kBtnWidth, kBtnHeight);
    cancelmBtn.frame = cancelF;
    [cancelmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelmBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.sheetPicker addSubview:cancelmBtn];
}

#pragma mark - selectors
- (void)tapConfirmBtn
{
    [self disappear];
    if (self.doneBlock != nil) {
        NSInteger selectedRow = [self.picker selectedRowInComponent:0];
        NSString *selecteItem = self.items[selectedRow];
        self.doneBlock(selecteItem);
    }
}

- (void)tapCancelBtn
{
    [self disappear];
    if (self.cancelBlock != nil) {
        self.cancelBlock();
    }
}

- (void)tapCoverView
{
    [self disappear];
}



@end
