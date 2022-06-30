//
//  PostTableViewCell.m
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/28/22.
//

#import "PostTableViewCell.h"
//#import <PFImageView/ PFI;

@implementation PostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
}


@end
