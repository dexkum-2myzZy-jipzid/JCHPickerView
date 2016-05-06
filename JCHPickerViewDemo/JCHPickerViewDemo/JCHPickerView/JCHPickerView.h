//
//  JCHPickerView.h
//  PickerViewDemo
//
//  Created by ChanLiang on 5/6/16.
//  Copyright © 2016 JackChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCHPickerView;

@protocol JCHPickerViewDataSource <NSObject>
@required
- (NSUInteger)numberOfItemsInPickerView:(JCHPickerView*)pickerView;
- (NSString*)pickerView:(JCHPickerView*)pickerView titileForItemIndex:(NSUInteger)index;
@end

@protocol JCHPickerViewDelegate <NSObject>
- (void)pickerView:(JCHPickerView*)pickerView didSelectItem:(NSUInteger)item;
@end

@interface JCHPickerView : UIView

@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIFont *highlightedFont;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *hightlightedTextColor;
@property (nonatomic,assign) CGFloat interitemSpacing;
@property (nonatomic,assign) id<JCHPickerViewDataSource>dataSource;
@property (nonatomic,assign) id<JCHPickerViewDelegate>delegate;

- (void)reloadData;

@end

