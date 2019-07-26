//
//  FlutterUnityView.swift
//  flutter_unity_widget
//
//  Created by Thomas Stockx on 7/25/19.
//

import Foundation
import Flutter

public class FlutterUnityView : NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId : Int64
    
    init(_ frame:CGRect, viewId:Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
    }
    
    public func view() -> UIView {
        let view : UIView = UIView(frame: self.frame)
        view.backgroundColor = UIColor.lightGray
        return view
    }
}
