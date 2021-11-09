//
//  KCTabBarExtension.h
//  KCBogusAPP
//
//  Created by cooci on 2021/11/7.
//

#import <UIKit/UIKit.h>
#import "KCBadge.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (KCExtension)

/// plusButton图片相对于底部的偏移量（凸出）
@property (nonatomic, assign) CGFloat plusButtonImageOffset;

/// tabbar顶部线

- (void)setHiddenShadow:(BOOL)hiddenShadow;

/// tabbar顶部黑线颜色

- (void)setShadowColor:(UIColor *)shadowColor;

@end


@interface UITabBarItem (KCExtension)

@property (nonatomic, assign, readonly) CGRect itemRect;

/// 是不是plusButton，一个标志而已
@property (nonatomic, assign) BOOL isPlusButton;

/// tabBarItem实际控件
@property (nonatomic, strong) UIControl *tabBarControl;

/// 红点view
@property (nonatomic, strong, readonly) KCBadge *kcBadge;

/// 点击事件，默认nil或返回YES执行页面页面跳转
@property (nonatomic, copy) BOOL (^clickActionBlock)(void);

@end




NS_ASSUME_NONNULL_END
