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
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.center = self.view.center;
    [self.view addSubview:self.loginButton];

//    // Configure the view.
//    SKView * skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
//    
//    // Create and configure the scene.
//    SGTitleScreenScene *scene = [SGTitleScreenScene sceneWithSize:skView.bounds.size];
//    scene.name = @"titleScreen";
//    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    // Present the scene
//    [skView presentScene:scene];
}

- (IBAction)playForFunTapped:(UIButton *)sender {
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SGTitleScreenScene *scene = [SGTitleScreenScene sceneWithSize:skView.bounds.size];
    scene.name = @"titleScreen";
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    self.playButtonProperties.hidden = TRUE;
    self.loginButton.hidden = TRUE;

    // Present the scene
    [skView presentScene:scene];
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
