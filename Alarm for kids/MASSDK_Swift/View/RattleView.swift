//
//  RattleView.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 12/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import UIKit

class RattleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
 */
    
    var rattle: RattleModel!
    var imageView : UIImageView!
    func initView() {
        // Drawing code
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        self.backgroundColor = .clear
        //self.backgroundColor = .white
    }
    
    
    
    func setView(_ rattle: RattleModel)
    {
        center.x = rattle.rattle_rect.x * screenSize.width
        center.y = rattle.rattle_rect.y * screenSize.width
        
        frame.size = CGSize(width : screenSize.width * rattle.rattle_rect.radius * 2 , height : screenSize.width * rattle.rattle_rect.radius * 2)
        
        imageView.image = rattle.rattle_image
        imageView.frame.size = self.frame.size
        imageView.center = CGPoint(x : screenSize.width * rattle.rattle_rect.radius, y : screenSize.width * rattle.rattle_rect.radius)
    }
    
    func moveView(_ rattle: RattleModel)
    {
        center.x = rattle.rattle_rect.x * screenSize.width
        center.y = rattle.rattle_rect.y * screenSize.width
        self.transform = CGAffineTransform(rotationAngle: rattle.rattle_rect.rotation)
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
