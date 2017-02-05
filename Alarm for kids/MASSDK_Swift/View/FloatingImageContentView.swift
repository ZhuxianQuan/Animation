//
//  FloatingImageContentView.swift
//  Alarm For Children
//
//  Created by Huijing on 24/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

public protocol FloatingImageContentViewDelegate {
    func imageTapped(_ index : Int)
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


    var delegate: FloatingImageContentViewDelegate!

    func initWith(image: UIImage)
    {
        imageSize = image.size
        self.frame.size = CGSize(width: imageSize.width * 2 , height: imageSize.height)
        button1.setImage(image, for: .normal)
        button2.setImage(image, for: .normal)
        button1.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        setInitFrame()
        addSubview(button1)
        addSubview(button2)
    }

    func animateView(){
        if (button1.frame.origin.x - 1.5 < -1 * (imageSize.width)){
            setInitFrame()
        }
        else{
            button1.frame.origin.x -= 0.5
            button2.frame.origin.x -= 0.5
        }

    }

    func animateAccelateView(){
        if (button1.frame.origin.x < -1 * (imageSize.width)){
            setInitFrame()
        }
        else{
            button1.frame.origin.x -= 2
            button2.frame.origin.x -= 2
        }

    }

    func setInitFrame() {
            button1.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
            button2.frame = CGRect(x: imageSize.width - 2, y: 0, width: imageSize.width, height: imageSize.height)
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
        imageTapDelegate.imageTapped(self.tag)
        NSLog("buttonTapped")
    }

}


