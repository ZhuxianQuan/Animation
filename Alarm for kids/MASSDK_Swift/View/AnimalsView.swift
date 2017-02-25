//
//  FloatingImageContentView.swift
//  Alarm For Children
//
//  Created by Huijing on 24/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
/*
public protocol AnimalsViewDelegate {
    func imageTapped(_ index : Int)
}
*/
public class AnimalsView: UIView {
    
    
    var view1 = UIView()
    var view2 = UIView()
    
    var viewSize = CGSize()
    
    
    //var delegate: AnimalsViewDelegate!
    
    func initWith(images: [UIImage])
    {
        let screenSize = UIScreen.main.bounds.size
        var index = 0
        
        
        NSLog("\(viewSize)")
        
        
        viewSize = CGSize(width: screenSize.width * CGFloat(Int(images.count + 1)) / 2 , height: screenSize.height - 81)
        
        for image in images{
            var imageView = UIImageView()
            
            
            let imageSize = image.size
            if index % 2 == 0{
                imageView.frame = CGRect(x: 0 + screenSize.width * CGFloat(Int(index / 2)), y: 75, width: imageSize.width, height: imageSize.height)
            }
            else
            {
                imageView.frame = CGRect(x: screenSize.width - 0 - imageSize.width + screenSize.width * CGFloat(Int(index / 2)), y: screenSize.height - imageSize.height - 121, width: imageSize.width, height: imageSize.height)
            }
            
            imageView.image = image
            imageView.contentMode = .scaleToFill
            NSLog("\(imageView.frame)")
            view1.addSubview(imageView)
            
            
            
            imageView = UIImageView()
            
            if index % 2 == 0{
                imageView.frame = CGRect(x: screenSize.width * CGFloat(index / 2) + screenSize.width * CGFloat(Int(index / 2)), y: 75, width: imageSize.width, height: imageSize.height)
            }
            else
            {
                imageView.frame = CGRect(x: screenSize.width * CGFloat(index / 2) + screenSize.width - 0 - imageSize.width + screenSize.width * CGFloat(Int(index / 2)), y: screenSize.height - imageSize.height - 121, width: imageSize.width, height: imageSize.height)
            }
            
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            NSLog("\(imageView.frame)")

            view2.addSubview(imageView)
            index += 1
            
        }
        
        self.frame.size = CGSize(width: viewSize.width * 2 , height: viewSize.height)
        setInitFrame()
        addSubview(view1)
        addSubview(view2)
        NSLog("\(view1.frame)")
        NSLog("\(view2.frame)")        
        
    }
    
    func animateView(){
        if (view1.frame.origin.x - 1.5 < -1 * (viewSize.width)){
            setInitFrame()
        }
        else{
            view1.frame.origin.x -= 0.5
            view2.frame.origin.x -= 0.5
        }
        
    }
    
    func animateAccelateView(){
        if (view1.frame.origin.x < -1 * (viewSize.width)){
            setInitFrame()
        }
        else{
            view1.frame.origin.x -= 2
            view2.frame.origin.x -= 2
        }
        
    }
    
    func setInitFrame() {
        view1.frame = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        view2.frame = CGRect(x: viewSize.width - 2, y: 0, width: viewSize.width, height: viewSize.height)
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
    
    
}


