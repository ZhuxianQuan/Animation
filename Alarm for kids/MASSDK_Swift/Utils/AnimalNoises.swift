//
//  AnimalNoises.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 15/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation

class AnimalNoises{
    
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
