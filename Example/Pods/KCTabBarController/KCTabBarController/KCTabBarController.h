//
//  KCTabBarViewController.h
//  KCBogusAPP
//
//  Created by cooci on 2021/11/7.
//

#import <UIKit/UIKit.h>
#import "KCTabBar.h"

NS_ASSUME_NONNULL_BEGIN


@protocol KCTabBarControllerProtocol <NSObject>

@optional;

/// tabBar被单击
- (void)tabBarItemDidClick:(BOOL)isSelected;

/// tabBar被双击（仅在已选中时调用）
- (void)tabBarItemDidDoubleClick;

@end

@interface KCTabBarController : UITabBarController

@end

NS_ASSUME_NONNULL_END
