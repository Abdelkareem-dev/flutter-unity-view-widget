//
//  FlutterUnityWidgetPlugin.h
//  Pods
//
//  Created by Thomas Stockx on 7/25/19.
//

#import <Flutter/Flutter.h>

@interface FlutterUnityWidgetPlugin : NSObject<FlutterPlugin>
+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar;

@end
