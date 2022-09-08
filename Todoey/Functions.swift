//
//  Functions.swift
//  Todoey
//
//  Created by Samet Koyuncu on 8.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

struct Functions {
    static func getArrayFromUIColor(for color: UIColor) -> List<Double> {
        let components = color.cgColor.components ?? [1.0, 1.0, 1.0, 1.0]
        
        let doubleArray = List<Double>()
        
        doubleArray.append(components[0])
        doubleArray.append(components[1])
        doubleArray.append(components[2])
        doubleArray.append(components[3])
        
        return doubleArray
    }

    static func getUIColorfromArray(for array: List<Double>?) -> UIColor {
        let color = UIColor(red: array![0], green: array![1], blue: array![2], alpha: array![3])

        return color
    }
    
}


