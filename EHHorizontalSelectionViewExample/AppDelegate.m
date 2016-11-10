//
//  AppDelegate.m
//  EHHorizontalSelectionView
//
//  Created by Danila Gusev on 30/08/2016.
//  Copyright © 2016 josshad. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString* path = [[NSBundle mainBundle] pathForResource:@"outfilexx"
                                                     ofType:@"csv"];
    NSString * csv = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray * array = [csv componentsSeparatedByString:@"\n"];
    NSInteger index = 1;
    NSMutableString * saveString = [NSMutableString string];
    for (NSString * str in array)
    {
        NSArray * arr = [str componentsSeparatedByString:@";"];
        
        NSString * strToSave = [arr lastObject];
        if (strToSave.length < 3)
        {
            strToSave = [arr firstObject];
        }
        strToSave = [strToSave stringByReplacingOccurrencesOfString:@"," withString:@";"];
        [saveString appendFormat:@"%ld,%@\n",(long)index,strToSave];
        
        index ++;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savepath = [documentsDirectory stringByAppendingPathComponent:@"EmployeeData.csv"];

    [saveString writeToFile:savepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
