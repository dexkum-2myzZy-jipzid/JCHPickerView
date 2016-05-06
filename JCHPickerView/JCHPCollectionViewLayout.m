//
//  JCHPCollectionViewLayout.m
//  PickerViewDemo
//
//  Created by ChanLiang on 5/6/16.
//  Copyright © 2016 JackChan. All rights reserved.
//

#import "JCHPCollectionViewLayout.h"

@interface JCHPCollectionViewLayout (){
    CGFloat halfWidth;
    CGFloat midX;
}

@end

@implementation JCHPCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0.0;
    }
    return self;
}

- (void)prepareLayout{
    CGRect rect = (CGRect){self.collectionView.contentOffset,self.collectionView.bounds.size};
    halfWidth   = CGRectGetWidth(rect)/2;
    midX        = CGRectGetMidX(rect);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    switch (_pickerViewStyle) {
        case JCHPickerViewSimple:
            return [super layoutAttributesForElementsInRect:rect];
            break;
        case JCHPickerViewRoll:{
            NSMutableArray *attributesArray = [[NSMutableArray alloc]init];
            for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
                if (CGRectIntersectsRect(rect, attributes.frame)) {
                    [attributesArray addObject:attributes];
                }
            }
            return attributesArray;
        }
            break;
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [[super layoutAttributesForItemAtIndexPath:indexPath]copy];
    switch (_pickerViewStyle) {
        case JCHPickerViewSimple:{
            return attributes;
        }
            break;
        case JCHPickerViewRoll:{
            CGFloat tx = CGRectGetMidX(attributes.frame) - midX;
            CGFloat angle = tx/halfWidth;
            CATransform3D transform3D = CATransform3DIdentity;
            transform3D = CATransform3DTranslate(transform3D, -tx, 0, -halfWidth);
            transform3D = CATransform3DRotate(transform3D, angle, 0, 1, 0);
            transform3D = CATransform3DTranslate(transform3D, 0, 0, halfWidth);
            attributes.transform3D = transform3D;
            attributes.alpha = (ABS(angle) < M_PI_2);
            return attributes;
        }
            break;
    }
}

@end

