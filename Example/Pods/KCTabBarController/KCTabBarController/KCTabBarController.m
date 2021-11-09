//
//  KCTabBarViewController.m
//  KCBogusAPP
//
//  Created by cooci on 2021/11/7.
//

#import "KCTabBarController.h"

#define     KC_DOUBLE_CLICK_TIME_INTERVAL       0.4

@interface KCTabBarControllerDelegateEvent : NSObject <UITabBarControllerDelegate>

@property (nonatomic, strong) NSDate *lastClickDate;

- (id)initWithTabBarController:(KCTabBarController *)tabBarController;

@end

@implementation KCTabBarControllerDelegateEvent

- (id)initWithTabBarController:(KCTabBarController *)tabBarController{
    if (self = [super init]) {
        [tabBarController setDelegate:self];
    }
    return self;
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UIViewController *vc = viewController;
    if (([viewController isKindOfClass:[UINavigationController class]] || [viewController isMemberOfClass:[UINavigationController class]]) && viewController.childViewControllers.count > 0) {
        vc = viewController.childViewControllers.firstObject;
    }
    
    // 判断是否已选中
    NSInteger index = [tabBarController.tabBar.items indexOfObject:viewController.tabBarItem];
    if (tabBarController.selectedIndex == index) {
        NSDate *date = [NSDate date];
        BOOL isDoubleClick = NO;
        // 判断是不是双击
        if (self.lastClickDate) {
            CGFloat time = [date timeIntervalSinceDate:self.lastClickDate];
            isDoubleClick = time < KC_DOUBLE_CLICK_TIME_INTERVAL;
        }
    
        if (isDoubleClick) {
            self.lastClickDate = nil;
            if ([vc respondsToSelector:@selector(tabBarItemDidDoubleClick)]) {
                [(UIViewController<KCTabBarControllerProtocol> *)vc tabBarItemDidDoubleClick];
            }
        }else {
            self.lastClickDate = date;
            if (self.lastClickDate) {
                if ([vc respondsToSelector:@selector(tabBarItemDidClick:)]) {
                    [(UIViewController<KCTabBarControllerProtocol> *)vc tabBarItemDidClick:YES];
                }
            }
        }
        return NO;
    }
    
    // 根据自定义事件判断是否允许选中
    BOOL canSelected = YES;
    if (viewController.tabBarItem.clickActionBlock) {
        canSelected = viewController.tabBarItem.clickActionBlock();
    }
    if (canSelected) {
        if ([vc respondsToSelector:@selector(tabBarItemDidClick:)]) {
            [(UIViewController<KCTabBarControllerProtocol> *)vc tabBarItemDidClick:NO];
        }
    }
    return canSelected;
}
@end


#pragma mark - KCTabBarViewController

@interface KCTabBarController ()
@property (nonatomic, strong) KCTabBarControllerDelegateEvent *delegateEvent;
@end

@implementation KCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.delegateEvent = [[KCTabBarControllerDelegateEvent alloc] initWithTabBarController:self];
    [self setValue:[KCTabBar new] forKey:@"tabBar"];
}

- (void)addChildViewController:(UIViewController *)viewController actionBlock:(BOOL (^)(void))actionBlock
{
    [super addChildViewController:viewController];
    
    if (actionBlock) {
        if (([viewController isKindOfClass:[UINavigationController class]] || [viewController isMemberOfClass:[UINavigationController class]]) && viewController.childViewControllers.count > 0) {
            [viewController.childViewControllers.firstObject.tabBarItem setClickActionBlock:actionBlock];
        }
        else {
            [viewController.tabBarItem setClickActionBlock:actionBlock];
        }
    }
}

- (void)addPlusItemWithSystemTabBarItem:(UITabBarItem *)systemTabBarItem actionBlock:(void (^)(void))actionBlock
{
    [systemTabBarItem setIsPlusButton:YES];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.tabBarItem = systemTabBarItem;
    
    [self addChildViewController:vc actionBlock:^BOOL{
        if (actionBlock) {
            actionBlock();
        }
        return NO;
    }];
}



@end
