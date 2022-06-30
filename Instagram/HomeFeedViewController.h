//
//  HomeFeedViewController.h
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
- (IBAction)didTapLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSArray *posts;
- (IBAction)didTapCancel:(id)sender;
@property (strong, nonatomic) IBOutlet UIRefreshControl *refreshControl;


@end

NS_ASSUME_NONNULL_END
