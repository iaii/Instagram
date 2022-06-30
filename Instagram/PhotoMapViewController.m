//
//  PhotoMapViewController.m
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/27/22.
//

#import "PhotoMapViewController.h"
#import "Post.h"

@interface PhotoMapViewController()
- (IBAction)didTapChoosePicFromLib:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *chosenImage;
@property (weak, nonatomic) IBOutlet UITextView *caption;
- (IBAction)didTapPost:(id)sender;
- (IBAction)didTapCancel:(id)sender;
- (IBAction)didTapCamera:(id)sender;


@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)

    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.chosenImage.image = editedImage;
}

- (IBAction)didTapChoosePicFromLib:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)didTapCamera:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)didTapCancel:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNav"];
}

- (IBAction)didTapPost:(id)sender {
    if(self.chosenImage.image && ![self.caption.text isEqualToString:@""]){
        CGSize newSize = CGSizeMake(500, 500);
        UIImage *resizedImage = [self resizeImage:self.chosenImage.image withSize:newSize];
        [Post postUserImage:resizedImage withCaption:self.caption.text withCompletion: ^(BOOL succeeded, NSError * _Nullable error){
            if(error){
                NSLog(@"%@", error);
            }else{
                NSLog(@"#Posted!");
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNav"];
            }
        }];
    }
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    <#code#>
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    <#code#>
//}

@end
