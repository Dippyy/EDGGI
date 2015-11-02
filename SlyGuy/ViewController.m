//
//  ViewController.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-12.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "ViewController.h"
#import "SGTitleScreenScene.h"
#import "SGGameplayScene.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Facebook Login Button
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    self.loginButton.center = self.view.center;
    [self.view addSubview:self.loginButton];
    
}

-(void) viewDidAppear:(BOOL)animated {
    
    if([FBSDKAccessToken currentAccessToken] == nil){
        NSLog(@"Not logged in...");
    } else {
        NSLog(@"Logged in...");
        
        if ([FBSDKAccessToken currentAccessToken]) {
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     
                     NSLog(@"feched name: %@", result[@"name"]);
                     NSLog(@"fetched userid: %@", result[@"id"]);
                     
                     PFQuery *query = [PFQuery queryWithClassName:@"Highscore"];
//                     PFQuery *query = [PFUser query];
                     [query whereKey:@"userId" equalTo: result[@"id"]];
                     NSLog(@"Number of things found is %ld", (long)[query getFirstObject]);

                     if([query getFirstObject] > 0) {
                         
                         NSLog(@"match found!");
                         
                         PFQuery *query = [PFQuery queryWithClassName:@"Highscore"];
                         [query whereKey:@"userId" equalTo: result[@"id"]];
                         [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                             if (!error) {
                                 NSLog(@"Successfully retrieved %d scores.", objects.count);
                                 for (PFObject *object in objects) {
                                     NSLog(@"%@", object[@"scoreValue"]);
                                     NSUserDefaults *scoreValue = [NSUserDefaults standardUserDefaults];
                                     [scoreValue setObject: object[@"scoreValue"] forKey:@"HighscoreSaved"];
                                     [scoreValue setObject:object[@"userId"] forKey:@"userID"];
                                     [scoreValue synchronize];
                                 }
                             } else {
                                 // Log details of the failure
                                 NSLog(@"Error: %@ %@", error, [error userInfo]);
                             }
                         }];
                         
                     } else {
                         

                        PFObject *newUser = [PFObject objectWithClassName:@"Highscore"];
                         newUser[@"Name"] = result[@"name"];
                         newUser[@"userId"] = result[@"id"];
                         newUser[@"scoreValue"] = @(0);
                         NSUserDefaults *initialScore = [NSUserDefaults standardUserDefaults];
                         [initialScore setObject:@(0) forKey:@"HighScoreSaved"];
                         [initialScore synchronize];
                         
                         [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                             if (succeeded) {
                                 NSLog(@"Object has been saved");
                             } else {
                                 NSLog(@"Object was not saved");
                             }
                         }];
                     }
                 }
             }];
        }
        self.loginButton.hidden = TRUE;
        self.playButtonProperties.hidden = true;
        [self prepareScene];
    }
    
}

-(void)prepareScene{
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SGTitleScreenScene *scene = [SGTitleScreenScene sceneWithSize:skView.bounds.size];
    scene.name = @"titleScreen";
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [skView presentScene:scene];
}

- (IBAction)playForFunTapped:(UIButton *)sender {
    
    self.playButtonProperties.hidden = TRUE;
    self.loginButton.hidden = TRUE;
    
    [self prepareScene];
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    
    
}

@end
