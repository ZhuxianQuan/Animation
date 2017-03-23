//
//  UIView+Extensions.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 22/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func emptyView() {
    
        for subView in subviews{
            subView.removeFromSuperview()
        }
        if layer.sublayers != nil {
            for sublayer in layer.sublayers! {
                sublayer.removeFromSuperlayer()
            }
        }
    }
}
