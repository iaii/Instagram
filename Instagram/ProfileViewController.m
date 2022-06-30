//
//  ProfileViewController.m
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/29/22.
//

#import "ProfileViewController.h"
#import "PostCollectionViewCell.h"
#import "Post.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *posts;

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self getPosts];
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (self.collectionView.frame.size.width/3.0)-10;
    CGFloat height = 200.0;
    return CGSizeMake(width, height);

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}
//
//- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
                      
   [query includeKey:@"author"];
   query.limit = 20;
   [query orderByDescending:@"createdAt"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
   [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
       NSError * _Nullable error) {
       if (objects) {
           self.posts = objects;
           [self.collectionView reloadData];
       } else {
           NSLog(@"%@", error);
       }
   }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pfpPostCellView" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.profilePic.file = post[@"image"];
    [cell.profilePic loadInBackground];
    return cell;
}

#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UICollectionViewCell *tappedCell = sender;
//    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
//    NSDictionary *movie = self.results[indexPath.item];
//    DetailViewController *detailsViewController = [segue destinationViewController];
//    detailsViewController.movie = movie;
//}



@end
