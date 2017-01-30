//
//  UIImageView+Color.swift
//  Langu.ag
//
//  Created by Huijing on 24/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{


    func setImageWith(color: UIColor)
    {

        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
}
