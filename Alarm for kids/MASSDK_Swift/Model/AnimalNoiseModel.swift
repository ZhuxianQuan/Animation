//
//  AnimalNoiseModel.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 15/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation

class AnimalNoiseModel {
    
    var animal_name = ""
    var animal_status = Constants.ANIMAL_SLEEP
    
    func getAwakeAnimalImageName() -> String{
        return "image_awake" + animal_name.lowercased()
    }
    
    func getSleepingAnimalImageName() -> String{
        return "image_sleeping" + animal_name.lowercased()
    }
    
    func getAudioFileName() -> String {
        return "animal_" + animal_name.lowercased().replacingOccurrences(of: " ", with: "_") + ".wav"
    }

}
