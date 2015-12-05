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
    self.loginButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - self.loginButton.frame.size.height);

    [self.view addSubview:self.loginButton];
    
    self.goBackButton.hidden = TRUE;

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSUserDefaults *loginToken = [NSUserDefaults standardUserDefaults];
    NSString *tokenValue = [loginToken valueForKey:@"AccessToken"];
    
    if([tokenValue  isEqual: @"Scenario2"]){
        
        self.loginButton.hidden = FALSE;
        self.playButtonProperties.hidden = TRUE;
        self.backgroundImage.hidden = FALSE;
        self.goBackButton.hidden = FALSE;
        [loginToken setObject:@"Scenario1" forKey:@"AccessToken"];

    }
    if([tokenValue isEqual:@"Scenario1"]){
        
    }
}



-(void) viewDidAppear:(BOOL)animated {
    
    //Checks for a Facebook login token (determines if user has logged in before)
    
    if([FBSDKAccessToken currentAccessToken] == nil){
        NSLog(@"Not logged in...");
        
        //Facebook Indicator
        NSUserDefaults *fbCheck = [NSUserDefaults standardUserDefaults];
        [fbCheck setObject:@"NotLogged" forKey:@"fbToken"];
        
        //this code saves the score and the userID for reference (same as above)
        NSUserDefaults *initialScore = [NSUserDefaults standardUserDefaults];
        [initialScore setObject:@(0) forKey:@"HighScoreSaved"];
        
    } else {
        //If the user is logged in we want to grab their information (name and unique fb id)
        NSLog(@"Logged in...");
        
        //Facebook Indicator
        NSUserDefaults *fbCheck = [NSUserDefaults standardUserDefaults];
        [fbCheck setObject:@"LoggedIn" forKey:@"fbToken"];
        
        if ([FBSDKAccessToken currentAccessToken]) {
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     
                     //print the user information to the console (for testing)
//                     NSLog(@"feched name: %@", result[@"name"]);
//                     NSLog(@"fetched userid: %@", result[@"id"]);
                     NSString *myName = result[@"name"];
                     NSArray *firstName = [myName componentsSeparatedByString:@" "];
                     NSLog(@"fetched userid: %@", firstName[0]);
                     
                     //check to see if we have this user in our Parse db
                     PFQuery *query = [PFQuery queryWithClassName:@"Highscore"];
                     [query whereKey:@"userId" equalTo: result[@"id"]];
                     NSLog(@"Number of things found is %ld", (long)[query getFirstObject]);
                     
                     //if the query returns more then 1 object this means we have a record of this user
                     if([query getFirstObject] > 0) {
                         
                         NSLog(@"match found!");
                         
                         //once we know we have this user in our db we want to retrieve their highscore
                         PFQuery *query = [PFQuery queryWithClassName:@"Highscore"];
                         [query whereKey:@"userId" equalTo: result[@"id"]];
                         [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                             if (!error) {
                                 NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                                 for (PFObject *object in objects) {
                                     NSLog(@"%@", object[@"scoreValue"]);
                                     
                                     //this code saves the score and the userID for reference
                                     NSUserDefaults *scoreValue = [NSUserDefaults standardUserDefaults];
                                     [scoreValue setObject:object[@"Name"] forKey:@"PlayerName"];
                                     [scoreValue setObject:firstName[0] forKey:@"PlayerFirstName"];
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
                         
                         //This is the case where the user is logging in for the first time
                         //we want to save all of their information to the db
                        PFObject *newUser = [PFObject objectWithClassName:@"Highscore"];
                         newUser[@"Name"] = result[@"name"];
                         newUser[@"userId"] = result[@"id"];
                         newUser[@"scoreValue"] = @(0);
                         
                         //this code saves the score and the userID for reference (same as above)
                         NSUserDefaults *initialScore = [NSUserDefaults standardUserDefaults];
                         [initialScore setObject:@(0) forKey:@"HighScoreSaved"];
                         [initialScore setObject:result[@"id"] forKey:@"userID"];
                         [initialScore synchronize];
                    
                         //this command is what actually saves the code
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
        self.playButtonProperties.hidden = TRUE;
        self.backgroundImage.hidden = TRUE;
        self.goBackButton.hidden = TRUE;

        [self prepareScene];
        
    }
    
}

-(void)prepareScene{
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SGTitleScreenScene *scene = [SGTitleScreenScene sceneWithSize:skView.bounds.size];
    scene.name = @"titleScreen";
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKTransition *crossFade = [SKTransition crossFadeWithDuration:1.0f];
    
    // Present the scene
    [skView presentScene:scene transition:crossFade];
}

- (IBAction)playForFunTapped:(UIButton *)sender {
    
    self.playButtonProperties.hidden = TRUE;
    self.loginButton.hidden = TRUE;
    self.backgroundImage.hidden = TRUE;
    self.goBackButton.hidden = TRUE;
    
    //Deletes all cached information about the user
    
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [self prepareScene];
}

- (IBAction)goBackButtonTapped:(id)sender {
    
    self.playButtonProperties.hidden = TRUE;
    self.loginButton.hidden = TRUE;
    self.backgroundImage.hidden = TRUE;
    self.goBackButton.hidden = TRUE;
    [self prepareScene];
    
}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    
}

@end
