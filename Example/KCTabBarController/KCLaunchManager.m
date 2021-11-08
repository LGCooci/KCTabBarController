//
//  KCLaunchManager.m
//  KCTabBarController_Example
//
//  Created by cooci on 2021/11/8.
//  Copyright © 2021 cooci_tz@163.com. All rights reserved.
//

#import "KCLaunchManager.h"
#import "UIColor+KCColor.h"
#import "KCViewController.h"

UINavigationController *addNavigationController(UIViewController *viewController)
{
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navC;
}

void initTabBarItem(UITabBarItem *tabBarItem, NSString *tilte, NSString *image, NSString *imageHL) {
    [tabBarItem setTitle:tilte];
    [tabBarItem setImage:[UIImage imageNamed:image]];
    [tabBarItem setSelectedImage:[UIImage imageNamed:imageHL]];
}

@interface KCLaunchManager ()

@end

@implementation KCLaunchManager

@synthesize tabBarController = _tabBarController;

+ (KCLaunchManager *)sharedInstance
{
    static KCLaunchManager *rootVCManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootVCManager = [[self alloc] init];
    });
    return rootVCManager;
}


- (NSArray *)p_createTabBarChildViewController
{
    KCViewController *vc1 = [[KCViewController alloc] init];
    initTabBarItem(vc1.tabBarItem, LOCSTR(@"微信"), @"tabbar_mainframe", @"tabbar_mainframeHL");
    KCViewController *vc2 = [[KCViewController alloc] init];
    initTabBarItem(vc2.tabBarItem, LOCSTR(@"通讯录"), @"tabbar_contacts", @"tabbar_contactsHL");
    [vc2.tabBarItem setBadgeValue:@"109"];

    KCViewController *vc3 = [[KCViewController alloc] init];
    initTabBarItem(vc3.tabBarItem, LOCSTR(@"发现"), @"tabbar_discover", @"tabbar_discoverHL");
    [vc3.tabBarItem setBadgeValue:@"9"];

    KCViewController *vc4 = [[KCViewController alloc] init];
    initTabBarItem(vc4.tabBarItem, LOCSTR(@"我"), @"tabbar_me", @"tabbar_meHL");


    NSArray *data = @[addNavigationController(vc1),
                      addNavigationController(vc2),
                      addNavigationController(vc3),
                      addNavigationController(vc4),
                      ];
    return data;
}


#pragma mark - # Getters
- (KCTabBarController *)tabBarController
{
    if (!_tabBarController) {
        KCTabBarController *tabbarController = [[KCTabBarController alloc] init];
        [tabbarController.tabBar setBackgroundColor:[UIColor colorGrayBG]];
        [tabbarController.tabBar setTintColor:[UIColor colorGreenDefault]];
        _tabBarController = tabbarController;
        [_tabBarController setViewControllers:[self p_createTabBarChildViewController]];
    }
    return _tabBarController;
}



@end
