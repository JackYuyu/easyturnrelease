//
//  OTTextView.m
//  OTTextView
//
//  Created by OUT MAN on 16/8/3.
//  Copyright © 2016年 OUT MAN. All rights reserved.
//

#import "OTTextView.h"
#import "UIView+AHkit.h"
#define kX_Margin 5
#define kY_Margin 7.5

@interface OTTextView () {
    UILabel *_labPlaceholder;
    CGFloat _cacheHeight;
}

@end

@implementation OTTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layoutManager.allowsNonContiguousLayout = NO;
        _labPlaceholder = [[UILabel alloc] init];
        _labPlaceholder.backgroundColor = [UIColor clearColor];
        _labPlaceholder.numberOfLines = 0;
        _labPlaceholder.textColor = [UIColor lightTextColor];
        [self addSubview:_labPlaceholder];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        _cacheHeight = 0.f;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 默认的约束
    _labPlaceholder.minY = kY_Margin;
    _labPlaceholder.minX = kX_Margin;
    
    // 用户的约束
    if (self.placeholderTopSpace) _labPlaceholder.minY = self.placeholderTopSpace;
    if (self.placeholderLeftSpace) _labPlaceholder.minX = self.placeholderLeftSpace;
    
    _labPlaceholder.width = self.width - _labPlaceholder.minX * 2.0;
    
    CGSize maxSize = CGSizeMake(_labPlaceholder.width, MAXFLOAT);
    _labPlaceholder.height = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _labPlaceholder.font} context:nil].size.height;
}

- (void)textDidChange {
    _labPlaceholder.hidden = self.hasText;
    if (self.text && self.text.length && [_ot_delegate respondsToSelector:@selector(textView:currentHeight:)]) {
        CGSize size = [self.text boundingRectWithSize:CGSizeMake(_labPlaceholder.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font} context:nil].size;
        CGFloat needHeight = size.height + kY_Margin * 2;
        if (needHeight == _cacheHeight) return;
        _cacheHeight = needHeight;
        [_ot_delegate textView:self currentHeight:needHeight];
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [self setContentOffset:CGPointZero animated:YES];
        self.scrollsToTop = YES;
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString*)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}

#pragma mark - 设置
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    _labPlaceholder.text = placeholder;
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    _labPlaceholder.textColor = _placeholderColor;
}

- (void)setFont:(UIFont *)font {
    _labPlaceholder.font = font;
    [super setFont:font];
}

#pragma mark - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
}

@end
