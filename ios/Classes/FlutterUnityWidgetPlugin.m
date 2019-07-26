//
//  FlutterUnityWidgetPlugin.m
//  flutter_unity_widget
//
//  Created by Thomas Stockx on 7/25/19.
//

#import "FlutterUnityWidgetPlugin.h"
#import <flutter_unity_widget/flutter_unity_widget-Swift.h>

@implementation FlutterUnityWidgetPlugin : NSObject
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [FlutterUnityPlugin registerWithRegistrar:registrar];
}
@end
