//
//  LYZoomCenterFlowLayout.m
//  xxx
//
//  Created by dj.yue on 2017/11/13.
//  Copyright © 2017年 dj.yue. All rights reserved.
//

#import "LYZoomCenterFlowLayout.h"

static const CGFloat kMinCellScale = 0.6666667;

@implementation LYZoomCenterFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAtts =  [self deepCopyWithArray:[super layoutAttributesForElementsInRect:rect]];
    CGFloat collectionViewCenterX = self.collectionView.bounds.size.width * 0.5;
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    CGFloat centerToCenter = self.minimumInteritemSpacing + self.itemSize.width;///< cell center to center distance
    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        CGFloat centerX = layoutAtt.center.x;
        CGFloat gap = centerX - (collectionViewCenterX + contentOffsetX);///< gap between cell center to collectionview center
        CGFloat scale = kMinCellScale;
        if (fabs(gap) < centerToCenter) {
            scale = 1 - fabs(gap)/centerToCenter * (1 - kMinCellScale);
        }
        layoutAtt.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return layoutAtts;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    NSArray *layoutAtts = [super layoutAttributesForElementsInRect:rect];
    CGFloat minMargin = MAXFLOAT;
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
    CGFloat contentOffsetX = proposedContentOffset.x;
    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        CGFloat margin = layoutAtt.center.x - contentOffsetX - collectionViewCenterX;
        if (ABS(margin) < ABS(minMargin)) {
            minMargin = margin;
        }
    }
    proposedContentOffset.x += minMargin;
    return proposedContentOffset;
}

- (NSArray *)deepCopyWithArray:(NSArray *)arr {
    NSMutableArray *arrM = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attr in arr) {
        [arrM addObject:[attr copy]];
    }
    return arrM;
}

@end
