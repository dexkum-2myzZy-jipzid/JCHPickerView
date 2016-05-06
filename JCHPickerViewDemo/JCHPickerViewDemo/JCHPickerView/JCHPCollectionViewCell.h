//
//  JCHPCollectionViewCell.h
//  PickerViewDemo
//
//  Created by ChanLiang on 5/6/16.
//  Copyright © 2016 JackChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCHPCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIFont *highlightedFont;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *hightlightedTextColor;

@end
