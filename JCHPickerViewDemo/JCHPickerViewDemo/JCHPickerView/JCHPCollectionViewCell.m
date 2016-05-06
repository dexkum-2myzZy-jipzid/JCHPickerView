//
//  JCHPCollectionViewCell.m
//  PickerViewDemo
//
//  Created by ChanLiang on 5/6/16.
//  Copyright © 2016 JackChan. All rights reserved.
//

#import "JCHPCollectionViewCell.h"

@implementation JCHPCollectionViewCell

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupLabel];
    }
    return self;
}

- (void)setupLabel{
    self.layer.doubleSided          = NO;
    self.label                      = [[UILabel alloc]initWithFrame:self.contentView.bounds];
    self.label.backgroundColor      = [UIColor clearColor];
    self.label.textAlignment        = NSTextAlignmentCenter;
    self.label.textColor            = [UIColor lightGrayColor];
    self.label.highlightedTextColor = [UIColor blackColor];
    self.label.numberOfLines        = 1;
    self.label.autoresizingMask     = (UIViewAutoresizingFlexibleTopMargin |
                                       UIViewAutoresizingFlexibleLeftMargin |
                                       UIViewAutoresizingFlexibleBottomMargin |
                                       UIViewAutoresizingFlexibleRightMargin);
    [self.contentView addSubview:self.label];
}

#pragma mark -

- (void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    CATransition *transition = [CATransition animation];
    [transition setType:kCATransitionFade];
    [transition setDuration:0.5];
    [self.label.layer addAnimation:transition forKey:nil];
    
    self.label.font = self.selected? _highlightedFont : _font;
    self.label.textColor = self.selected? _hightlightedTextColor: _textColor;
}

@end

