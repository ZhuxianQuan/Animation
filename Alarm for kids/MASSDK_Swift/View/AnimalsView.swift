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
    
    var animals : [AnimalNoiseModel] = []
    
    var awakedItem : Int = -1
    
    var awakedItemMoved : CGFloat = 0.0
    
    //var delegate: AnimalsViewDelegate!
    
    func initWith(animals: [AnimalNoiseModel])
    {
        
        var index = 0
        
        self.animals = animals
        NSLog("\(viewSize)")
        
        
        viewSize = CGSize(width: screenSize.width * CGFloat(Int(animals.count + 1)) / 2 , height: screenSize.height - 81)
        
        for animal in animals{
            var imageView = UIImageView()
            var imageSize = CGSize()
            let image = UIImage(named: animal.getSleepingAnimalImageName())!
            if UIScreen.main.bounds.width < 330 {
                imageSize = CGSize(width: image.size.width * 0.8, height: image.size.height * 0.8)
            }
            else{
                imageSize = image.size
            }
            if index % 2 == 0{
                imageView.frame = CGRect(x: 0 + screenSize.width * CGFloat(Int(index / 2)), y: 75, width: imageSize.width, height: imageSize.height)
            }
            else
            {
                imageView.frame = CGRect(x: screenSize.width - 0 - imageSize.width + screenSize.width * CGFloat(Int(index / 2)), y: screenSize.height - imageSize.height - 121, width: imageSize.width, height: imageSize.height)
            }
            
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            NSLog("\(imageView.frame)")
            view1.addSubview(imageView)
            var button = UIButton(frame: imageView.frame)
            view1.addSubview(button)
            button.tag = index * 10 + 10
            imageView.tag = index * 10 + 11
            button.addTarget(self, action: #selector(selectAnimal(_:)), for: .touchUpInside)
            
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
            button = UIButton(frame: imageView.frame)
            view2.addSubview(button)
            button.tag = index * 10 + 10
            imageView.tag = index * 10 + 11 + 1000
            button.addTarget(self, action: #selector(selectAnimal(_:)), for: .touchUpInside)
            index += 1
            
        }
        
        self.frame.size = CGSize(width: viewSize.width * 2 , height: viewSize.height)
        setInitFrame()
        addSubview(view1)
        
        addSubview(view2)
        NSLog("\(view1.frame)")
        NSLog("\(view2.frame)")        
        
    }
    
    func selectAnimal(_ sender : UIButton){
        NSLog("Tag ===== \(sender.tag)")
        
        let imageView1 = self.viewWithTag(sender.tag + 1) as? UIImageView
        let imageView2 = self.viewWithTag(sender.tag + 1001) as? UIImageView
        if imageView1 != nil && imageView2 != nil{
            var imagename = ""
            if awakedItem == -1{
                if animals[(sender.tag - 10) / 10].animal_status == Constants.ANIMAL_SLEEP{
                    imagename = animals[(sender.tag - 10) / 10].getAwakeAnimalImageName()
                    animals[(sender.tag - 10) / 10].animal_status = Constants.ANIMAL_AWAKE
                    awakedItem = (sender.tag - 10) / 10
                    
                    imageView1?.image = UIImage(named: imagename)!
                    imageView2?.image = UIImage(named: imagename)!
                    
                    awakedItemMoved = 0
                }
                
            }
            else{
                if animals[(sender.tag - 10) / 10].animal_status == Constants.ANIMAL_AWAKE{
                    imagename = animals[(sender.tag - 10) / 10].getSleepingAnimalImageName()
                    animals[(sender.tag - 10) / 10].animal_status = Constants.ANIMAL_SLEEP
                    awakedItem = -1
                    
                    imageView1?.image = UIImage(named: imagename)!
                    imageView2?.image = UIImage(named: imagename)!
                }
                
            }
        }
    }
    
    func setItemSleep() {
        animals[awakedItem].animal_status = Constants.ANIMAL_SLEEP
        let imageView1 = self.viewWithTag(awakedItem * 10 + 11) as? UIImageView
        let imageView2 = self.viewWithTag(awakedItem * 10 + 1011) as? UIImageView
        let imagename = animals[awakedItem].getSleepingAnimalImageName()
        imageView1?.image = UIImage(named: imagename)!
        imageView2?.image = UIImage(named: imagename)!
        awakedItem = -1
    }
    
    func animateView(){
        if (view1.frame.origin.x - 1.5 < -1 * (viewSize.width)){
            setInitFrame()
            
        }
        else{
            view1.frame.origin.x -= 0.5
            view2.frame.origin.x -= 0.5
            awakedItemMoved += 0.5
            if awakedItemMoved > view1.frame.size.width - screenSize.width && awakedItem > -1{
                setItemSleep()
            }
        }
        
    }
    
    func animateAccelateView(){
        if (view1.frame.origin.x < -1 * (viewSize.width)){
            setInitFrame()
        }
        else{
            view1.frame.origin.x -= 4
            view2.frame.origin.x -= 4
            awakedItemMoved += 4
            if awakedItemMoved > view1.frame.size.width - screenSize.width && awakedItem > -1{
                setItemSleep()
            }
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


