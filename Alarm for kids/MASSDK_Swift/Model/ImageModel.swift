
//
//  ImageModel.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 24/02/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation


class ImageModel{
    
    var image : UIImage!
    var left : CGFloat = 0.0
    var top : CGFloat = 0.0
    var topRatio : CGFloat!
    
    func getFrame(_ parentHeight: CGFloat) -> CGRect{
        let size = image.size
        if topRatio != nil{
            return CGRect(x: left, y: parentHeight * topRatio - size.height / 2, width: size.width, height: size.height)
        }
        else{
            return CGRect(x: left, y: top, width: size.width, height: size.height)
        }
    }
}
