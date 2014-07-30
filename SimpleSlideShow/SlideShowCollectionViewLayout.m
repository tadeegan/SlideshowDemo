//
//  SlideShowCollectionViewLayout.m
//  SimpleSlideShow
//
//  Created by Thomas on 7/29/14.
//
//

#import "SlideShowCollectionViewLayout.h"

@interface SlideShowCollectionViewLayout ()

@property (nonatomic) NSInteger rotatingPage;

@end

@implementation SlideShowCollectionViewLayout

- (id)init
{
    self = [super init];
    if(self) {
        self.rotatingPage = -1;
    }
    return self;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareForAnimatedBoundsChange:(CGRect)oldBounds
{
    self.rotatingPage = self.currentPageIndex;
    [self invalidateLayout];
}

- (void)finalizeAnimatedBoundsChange
{
    self.rotatingPage = -1;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    if (itemIndexPath.row == self.currentPageIndex) {
        attributes.alpha = 1.0;
    }else{
        attributes.alpha = 0.0;
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    if (itemIndexPath.row == self.currentPageIndex) {
        attributes.alpha = 1.0;
    }else{
        attributes.alpha = 0.0;
    }
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    if (self.rotatingPage != -1) {
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes* obj, NSUInteger idx, BOOL *stop) {
            if (self.rotatingPage == obj.indexPath.row){
                obj.alpha = 1.0;
            }
            else {
                obj.alpha = 0.0;
            }
        }];
    }
    return array;
}

@end
