//
//  MackenzieAppDelegate.m
//  Navigation
//
//  Created by Vinicius Miana on 2/21/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "MackenzieAppDelegate.h"
#import "LetrasViewController.h"
#import "InicioViewController.h"

@implementation MackenzieAppDelegate{
}

@synthesize navigationController, tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LetrasViewController *viewController = [[LetrasViewController alloc]
                                           initWithNibName:nil
                                           bundle:nil];
    InicioViewController *inicio = [[InicioViewController alloc]initWithNibName:nil bundle: nil];
    
    navigationController = [[UINavigationController alloc] init];
    [navigationController setViewControllers: [NSArray arrayWithObjects:viewController, nil]];
    
    tabBarController = [[UITabBarController alloc]init];
//    UITabBarItem  *tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1];
//    [tabBarController setTabBarItem: tabBarItem];
    
    [tabBarController setViewControllers: [NSArray arrayWithObjects: inicio, navigationController, nil]];
    UIImage *imagem1 = [[UIImage alloc]init];
    imagem1 = [UIImage imageNamed:@"TabView.png"];
    
    UIImage *imagem2 = [[UIImage alloc]init];
    imagem2 = [UIImage imageNamed:@"dicionario.png"];

    navigationController.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:imagem1 tag: 1];
    inicio.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:imagem2 tag:0];
    
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;{
//    [viewController.view setNeedsDisplay];
//}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
