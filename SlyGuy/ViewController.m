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
                     NSLog(@"fetched user:%@", result);
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
