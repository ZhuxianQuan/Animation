//
//  FloatingImageContentView.swift
//  Alarm For Children
//
//  Created by Huijing on 24/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

public protocol FloatingImageContentViewDelegate {
    func imageTapped(_ view : FloatingImageContentView)
}

public class FloatingImageContentView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //let MaximumProgressValue: CGFloat = 100
    var button1 = UIButton()
    var button2 = UIButton()
    var imageSize = CGSize()
    
    var isCloud = 0
    var statusText = ""
    
    var maxMovingAmountForCloud:CGFloat = 5
    let maxRotatingAmountForStar:CGFloat = 0.5
    var rotateAngle : CGFloat = 0
    var isMovingUp = true
    
    var leftCoValue: CGFloat = 0

    var maxSizeOfWidth: CGFloat = 1875

    var delegate: FloatingImageContentViewDelegate!
    
    var floatingItem: FloatingItemModel!

    func initWith(item: FloatingItemModel)
    {
        floatingItem = item
        let image = UIImage(named: item.getImageName())!
        imageSize = image.size
        self.frame.size = CGSize(width: maxSizeOfWidth * 2 , height: imageSize.height)
        button1.setImage(image, for: .normal)
        button2.setImage(image, for: .normal)
        button1.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setInitFrame()
        addSubview(button1)
        addSubview(button2)
        if getGlobalTime() % 2 == 0{
            isMovingUp = true
        }
        else{
            isMovingUp = false
        }
    }

    func animateView(){
        if isCloud == Constants.BABY_RADIO_CLOUD{
            if (button1.frame.origin.x - 1.5 < -1 * (maxSizeOfWidth) + leftCoValue){
                setInitFrame()
            }
            else{
                button1.frame.origin.x -= 0.5
                button2.frame.origin.x -= 0.5
                
                if isMovingUp{
                    if button1.frame.origin.y < maxMovingAmountForCloud{
                    
                    button1.frame.origin.y += 0.1
                        button2.frame.origin.y += 0.1
                    }
                    else{
                        isMovingUp = false
                    }
                }
                else{
                    
                    if button1.frame.origin.y > maxMovingAmountForCloud * (-1){
                        
                        button1.frame.origin.y -= 0.1
                        button2.frame.origin.y -= 0.1
                    }
                        
                    else{
                        isMovingUp = true
                    }
                }
            }
        }
        else if isCloud == Constants.BABY_RADIO_STAR {
            if (button1.center.x - 1.5 - imageSize.width / 2 <  -1 * (maxSizeOfWidth) + leftCoValue)
            {
                setInitFrame()
            }
            else {
                button1.center.x -= 0.5
                button2.center.x -= 0.5
                if isMovingUp{
                    if maxRotatingAmountForStar > rotateAngle{
                        button1.transform = CGAffineTransform(rotationAngle: rotateAngle)
                        button2.transform = CGAffineTransform(rotationAngle: rotateAngle)
                        rotateAngle += 0.003
                    }
                    else{
                        isMovingUp = false
                    }
                }
                else{
                    if maxRotatingAmountForStar > (-1) * rotateAngle{
                        if rotateAngle < 0{
                            button1.transform = CGAffineTransform(rotationAngle: 6.28 + rotateAngle)
                            button2.transform = CGAffineTransform(rotationAngle: 6.28 + rotateAngle)
                        }
                        else{
                            button1.transform = CGAffineTransform(rotationAngle: rotateAngle)
                            button2.transform = CGAffineTransform(rotationAngle: rotateAngle)
                        }
                        rotateAngle -= 0.003
                        
                        
                    }
                    else{
                        isMovingUp = true
                    }
                }
            }
        }
        else{
            
            if (button1.center.x - 1.5 - imageSize.width / 2 <  -1 * (maxSizeOfWidth) + leftCoValue)
            {
                setInitFrame()
            }
            else {
                button1.center.x -= 0.5
                button2.center.x -= 0.5
            }
            
            
        }

    }

    func animateAccelateView(_ direction: Bool){
        if direction{
            if isCloud == Constants.BABY_RADIO_CLOUD{
                if (button1.frame.origin.x < -1 * (maxSizeOfWidth)){
                    setInitFrame()
                }
                else{
                    button1.frame.origin.x -= 5
                    button2.frame.origin.x -= 5
                }
            }
            else if isCloud == Constants.BABY_RADIO_STAR{
                if (button1.center.x - 1.5 - imageSize.width / 2 <  -1 * (maxSizeOfWidth) + leftCoValue){
                    setInitFrame()
                }
                else{
                    button1.center.x -= 5
                    button2.center.x -= 5
                }
            }
            else{
                
                if (button1.center.x - 1.5 - imageSize.width / 2 <  -1 * (maxSizeOfWidth) + leftCoValue)
                {
                    setInitFrame()
                }
                else {
                    button1.center.x -= 0.5
                    button2.center.x -= 0.5
                }
                
                
            }
        }/*
        else{
            if isCloud == Constants.BABY_RADIO_CLOUD{
                if (button1.frame.origin.x > -1.5){
                    setInitFrame()
                }
                else{
                    button1.frame.origin.x += 5
                    button2.frame.origin.x += 5
                }
            }
            else if isCloud == Constants.BABY_RADIO_STAR{
                if (button1.center.x - 1.5 - imageSize.width / 2 <  -1 * (maxSizeOfWidth) + leftCoValue){
                    setInitFrame()
                }
                else{
                    button1.center.x += 5
                    button2.center.x += 5
                }
            }
            else{
                
                if (button1.center.x - 1.5 - imageSize.width / 2 <  -1 * (maxSizeOfWidth) + leftCoValue)
                {
                    setInitFrame()
                }
                else {
                    button1.center.x += 0.5
                    button2.center.x += 0.5
                }
                
                
            }
        }*/


    }
    
    func setInitFrame() {
        rotateAngle = 0
        button1.transform = CGAffineTransform(rotationAngle: 0)
        button2.transform = CGAffineTransform(rotationAngle: 0)
        button1.frame = CGRect(x: leftCoValue, y: 0, width: imageSize.width, height: imageSize.height)
        button2.frame = CGRect(x: maxSizeOfWidth - 2 + leftCoValue, y: 0, width: imageSize.width, height: imageSize.height)
    }
    /*
    func setRightInitFrame() {
        rotateAngle = 0
        button1.transform = CGAffineTransform(rotationAngle: 0)
        button2.transform = CGAffineTransform(rotationAngle: 0)
        button1.frame = CGRect(x: maxSizeOfWidth - screenSize.width, y: 0, width: imageSize.width, height: imageSize.height)
        button2.frame = CGRect(x: maxSizeOfWidth - 2 + leftCoValue, y: 0, width: imageSize.width, height: imageSize.height)
    }*/

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


