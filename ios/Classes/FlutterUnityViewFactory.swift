//
//  FlutterUnityViewFactory.swift
//  flutter_unity_widget
//
//  Created by Thomas Stockx on 7/25/19.
//

import Foundation
import Flutter

public class FlutterUnityViewFactory: NSObject, FlutterPlatformViewFactory {
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlutterUnityView(frame, viewId: viewId, args: args)
    }
}

