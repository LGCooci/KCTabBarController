//
//  KCLaunchManager.h
//  KCTabBarController_Example
//
//  Created by cooci on 2021/11/8.
//  Copyright © 2021 cooci_tz@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KCTabBarController/KCTabBarController.h>

NS_ASSUME_NONNULL_BEGIN

@interface KCLaunchManager : NSObject
/// 当前根控制器
@property (nonatomic, strong, readonly) __kindof UIViewController *curRootVC;

/// 根tabBarController
@property (nonatomic, strong, readonly) KCTabBarController *tabBarController;

+ (KCLaunchManager *)sharedInstance;
@end

NS_ASSUME_NONNULL_END
