//
//  FlutterUnityPlugin.swift
//  flutter_unity_widget
//
//  Created by Thomas Stockx on 7/25/19.
//

import Foundation

public class FlutterUnityPlugin: NSObject, FlutterPlugin {
    static var registrar: FlutterPluginRegistrar?
    static var channel: FlutterMethodChannel?
    
    public init(with registrar: FlutterPluginRegistrar) {
        FlutterUnityPlugin.channel = FlutterMethodChannel(name: "unity_view", binaryMessenger: registrar.messenger())
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        FlutterUnityPlugin.registrar = registrar
        
        let channel = FlutterMethodChannel(name: "unity_view", binaryMessenger: registrar.messenger())
        let instance = FlutterUnityPlugin(with: registrar)
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        registrar.register(FlutterUnityViewFactory() as FlutterPlatformViewFactory, withId: "unity_view")
    
    }
}
