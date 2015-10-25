//
//  ViewController.h
//  SlyGuy
//

//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *playButtonProperties;
@property FBSDKLoginButton *loginButton;

@end
