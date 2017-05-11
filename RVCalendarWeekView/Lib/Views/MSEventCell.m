//
//  MSEventCell.m
//  Example
//
//  Created by Eric Horacek on 2/26/13.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

#import "MSEventCell.h"

#define MAS_SHORTHAND
#import "Masonry.h"
#import "UIColor+HexString.h"
#import "RVCollection.h"
#import "MSDurationChangeIndicator.h"

@interface MSEventCell ()

@property (nonatomic, strong) UIView *topBorderView;

@end

@implementation MSEventCell

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        self.layer.shouldRasterize = YES;
        
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0.0, 4.0);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.0;
        
        self.borderView = [UIView new];
        [self.contentView addSubview:self.borderView];
        
        self.topBorderView = [UIView new];
        self.topBorderView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.topBorderView];
        
        self.title = [UILabel new];
        self.title.numberOfLines = 0;
        self.title.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = false;
        [self.contentView addSubview:self.title];
        
        self.imageView = [UIImageView new];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.layer.cornerRadius = 12.5;
        self.imageView.layer.masksToBounds = true;
        [self.contentView addSubview: self.imageView];
        
        self.nameLabel = [UILabel new];
        self.nameLabel.font = [UIFont systemFontOfSize: 10.0];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.layer.cornerRadius = 12.5;
        self.nameLabel.layer.masksToBounds = true;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameLabel];
        
        [self updateColors];
        
        CGFloat borderWidth = 2.0;
        UIEdgeInsets contentPadding = UIEdgeInsetsMake(4.0, (borderWidth + 4.0), 1.0, 4.0);
        
        [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height);
            make.width.equalTo(@(borderWidth));
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
        }];
        
        [self.topBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(borderWidth));
            make.width.equalTo(self.mas_width);
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(contentPadding.top);
            make.left.equalTo(self.mas_left).offset(contentPadding.left);
            make.right.equalTo(self.mas_right).offset(-contentPadding.right - 35);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(25));
            make.width.equalTo(@(25));
            make.right.equalTo(self.mas_right).offset(-contentPadding.right-5);
            make.top.equalTo(self.mas_top).offset(contentPadding.top);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(25));
            make.width.equalTo(@(25));
            make.right.equalTo(self.mas_right).offset(-contentPadding.right-5);
            make.top.equalTo(self.mas_top).offset(contentPadding.top);
        }];
    }
    return self;
}

#pragma mark - UICollectionViewCell
//- (void)setSelected:(BOOL)selected
//{
//    if (selected && (self.selected != selected)) {
//        [UIView animateWithDuration:0.1 animations:^{
//            self.transform = CGAffineTransformMakeScale(1.025, 1.025);
//            self.layer.shadowOpacity = 0.2;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.1 animations:^{
//                self.transform = CGAffineTransformIdentity;
//            }];
//        }];
//    } else if (selected) {
//        self.layer.shadowOpacity = 0.2;
//    } else {
//        self.layer.shadowOpacity = 0.0;
//    }
//    [super setSelected:selected]; // Must be here for animation to fire
//    [self updateColors];    
//    [self removeIndicators];
//}


#pragma mark - MSEventCell
- (void)setEvent:(MSEvent *)event
{
    _event = event;
    self.title.attributedText    = [[NSAttributedString alloc] initWithString:_event.title attributes:[self titleAttributesHighlighted:self.selected]];
    self.nameLabel.textColor = [UIColor whiteColor];
    if (event.image == nil) {
        [self.imageView setHidden: true];
        self.nameLabel.text = event.nameText;
        self.nameLabel.backgroundColor = event.nameBackgroundColor;
        [self.nameLabel setHidden: false];
    } else {
        self.imageView.image = event.image;
        [self.nameLabel setHidden: true];
        [self.imageView setHidden: false];
    }
//    self.location.attributedText = [[NSAttributedString alloc] initWithString:_event.location attributes:[self subtitleAttributesHighlighted:self.selected]];
    [self updateColors];
}


- (void)updateColors
{
    self.contentView.backgroundColor = [self backgroundColorHighlighted:self.selected];
    self.borderView.backgroundColor  = [self borderColor];
    self.title.textColor             = [self textColorHighlighted:self.selected];
}

-(void)removeIndicators{
    [self.subviews each:^(UIView* subview) {
        if([subview isKindOfClass:MSDurationChangeIndicator.class]){
            [subview removeFromSuperview];
        }
    }];
}

- (NSDictionary *)titleAttributesHighlighted:(BOOL)highlighted
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.hyphenationFactor = 1.0;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    return @{
             NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0],
             NSForegroundColorAttributeName : [self textColorHighlighted:highlighted],
             NSParagraphStyleAttributeName : paragraphStyle
             };
}

- (NSDictionary *)subtitleAttributesHighlighted:(BOOL)highlighted
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.hyphenationFactor = 1.0;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    return @{
             NSFontAttributeName : [UIFont systemFontOfSize:12.0],
             NSForegroundColorAttributeName : [self textColorHighlighted:highlighted],
             NSParagraphStyleAttributeName : paragraphStyle
             };
}

- (UIColor *)backgroundColorHighlighted:(BOOL)selected
{
    return selected ? [UIColor colorWithHexString:@"35b1f1"] : [[UIColor colorWithHexString:@"35b1f1"] colorWithAlphaComponent:0.2];
}

- (UIColor *)textColorHighlighted:(BOOL)selected
{
    return selected ? [UIColor whiteColor] : [UIColor colorWithHexString:@"21729c"];
}

- (UIColor *)borderColor
{
    return [[self backgroundColorHighlighted:NO] colorWithAlphaComponent:1.0];
}

@end
