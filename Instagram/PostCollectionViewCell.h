//
//  PostCollectionViewCell.h
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/29/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;

@end

NS_ASSUME_NONNULL_END
