//
//  ViewController.m
//  xxx
//
//  Created by dj.yue on 2017/11/13.
//  Copyright © 2017年 dj.yue. All rights reserved.
//

#import "ViewController.h"
#import "LYZoomCenterFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet LYZoomCenterFlowLayout *layout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.layout.itemSize = CGSizeMake(150, 200);
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.layout.sectionInset = UIEdgeInsetsMake(0, screenSize.width / 2 - 75, 0, screenSize.width / 2 - 75);
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 2.f;
    return cell;
}


@end
