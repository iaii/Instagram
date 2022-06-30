//
//  DetailsViewController.m
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/28/22.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.author.text = self.post[@"author"][@"username"];
    self.caption.text = self.post[@"caption"];
    //cell.likeCount.text = [NSString stringWithFormat:@"%d", post[@"likeCount"]];
    //cell.commentCount.text = [NSString stringWithFormat:@"%d", post[@"commentCount"]];

    self.image.file = self.post[@"image"];
    NSDate *date = self.post.createdAt;
        
    self.time.text = [NSString stringWithFormat:@"%@", date.shortTimeAgoSinceNow];
    [self.image loadInBackground];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
