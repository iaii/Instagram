//
//  LoginViewController.m
//  Instagram
//
//  Created by Apoorva Chilukuri on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextView *usernameField;
@property (weak, nonatomic) IBOutlet UITextView *passwordField;

- (IBAction)didTapSignUp:(id)sender;
- (IBAction)didTapLogin:(id)sender;



@end

@implementation LoginViewController

- (void)viewDidLoad {

    

}

- (IBAction)didTapLogin:(id)sender {
    if([self.usernameField.text isEqual:@""]){
        [self loginAlert];
    }else{
        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
    }
}

- (IBAction)didTapSignUp:(id)sender {
    if([self.usernameField.text isEqual:@""]){
        [self loginAlert];
    }else{
        // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameField.text;
        //newUser.email = self.emailField.text;
        newUser.password = self.passwordField.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabViewController"];
            }
        }];
    }
}

-(void)loginAlert{
    
    [super viewDidLoad];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                               message:@"Message"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];

    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
    
}

@end
