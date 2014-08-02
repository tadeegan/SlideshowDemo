//
//  SlideShowViewController.m
//  SimpleSlideShow
//
//  Created by Thomas on 7/28/14.
//
//

#import "SlideShowViewController.h"
#import "SlideShowCollectionViewLayout.h"

static NSString *cellIdentifier = @"kCellidentifier";

@interface SlideShowViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) BOOL isScrolling;

@end

@implementation SlideShowViewController

#pragma mark -
#pragma mark View Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isScrolling = NO;
    self.currentPage = 0;
    self.collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:({
            SlideShowCollectionViewLayout *layout = [[SlideShowCollectionViewLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing = 0.0;
            layout.minimumInteritemSpacing = 0.0;
            layout;
        })];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        collectionView.pagingEnabled = YES;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView;
    });
    [self.view addSubview:self.collectionView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.collectionView.collectionViewLayout invalidateLayout];
    self.collectionView.contentOffset = CGPointMake(self.currentPage * self.view.bounds.size.width, 0);
    
}

- (BOOL)shouldAutorotate
{
    return !self.isScrolling;
}

#pragma mark -
#pragma mark Collection View Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor redColor] : [UIColor greenColor];
    UIView * square = ({
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        view.backgroundColor = [UIColor whiteColor];
        view.center = CGPointMake(cell.bounds.size.width / 2, cell.bounds.size.height / 2);
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        view;
    });
    [cell addSubview:square];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

#pragma mark -
#pragma mark UIScrollView delegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isScrolling = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.isScrolling = NO;
    [UIViewController attemptRotationToDeviceOrientation];
    self.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    [((SlideShowCollectionViewLayout *)self.collectionView.collectionViewLayout) setCurrentPageIndex:self.currentPage];
}

@end
