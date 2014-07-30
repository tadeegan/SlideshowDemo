//
//  SlideShowViewController.m
//  SimpleSlideShow
//
//  Created by Thomas on 7/28/14.
//
//

#import "SlideShowViewController.h"

static NSString *cellIdentifier = @"kCellidentifier";

@interface SlideShowViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UICollectionViewLayout *layout;

@property (nonatomic) NSInteger currentPage;

@end

@implementation SlideShowViewController

#pragma mark -
#pragma mark View Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentPage = 0;
    self.collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
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
    NSLog(@"%@",cell);
    [cell addSubview:square];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

@end
