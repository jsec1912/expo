/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <UIKit/UIKit.h>

#import <ReactABI35_0_0/ABI35_0_0RCTComponent.h>
#import <ABI35_0_0yoga/ABI35_0_0YGEnums.h>

@class ABI35_0_0RCTShadowView;

@interface UIView (ReactABI35_0_0) <ABI35_0_0RCTComponent>

/**
 * ABI35_0_0RCTComponent interface.
 */
- (NSArray<UIView *> *)ReactABI35_0_0Subviews NS_REQUIRES_SUPER;
- (UIView *)ReactABI35_0_0Superview NS_REQUIRES_SUPER;
- (void)insertReactABI35_0_0Subview:(UIView *)subview atIndex:(NSInteger)atIndex NS_REQUIRES_SUPER;
- (void)removeReactABI35_0_0Subview:(UIView *)subview NS_REQUIRES_SUPER;

/**
 * The native id of the view, used to locate view from native codes
 */
@property (nonatomic, copy) NSString *nativeID;

/**
 * Determines whether or not a view should ignore inverted colors or not. Used to set
 * UIView property accessibilityIgnoresInvertColors in iOS 11+.
 */
@property (nonatomic, assign) BOOL shouldAccessibilityIgnoresInvertColors;

/**
 * Layout direction of the view.
 * Internally backed to `semanticContentAttribute` property.
 * Defaults to `LeftToRight` in case of ambiguity.
 */
@property (nonatomic, assign) UIUserInterfaceLayoutDirection ReactABI35_0_0LayoutDirection;

/**
 * Yoga `display` style property. Can be `flex` or `none`.
 * Defaults to `flex`.
 * May be used to temporary hide the view in a very efficient way.
 */
@property (nonatomic, assign) ABI35_0_0YGDisplay ReactABI35_0_0Display;

/**
 * The z-index of the view.
 */
@property (nonatomic, assign) NSInteger ReactABI35_0_0ZIndex;

/**
 * Subviews sorted by z-index. Note that this method doesn't do any caching (yet)
 * and sorts all the views each call.
 */
- (NSArray<UIView *> *)ReactABI35_0_0ZIndexSortedSubviews;

/**
 * Updates the subviews array based on the ReactABI35_0_0Subviews. Default behavior is
 * to insert the sortedReactABI35_0_0Subviews into the UIView.
 */
- (void)didUpdateReactABI35_0_0Subviews;

/**
 * Called each time props have been set.
 * The default implementation does nothing.
 */
- (void)didSetProps:(NSArray<NSString *> *)changedProps;

/**
 * Used by the UIIManager to set the view frame.
 * May be overriden to disable animation, etc.
 */
- (void)ReactABI35_0_0SetFrame:(CGRect)frame;

/**
 * This method finds and returns the containing view controller for the view.
 */
- (UIViewController *)ReactABI35_0_0ViewController;

/**
 * This method attaches the specified controller as a child of the
 * the owning view controller of this view. Returns NO if no view
 * controller is found (which may happen if the view is not currently
 * attached to the view hierarchy).
 */
- (void)ReactABI35_0_0AddControllerToClosestParent:(UIViewController *)controller;

/**
 * Focus manipulation.
 */
- (void)ReactABI35_0_0Focus;
- (void)ReactABI35_0_0FocusIfNeeded;
- (void)ReactABI35_0_0Blur;

/**
 * Useful properties for computing layout.
 */
@property (nonatomic, readonly) UIEdgeInsets ReactABI35_0_0BorderInsets;
@property (nonatomic, readonly) UIEdgeInsets ReactABI35_0_0PaddingInsets;
@property (nonatomic, readonly) UIEdgeInsets ReactABI35_0_0CompoundInsets;
@property (nonatomic, readonly) CGRect ReactABI35_0_0ContentFrame;

/**
 * The (sub)view which represents this view in terms of accessibility.
 * ViewManager will apply all accessibility properties directly to this view.
 * May be overriten in view subclass which needs to be accessiblitywise
 * transparent in favour of some subview.
 * Defaults to `self`.
 */
@property (nonatomic, readonly) UIView *ReactABI35_0_0AccessibilityElement;

@end
