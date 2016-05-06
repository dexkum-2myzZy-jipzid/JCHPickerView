//
//  JCHPickerView.m
//  PickerViewDemo
//
//  Created by ChanLiang on 5/6/16.
//  Copyright © 2016 JackChan. All rights reserved.
//

#import "JCHPickerView.h"
#import "JCHPCollectionViewCell.h"
#import "JCHPCollectionViewLayout.h"

@interface JCHPickerView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) JCHPCollectionViewLayout *layout;

@end

@implementation JCHPickerView

@synthesize font,highlightedFont,textColor,hightlightedTextColor,delegate,dataSource,interitemSpacing;

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionView];
    }
    return self;
}

- (void)setupCollectionView{
    self.layout                                        = [[JCHPCollectionViewLayout alloc]init];
    _layout.pickerViewStyle                            = JCHPickerViewRoll;
    self.collectionView                                = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
    self.collectionView.dataSource                     = self;
    self.collectionView.delegate                       = self;
    [self.collectionView registerClass:[JCHPCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JCHPCollectionViewCell class])];
    self.collectionView.backgroundColor                = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    //setup default value
    self.font                  = self.font? :[UIFont systemFontOfSize:17];
    self.highlightedFont       = self.highlightedFont? :[UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.textColor             = self.textColor? :[UIColor lightGrayColor];
    self.hightlightedTextColor = self.hightlightedTextColor?:[UIColor blackColor];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource numberOfItemsInPickerView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JCHPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JCHPCollectionViewCell class]) forIndexPath:indexPath];
    NSString *title             = [self.dataSource pickerView:self titileForItemIndex:indexPath.row];
    
    //cell.label
    cell.label.text                 = title;
    cell.label.textColor            = self.textColor;
    cell.label.highlightedTextColor = self.hightlightedTextColor;
    cell.label.font                 = self.font;
    cell.label.bounds               = (CGRect){CGPointZero,[self sizeOfString:title]};
    
    //cell
    cell.textColor                  = self.textColor;
    cell.hightlightedTextColor      = self.hightlightedTextColor;
    cell.font                       = self.font;
    cell.highlightedFont            = self.highlightedFont;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self selectItemAndScrollToItemAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectItem:)]) {
        [self.delegate pickerView:self didSelectItem:indexPath.row];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = [self.dataSource pickerView:self titileForItemIndex:indexPath.row];
    CGSize stringSize = [self sizeOfString:string];
    return CGSizeMake(stringSize.width + self.interitemSpacing, self.collectionView.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    NSInteger itemNums   = [self.collectionView numberOfItemsInSection:section];
    CGSize firstItemSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    CGSize lastItemSize  = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:itemNums - 1 inSection:section]];
    CGFloat leftInset    = (collectionView.bounds.size.width - firstItemSize.width)/2;
    CGFloat rightInset   = (collectionView.bounds.size.width - lastItemSize.width)/2;
    return UIEdgeInsetsMake(0, leftInset, 0, rightInset);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self didEndScrollingToItem];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self didEndScrollingToItem];
}


#pragma mark -

- (void)reloadData{
    [self.collectionView reloadData];
    [self selectItemAndScrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

//string size
- (CGSize)sizeOfString:(NSString*)string{
    CGSize stringSize = [string sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGSize highlightedStringSize = [string sizeWithAttributes:@{NSFontAttributeName:self.highlightedFont}];
    return CGSizeMake(MAX(stringSize.width, highlightedStringSize.width)+2, MAX(stringSize.height, highlightedStringSize.height)+2);
}

- (void)selectItemAndScrollToItemAtIndexPath:(NSIndexPath*)indexPath{
    switch (_layout.pickerViewStyle) {
        case JCHPickerViewSimple:
            [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        case JCHPickerViewRoll:{
            [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            CGPoint offsetPoint = CGPointMake([self itemOffset:indexPath.row], self.collectionView.contentOffset.y);
            [self.collectionView setContentOffset:offsetPoint animated:YES];
        }
            break;
    }
}

//calculate item offset
- (CGFloat)itemOffset:(NSInteger)item{
    
    CGFloat offset = 0.0;
    for (NSInteger i = 0; i <item; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGSize itemSize = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout sizeForItemAtIndexPath:indexPath];
        offset += itemSize.width;
    }
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    offset -= [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout sizeForItemAtIndexPath:firstIndexPath].width/2;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:item inSection:0];
    offset += [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout sizeForItemAtIndexPath:lastIndexPath].width/2;
    
    return offset;
}

- (void)didEndScrollingToItem{
    switch (_layout.pickerViewStyle) {
        case JCHPickerViewSimple:{
            CGPoint center = [self convertPoint:self.collectionView.center toView:self.collectionView];
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:center];
            [self selectItemAndScrollToItemAtIndexPath:indexPath];
            if ([self.delegate respondsToSelector:@selector(pickerView:didSelectItem:)]) {
                [self.delegate pickerView:self didSelectItem:indexPath.row];
            }
        }
            break;
            
        case JCHPickerViewRoll:{
            for (NSUInteger i = 0; i < [self collectionView:self.collectionView numberOfItemsInSection:0]; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                CGSize itemSize = [self collectionView:self.collectionView layout:_layout sizeForItemAtIndexPath:indexPath];
                if ([self itemOffset:i] + itemSize.width / 2 > self.collectionView.contentOffset.x) {
                    [self selectItemAndScrollToItemAtIndexPath:indexPath];
                    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectItem:)]) {
                        [self.delegate pickerView:self didSelectItem:indexPath.row];
                    }
                    break;
                }
            }
        }
            break;
    }
    
}

@end

