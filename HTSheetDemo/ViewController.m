//
//  ViewController.m
//  HTSheetDemo
//
//  Created by taotao on 8/10/16.
//  Copyright © 2016 taotao. All rights reserved.
//

#import "ViewController.h"
#import "HTSheetView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)tapShowBtn:(id)sender {
    NSArray *items = @[@"80",@"90",@"90",@"90",@"90",@"90",@"90",@"90",@"90",@"90"];
    HTSheetView *sheetView = [[HTSheetView alloc] initWithTitle:@"Title" items:items done:^(NSString *str) {
        NSLog(@"selectedItems = %@",str);
    } cancel:^(){
        NSLog(@"cancel...");
    }];
    [sheetView show];
}

@end
