//
//  ProfileViewController.h
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet PFImageView *pfpPic;

@end

NS_ASSUME_NONNULL_END
