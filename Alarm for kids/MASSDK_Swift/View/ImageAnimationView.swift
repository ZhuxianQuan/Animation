//
//  ImageSetAnimationView.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 24/02/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageAnimationViewDelegate {
    func imageTapped(_ view : ImageAnimationView)
}

public class ImageAnimationView : UIView{
    var imageModel : ImageModel!
    
    var button1 = UIButton()
    var button2 = UIButton()
    var imageSize = CGSize()
    
    var maxSizeOfWidth: CGFloat = 375
    var delegate : ImageAnimationViewDelegate!
    
    var parentHeight : CGFloat = 0
    
    
    func initWith(_ imageModel: ImageModel, parentHeight: CGFloat){
        self.imageModel = imageModel
        self.parentHeight = parentHeight
        let customFrame = imageModel.getFrame(parentHeight)
        imageSize = customFrame.size
        let image = imageModel.image
        self.frame.size = CGSize(width: maxSizeOfWidth * 2 , height: imageSize.height)
        
        button1.setImage(image, for: .normal)
        button2.setImage(image, for: .normal)
        setInitFrame()
        
        addSubview(button1)
        addSubview(button2)
        
        button1.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setInitFrame(){
        
        button1.frame = imageModel.getFrame(parentHeight)
        button2.frame = CGRect(x: maxSizeOfWidth + button1.frame.origin.x, y: button1.frame.origin.y, width: imageSize.width, height: imageSize.height)
    }
    
    
    func animateView(){
        if (button1.center.x - 1.5 - imageSize.width / 2 <  -1 * (maxSizeOfWidth) + imageModel.left)
        {
            setInitFrame()
        }
        else {
            button1.center.x -= 0.5
            button2.center.x -= 0.5
        }
        
    }
    
    func animateAccelateView(){
        
        if (button1.center.x - 1.5 - imageSize.width / 2 <  -1 * (maxSizeOfWidth) + imageModel.left){
            setInitFrame()
        }
        else{
            button1.frame.origin.x -= 5
            button2.frame.origin.x -= 5
        }
        
    }
    
    @IBInspectable var treshold: CGFloat = 1.0 {
        didSet {
            if treshold > 1.0 {
                treshold = 1.0
            }
            if treshold < 0.0 {
                treshold = 0.0
            }
        }
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.alphaFromPoint(point) > treshold
    }
    
    func buttonTapped(){
        guard let imageTapDelegate = delegate else
        {
            return
        }
        imageTapDelegate.imageTapped(self)
        NSLog("buttonTapped")
    }
    
}
