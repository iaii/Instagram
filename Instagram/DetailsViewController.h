//
//  DetailsViewController.h
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"
#import "Post.h"
#import "DateTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet PFImageView *image;

@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
