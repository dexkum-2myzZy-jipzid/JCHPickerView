//
//  JCHPCollectionViewLayout.h
//  PickerViewDemo
//
//  Created by ChanLiang on 5/6/16.
//  Copyright © 2016 JackChan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JCHPickerViewSimple,
    JCHPickerViewRoll,
} JCHPickerViewStyle;

@interface JCHPCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) JCHPickerViewStyle pickerViewStyle;

@end

