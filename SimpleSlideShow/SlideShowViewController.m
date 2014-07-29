//
//  SlideShowViewController.m
//  SimpleSlideShow
//
//  Created by Thomas on 7/28/14.
//
//

#import "SlideShowViewController.h"

@interface SlideShowViewController ()

@end

@implementation SlideShowViewController

- (id)init
{
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    
}
#pragma mark -
#pragma mark Collection View Delegate Methods


@end
