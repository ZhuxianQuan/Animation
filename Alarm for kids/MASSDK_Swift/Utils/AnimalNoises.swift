//
//  AnimalNoises.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 15/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation

class AnimalNoises{
    /*animalImages.append(UIImage(named: "image_awakecat")!)
    animalImages.append(UIImage(named: "image_awakegoat")!)
    animalImages.append(UIImage(named: "image_awakecock")!)
    animalImages.append(UIImage(named: "image_awakedog")!)
    animalImages.append(UIImage(named: "image_awakehen")!)
    animalImages.append(UIImage(named: "image_awakesheep")!)
    animalImages.append(UIImage(named: "image_awakecow")!)
    animalImages.append(UIImage(named: "image_awakehorse")!)
    animalImages.append(UIImage(named: "image_awakepig")!)
    
    animalImages.append(UIImage(named: "image_sleepingcat")!)
    animalImages.append(UIImage(named: "image_sleepinggoat")!)
    animalImages.append(UIImage(named: "image_sleepingcock")!)
    animalImages.append(UIImage(named: "image_sleepingdog")!)
    animalImages.append(UIImage(named: "image_sleepinghen")!)
    animalImages.append(UIImage(named: "image_sleepingsheep")!)
    animalImages.append(UIImage(named: "image_sleepingcow")!)
    animalImages.append(UIImage(named: "image_sleepinghorse")!)
    animalImages.append(UIImage(named: "image_sleepingpig")!)*/
    
    static func getAnimalNoises() -> [AnimalNoiseModel]{
        var result : [AnimalNoiseModel] = []
        
        var animalModel = AnimalNoiseModel()
        
        animalModel.animal_name = "cat"
        animalModel.animal_status = Constants.ANIMAL_SLEEP
        result.append(animalModel)
        animalModel = AnimalNoiseModel()
        animalModel.animal_name = "goat"
        animalModel.animal_status = Constants.ANIMAL_SLEEP
        result.append(animalModel)

        animalModel = AnimalNoiseModel()
        animalModel.animal_name = "cock"
        animalModel.animal_status = Constants.ANIMAL_SLEEP
        result.append(animalModel)

        animalModel = AnimalNoiseModel()
        animalModel.animal_name = "dog"
        animalModel.animal_status = Constants.ANIMAL_SLEEP
        result.append(animalModel)

        animalModel = AnimalNoiseModel()
        animalModel.animal_name = "hen"
        animalModel.animal_status = Constants.ANIMAL_SLEEP
        result.append(animalModel)

        animalModel = AnimalNoiseModel()
        animalModel.animal_name = "sheep"
        animalModel.animal_status = Constants.ANIMAL_SLEEP
        result.append(animalModel)

        animalModel = AnimalNoiseModel()
        animalModel.animal_name = "cow"
        animalModel.animal_status = Constants.ANIMAL_SLEEP
        result.append(animalModel)

        animalModel = AnimalNoiseModel()
        animalModel.animal_name = "horse"
        animalModel.animal_status = Constants.ANIMAL_SLEEP
        result.append(animalModel)

        animalModel = AnimalNoiseModel()
        animalModel.animal_name = "pig"
        animalModel.animal_status = Constants.ANIMAL_SLEEP
        result.append(animalModel)

        
        return result
    }
    
}
