//
//  DateFunctions.swift
//  CataTrack
//
//  Created by Martin Thomas on 8/13/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import Foundation
import UIKit

class DateFunctions {
    
    /**
     Create a Date for Category
     */
    static func createDate(catagoryIndex: Int, using dateModel: DateModel) {
        CataData.catagoryModels[catagoryIndex].dateModels.append(dateModel)
    }
    
    /**
     Update a Date for Category
     */
    static func updateDate(catagoryIndex: Int, dateIndex: Int, newHours: Int) {
        CataData.catagoryModels[catagoryIndex].dateModels[dateIndex].hours = newHours
    }
    
    /**
     Delete all Dates over 100 days old
     */
    static func deleteDateOverHundred() {
        for (index, i) in CataData.catagoryModels.enumerated() {
            for (subIndex, j) in i.dateModels.enumerated() {
                if j.day < Date().add(days: -100){
                    CataData.catagoryModels[index].dateModels.remove(at: subIndex)
                    print("Deleted index \(index) at subIndex \(subIndex)")
                }
            }
        }
    }
}
