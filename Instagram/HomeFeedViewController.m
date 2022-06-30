//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/27/22.
//

#import "HomeFeedViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "PostTableViewCell.h"
#import "Post.h"
#import "DetailsViewController.h"
#import "PostTableViewCell.h"
//#import "InfiniteScrollActivityView.h"

@interface HomeFeedViewController ()
//@property (assign, nonatomic) BOOL isMoreDataLoading;
//@property (strong, nonatomic) InfiniteScrollActivityView* loadingMoreView;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
 //   [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"postCell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HeaderViewIdentifier"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"FooterViewIdentifier"];

    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

    [self queryPosts];
//    // Set up Infinite Scroll loading indicator
//    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
//    self.loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
//    self.loadingMoreView.hidden = true;
//    [self.tableView addSubview:self.loadingMoreView];
//
//    UIEdgeInsets insets = self.tableView.contentInset;
//    insets.bottom += InfiniteScrollActivityView.defaultHeight;
//    self.tableView.contentInset = insets;
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    [self queryPosts];
}

- (void)onTimer {
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    //[self.refreshControl endRefreshing];
    
}

// infinite scrolling
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row + 1 == [self.posts count]){
//        [self loadMoreData:[self.posts count] + 20];
//        [self.tableView reloadData];
//    }
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if(!self.isMoreDataLoading){
////        self.isMoreDataLoading = true;
//        // Calculate the position of one screen length before the bottom of the results
//        int scrollViewContentHeight = self.tableView.contentSize.height;
//        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
//
//        // When the user has scrolled past the threshold, start requesting
//        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
//            self.isMoreDataLoading = true;
//
//            // Update position of loadingMoreView, and start loading indicator
//            CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
//            self.loadingMoreView.frame = frame;
//            [self.loadingMoreView startAnimating];
//
//            [self loadMoreData];
//        }
//    }
//}
//
//-(void)loadMoreData{
//
//    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
//
//   [query includeKey:@"author"];
////   query.limit = 20;
//   [query orderByDescending:@"createdAt"];
//   [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
//       NSError * _Nullable error) {
//       if (objects) {
//           self.posts = objects;
//           [self.tableView reloadData];
//
//       } else {
//           NSLog(@"%@", error);
//       }
//       [self.loadingMoreView stopAnimating];
//   }];
//
//}

-(void)queryPosts {
     PFQuery *query = [PFQuery queryWithClassName:@"Post"];
                       
    [query includeKey:@"author"];
    //query.limit = 20;
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
        NSError * _Nullable error) {
        if (objects) {
            self.posts = objects;
            [self.tableView reloadData];

        } else {
            NSLog(@"%@", error);
        }
        [self.refreshControl endRefreshing];

    }];
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];

//        SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//        myDelegate.window.rootViewController = loginViewController;
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    
    Post *post = self.posts[indexPath.section];
    
    cell.post = post;
    
    cell.author.text = post[@"author"][@"username"];
    cell.caption.text = post[@"caption"];
    cell.likeCount.text = [NSString stringWithFormat:@"%@", post[@"likeCount"]];
    cell.commentCount.text = [NSString stringWithFormat:@"%@", post[@"commentCount"]];

    cell.image.file = post[@"image"];
    [cell.image loadInBackground];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.posts.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderViewIdentifier"];
    Post *post = self.posts[section];
    
    header.textLabel.text = post[@"author"][@"username"];;
    header.textLabel.textColor = [UIColor blackColor];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FooterViewIdentifier"];
    Post *post = self.posts[section];
    
    NSDate *date = post.createdAt;
        
    footer.textLabel.text = [NSString stringWithFormat:@"%@", date.shortTimeAgoSinceNow];
//    footer.textLabel.textColor = [UIColor blackColor];
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (IBAction)didTapCancel:(id)sender {
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if(([[segue identifier] isEqualToString:@"destinationViewController"])){
    
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        UITableViewCell *cell = sender;
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:cell];
        //Pass the selected object to the new view controller.
        Post *postToPass = self.posts[myIndexPath.row];
        detailsViewController.post = postToPass;
//        NSLog(@"%@", detailsViewController.tweet);
    }
}



@end
