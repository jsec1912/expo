//
//  ABI38_0_0RNSharedElementTransitionManager.m
//  ABI38_0_0React-native-shared-element
//

#import <ABI38_0_0React/ABI38_0_0RCTBridge.h>
#import <ABI38_0_0React/ABI38_0_0RCTUIManager.h>
#import "ABI38_0_0RNSharedElementTransitionManager.h"
#import "ABI38_0_0RNSharedElementTransition.h"
#import "ABI38_0_0RNSharedElementNodeManager.h"
#import "ABI38_0_0RNSharedElementTypes.h"

@implementation ABI38_0_0RNSharedElementTransitionManager
{
  ABI38_0_0RNSharedElementNodeManager* _nodeManager;
}

ABI38_0_0RCT_EXPORT_MODULE(ABI38_0_0RNSharedElementTransition);

- (instancetype) init
{
  if ((self = [super init])) {
    _nodeManager = [[ABI38_0_0RNSharedElementNodeManager alloc]init];
  }
  return self;
}

- (UIView *)view
{
  return [[ABI38_0_0RNSharedElementTransition alloc] initWithNodeManager:_nodeManager];
}

- (dispatch_queue_t)methodQueue
{
  return self.bridge.uiManager.methodQueue;
}

- (ABI38_0_0RNSharedElementNode*) nodeFromJson:(NSDictionary*)json
{
  if (json == nil) return nil;
  NSNumber* nodeHandle = [json valueForKey:@"nodeHandle"];
  NSNumber* isParent =[json valueForKey:@"isParent"];
  if ([nodeHandle isKindOfClass:[NSNumber class]]) {
    UIView *sourceView = [self.bridge.uiManager viewForABI38_0_0ReactTag:nodeHandle];
    return [_nodeManager acquire:nodeHandle view:sourceView isParent:[isParent boolValue]];
  }
  return nil;
}

ABI38_0_0RCT_EXPORT_VIEW_PROPERTY(nodePosition, CGFloat);
ABI38_0_0RCT_EXPORT_VIEW_PROPERTY(animation, NSInteger);
ABI38_0_0RCT_EXPORT_VIEW_PROPERTY(resize, NSInteger);
ABI38_0_0RCT_EXPORT_VIEW_PROPERTY(align, NSInteger);
ABI38_0_0RCT_CUSTOM_VIEW_PROPERTY(startNode, NSObject, ABI38_0_0RNSharedElementTransition)
{
  view.startNode = [self nodeFromJson:[json valueForKey:@"node"]];
  view.startAncestor = [self nodeFromJson:[json valueForKey:@"ancestor"]];
}
ABI38_0_0RCT_CUSTOM_VIEW_PROPERTY(endNode, NSObject, ABI38_0_0RNSharedElementTransition)
{
  view.endNode = [self nodeFromJson:[json valueForKey:@"node"]];
  view.endAncestor = [self nodeFromJson:[json valueForKey:@"ancestor"]];
}
ABI38_0_0RCT_EXPORT_VIEW_PROPERTY(onMeasureNode, ABI38_0_0RCTDirectEventBlock);

ABI38_0_0RCT_REMAP_METHOD(configure,
                 config:(NSDictionary *)config
                 resolver:(ABI38_0_0RCTPromiseResolveBlock)resolve
                 rejecter:(ABI38_0_0RCTPromiseRejectBlock)reject)
{
  NSArray* imageResolvers = [config valueForKey:@"imageResolvers"];
  if (imageResolvers != nil) {
    [ABI38_0_0RNSharedElementNode setImageResolvers:imageResolvers];
  }
  resolve(@(YES));
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

@end
