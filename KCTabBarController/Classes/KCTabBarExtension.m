//
//  KCTabBarExtension.m
//  KCBogusAPP
//
//  Created by cooci on 2021/11/7.
//

#import "KCTabBarExtension.h"
#import <objc/runtime.h>

#pragma mark - UITabBar + KCExtension

UIImage *kc_imageWithColor(UIColor *color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


@implementation UITabBar (KCExtension)

- (void)setHiddenShadow:(BOOL)hiddenShadow
{
    if (self.barTintColor) {
        [self setBackgroundImage:kc_imageWithColor(self.barTintColor)];
    }
    else {
        [self setBackgroundImage:kc_imageWithColor([UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0])];
    }
    if (hiddenShadow) {
        [self setShadowImage:[UIImage new]];
    }
    else {
        [self setShadowImage:nil];
    }
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    [self setHiddenShadow:NO];
    if (shadowColor) {
        [self setShadowImage:kc_imageWithColor(shadowColor)];
    }
    else {
        [self setShadowImage:[UIImage new]];
    }
}

static char *kc_plusButtonImageOffset = "kc_plusButtonImageOffset";
- (void)setPlusButtonImageOffset:(CGFloat)plusButtonImageOffset
{
    objc_setAssociatedObject(self, &kc_plusButtonImageOffset, @(plusButtonImageOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)plusButtonImageOffset
{
    return [(NSNumber *)objc_getAssociatedObject(self, &kc_plusButtonImageOffset) doubleValue];
}

static char *kc_plusItemWidthRatio = "kc_plusItemWidthRatio";
- (void)setPlusItemWidthRatio:(CGFloat)plusItemWidthRatio
{
    objc_setAssociatedObject(self, &kc_plusItemWidthRatio, @(plusItemWidthRatio), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)plusItemWidthRatio
{
    CGFloat radio = [(NSNumber *)objc_getAssociatedObject(self, &kc_plusItemWidthRatio) doubleValue];
    return radio > 0.0 ? radio : 1.0;
}

static char *kc_edgeLR = "kc_edgeLR";
- (void)setEdgeLR:(CGFloat)edgeLR
{
    objc_setAssociatedObject(self, &kc_edgeLR, @(edgeLR), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)edgeLR
{
    CGFloat radio = [(NSNumber *)objc_getAssociatedObject(self, &kc_edgeLR) doubleValue];
    return radio > 0.0 ? radio : 1.0;
}

@end

#pragma mark - UITabBarItem+KCExtension

#define KCExchangeMethod(oldSEL, newSEL) {  \
    Method oldMethod = class_getInstanceMethod(self, oldSEL);\
    Method newMethod = class_getInstanceMethod(self, newSEL);\
    method_exchangeImplementations(oldMethod, newMethod); \
}

static char *kc_tabBarControl = "kc_tabBarControl";
static char *kc_badge = "kc_badge";
static char *kc_isPlusButton = "kc_isPlusButton";
static char *kc_actionBlock = "kc_actionBlock";

@implementation UITabBarItem (KCExtension)

+ (void)load
{
    KCExchangeMethod(@selector(setBadgeValue:), @selector(kc_setBadgeValue:))
    KCExchangeMethod(@selector(setBadgeColor:), @selector(kc_setBadgeColor:))
}

- (void)kc_setBadgeValue:(NSString *)badgeValue
{
    [self.kcBadge setBadgeValue:badgeValue];
    
    [self p_resetBadgeView];
}

- (void)kc_setBadgeColor:(UIColor *)badgeColor
{
    [self.kcBadge setBackgroundColor:badgeColor];
}

- (void)p_resetBadgeView
{
    [self.kcBadge removeFromSuperview];

    if (!self.tabBarControl || self.badgeValue == nil) {
        return;
    }
    
    [self.tabBarControl addSubview:self.kcBadge];
    [self.kcBadge.layer setZPosition:100];

    CGSize size = [KCBadge badgeSizeWithValue:self.badgeValue];
    CGFloat x, y;
    CGFloat h = size.height;
    CGFloat w = MIN(size.width, self.tabBarControl.frame.size.width * 0.7);
    if ([self.badgeValue isEqualToString:@""]) {
        x = self.tabBarControl.frame.size.width * 0.63;
        y = 3.5;
    }
    else {
        x = self.tabBarControl.frame.size.width * 0.58;
        y = 2;
    }

    [self.kcBadge setFrame:CGRectMake(x, y, w, h)];
}

#pragma mark - Getter & Setters

- (CGRect)itemRect
{
    return self.tabBarControl.frame;
}


- (KCBadge *)kcBadge
{
    KCBadge *badge = objc_getAssociatedObject(self, kc_badge);
    if (!badge) {
        badge = [[KCBadge alloc] init];
        [badge setUserInteractionEnabled:NO];
        objc_setAssociatedObject(self, kc_badge, badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return badge;
}

- (NSString *)badgeValue
{
    return self.kcBadge.badgeValue;
}

- (UIColor *)badgeColor
{
    return self.kcBadge.backgroundColor;
}

- (void)setTabBarControl:(UIControl *)tabBarControl
{
    objc_setAssociatedObject(self, kc_tabBarControl, tabBarControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self p_resetBadgeView];
}
- (UIControl *)tabBarControl
{
    return objc_getAssociatedObject(self, kc_tabBarControl);
}

- (void)setIsPlusButton:(BOOL)isPlusButton
{
    objc_setAssociatedObject(self, kc_isPlusButton, @(isPlusButton), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isPlusButton
{
    return [objc_getAssociatedObject(self, kc_isPlusButton) boolValue];
}

- (void)setClickActionBlock:(BOOL (^)(void))clickActionBlock
{
    objc_setAssociatedObject(self, kc_actionBlock, clickActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL (^)(void))clickActionBlock
{
    return objc_getAssociatedObject(self, kc_actionBlock);
}

@end

