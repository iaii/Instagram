//
//  PostTableViewCell.h
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *author;

@property (strong, nonatomic) Post *post;


@end

NS_ASSUME_NONNULL_END
