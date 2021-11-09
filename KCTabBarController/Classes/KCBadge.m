//
//  KCBadge.m
//  KCBogusAPP
//
//  Created by cooci on 2021/11/7.
//

#import "KCBadge.h"

#define     KCFONT_TITLE          [UIFont systemFontOfSize:11]
#define     KCEDGE_TITLE          self.frame.size.height * 0.3
#define     KCMAX_HEIGHT          22.0f
#define     KCMIN_HEIGHT          8.0f

@interface KCBadge ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation KCBadge

+ (CGSize)badgeSizeWithValue:(NSString *)value
{
    return [self badgeSizeWithValue:value font:KCFONT_TITLE];
}

+ (CGSize)badgeSizeWithValue:(NSString *)value font:(UIFont *)font
{
    return [self badgeSizeWithValue:value font:font maxHeight:KCMAX_HEIGHT minHeight:KCMIN_HEIGHT];
}

+ (CGSize)badgeSizeWithValue:(NSString *)value font:(UIFont *)font maxHeight:(CGFloat)maxHeight minHeight:(CGFloat)minHeight
{
    if (!value) {
        return CGSizeZero;
    }
    if ([value isEqualToString:@""]) {
        return CGSizeMake(minHeight, minHeight);
    }
    CGSize size = [value sizeWithAttributes:@{NSFontAttributeName : font}];
    CGFloat width = size.width > maxHeight ?  size.width + maxHeight * 0.8 : maxHeight;
    return CGSizeMake(width, maxHeight);
}

#pragma mark - # Init
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.layer setMasksToBounds:YES];
        [self addSubview:self.titleLabel];
        
        // 默认属性设置
        [self setBackgroundColor:[UIColor redColor]];
        [self setTitleColor:[UIColor whiteColor]];
        [self setTitleFont:KCFONT_TITLE];
        [self setMaxHeight:KCMAX_HEIGHT];
        [self setMinHeight:KCMIN_HEIGHT];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 更新圆角大小
    [self.layer setCornerRadius:self.frame.size.height / 2.0];
    // 更新titleLabel坐标和大小
    if (self.badgeValue == nil) {
        [self.titleLabel setFrame:CGRectZero];
        return;
    }
    else if ([self.badgeValue isEqualToString:@""]) {
        [self.titleLabel setFrame:CGRectMake(0, 0, self.minHeight, self.minHeight)];
    }
    else {
        CGFloat height = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width - KCEDGE_TITLE, height)];
    }
    
    [self.titleLabel setCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)];
}

#pragma mark - # Public Methods
- (void)setBadgeValue:(id)badgeValue
{
    if ([badgeValue intValue] >99) {
        badgeValue = @"99";
    }
    _badgeValue = badgeValue;

    [self.titleLabel setText:badgeValue];
    [self.titleLabel sizeToFit];
    
    [self p_resetFrame];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [self.titleLabel setFont:titleFont];
    
    [self p_resetFrame];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self.titleLabel setTextColor:titleColor];
}

- (void)setMaxHeight:(CGFloat)maxHeight
{
    _maxHeight = maxHeight;
    
    [self p_resetFrame];
}

- (void)setMinHeight:(CGFloat)minHeight
{
    _minHeight = minHeight;
    
    [self p_resetFrame];
}


- (void)p_resetFrame
{
    CGSize size = [KCBadge badgeSizeWithValue:self.badgeValue font:self.titleFont maxHeight:self.maxHeight minHeight:self.minHeight];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height)];
    [self setNeedsDisplay];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
    }
    return _titleLabel;
}

@end
