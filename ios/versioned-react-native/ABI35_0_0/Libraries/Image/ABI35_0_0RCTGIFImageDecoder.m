/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI35_0_0RCTGIFImageDecoder.h"

#import <ImageIO/ImageIO.h>
#import <QuartzCore/QuartzCore.h>

#import <ReactABI35_0_0/ABI35_0_0RCTUtils.h>

@implementation ABI35_0_0RCTGIFImageDecoder

ABI35_0_0RCT_EXPORT_MODULE()

- (BOOL)canDecodeImageData:(NSData *)imageData
{
  char header[7] = {};
  [imageData getBytes:header length:6];

  return !strcmp(header, "GIF87a") || !strcmp(header, "GIF89a");
}

- (ABI35_0_0RCTImageLoaderCancellationBlock)decodeImageData:(NSData *)imageData
                                              size:(CGSize)size
                                             scale:(CGFloat)scale
                                        resizeMode:(ABI35_0_0RCTResizeMode)resizeMode
                                 completionHandler:(ABI35_0_0RCTImageLoaderCompletionBlock)completionHandler
{
  CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
  if (!imageSource) {
    completionHandler(nil, nil);
    return ^{};
  }
  NSDictionary<NSString *, id> *properties = (__bridge_transfer NSDictionary *)CGImageSourceCopyProperties(imageSource, NULL);
  CGFloat loopCount = 0;
  if ([[properties[(id)kCGImagePropertyGIFDictionary] allKeys] containsObject:(id)kCGImagePropertyGIFLoopCount]) {
    loopCount = [properties[(id)kCGImagePropertyGIFDictionary][(id)kCGImagePropertyGIFLoopCount] unsignedIntegerValue];
    if (loopCount == 0) {
      // A loop count of 0 means infinite
      loopCount = HUGE_VALF;
    } else {
      // A loop count of 1 means it should repeat twice, 2 means, thrice, etc.
      loopCount += 1;
    }
  }

  UIImage *image = nil;
  size_t imageCount = CGImageSourceGetCount(imageSource);
  if (imageCount > 1) {

    NSTimeInterval duration = 0;
    NSMutableArray<NSNumber *> *delays = [NSMutableArray arrayWithCapacity:imageCount];
    NSMutableArray<id /* CGIMageRef */> *images = [NSMutableArray arrayWithCapacity:imageCount];
    for (size_t i = 0; i < imageCount; i++) {

      CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
      if (!imageRef) {
        continue;
      }
      if (!image) {
        image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
      }

      NSDictionary<NSString *, id> *frameProperties = (__bridge_transfer NSDictionary *)CGImageSourceCopyPropertiesAtIndex(imageSource, i, NULL);
      NSDictionary<NSString *, id> *frameGIFProperties = frameProperties[(id)kCGImagePropertyGIFDictionary];

      const NSTimeInterval kDelayTimeIntervalDefault = 0.1;
      NSNumber *delayTime = frameGIFProperties[(id)kCGImagePropertyGIFUnclampedDelayTime] ?: frameGIFProperties[(id)kCGImagePropertyGIFDelayTime];
      if (delayTime == nil) {
        if (delays.count == 0) {
          delayTime = @(kDelayTimeIntervalDefault);
        } else {
          delayTime = delays.lastObject;
        }
      }

      const NSTimeInterval kDelayTimeIntervalMinimum = 0.02;
      if (delayTime.floatValue < (float)kDelayTimeIntervalMinimum - FLT_EPSILON) {
        delayTime = @(kDelayTimeIntervalDefault);
      }

      duration += delayTime.doubleValue;
      [delays addObject:delayTime];
      [images addObject:(__bridge_transfer id)imageRef];
    }
    CFRelease(imageSource);

    NSMutableArray<NSNumber *> *keyTimes = [NSMutableArray arrayWithCapacity:delays.count];
    NSTimeInterval runningDuration = 0;
    for (NSNumber *delayNumber in delays) {
      [keyTimes addObject:@(runningDuration / duration)];
      runningDuration += delayNumber.doubleValue;
    }

    [keyTimes addObject:@1.0];

    // Create animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    animation.calculationMode = kCAAnimationDiscrete;
    animation.repeatCount = loopCount;
    animation.keyTimes = keyTimes;
    animation.values = images;
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    image.ReactABI35_0_0KeyframeAnimation = animation;

  } else {

    // Don't bother creating an animation
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    if (imageRef) {
      image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
      CFRelease(imageRef);
    }
    CFRelease(imageSource);
  }

  completionHandler(nil, image);
  return ^{};
}

@end
