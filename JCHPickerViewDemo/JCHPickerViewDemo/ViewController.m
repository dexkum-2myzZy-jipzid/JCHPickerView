//
//  ViewController.m
//  JCHPickerViewDemo
//
//  Created by ChanLiang on 5/6/16.
//  Copyright © 2016 JackChan. All rights reserved.
//

#import "ViewController.h"
#import "JCHPickerView.h"

@interface ViewController ()<JCHPickerViewDelegate,JCHPickerViewDataSource>{
    NSArray *titleArray;
}
@property (nonatomic,strong) JCHPickerView *pickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    titleArray = @[@"MacBook",@"iMac",@"iPod",@"iPhone",@"MacBook Pro",@"MacBook Air"];
    self.pickerView                       = [[JCHPickerView alloc]initWithFrame:self.view.bounds];
    self.pickerView.dataSource            = self;
    self.pickerView.delegate              = self;
    self.pickerView.textColor             = [UIColor lightGrayColor];
    self.pickerView.hightlightedTextColor = [UIColor blackColor];
    self.pickerView.font                  = [UIFont systemFontOfSize:25];
    self.pickerView.highlightedFont       = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    self.pickerView.interitemSpacing      = 20;
    [self.view addSubview:self.pickerView];
    
    [self.pickerView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLPickerViewDataSource

- (NSUInteger)numberOfItemsInPickerView:(JCHPickerView *)pickerView{
    return titleArray.count;
}

- (NSString *)pickerView:(JCHPickerView *)pickerView titileForItemIndex:(NSUInteger)index{
    return titleArray[index];
}

#pragma mark - CLPickerViewDelegate

- (void)pickerView:(JCHPickerView *)pickerView didSelectItem:(NSUInteger)item{
    NSLog(@"%@",titleArray[item]);
}

@end
