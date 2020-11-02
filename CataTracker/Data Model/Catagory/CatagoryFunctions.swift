//
//  CatagoryFunctions.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/29/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class CatagoryFunctions {
    /**
     Create a Catagory
     */
    static func createCatagory(catagoryModel: CatagoryModel) {
        CataData.catagoryModels.append(catagoryModel)
    }
    
    /**
     Returns Mock Catagories if no Catagories exist
     */
    static func readCatagories(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if CataData.catagoryModels.count == 0 {
                CataData.catagoryModels = MockData.createMockCatagoryData()
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    /**
     Returns the specified Catagory using an ID
     */
    static func readCatagory(by id: UUID, completion: @escaping (CatagoryModel?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let catagory = CataData.catagoryModels.first(where: { $0.id == id })
            
            DispatchQueue.main.async {
                completion(catagory)
            }
        }
        
    }
    
    /**
     Update a Catagory
     */
    static func updateCatagory(at index: Int, title: String, hour: Int) {
        CataData.catagoryModels[index].title = title
        CataData.catagoryModels[index].targetHours = hour
        
    }
    
    /**
     Delete a Catagory
     */
    static func deleteCatagory(index: Int) {
        CataData.catagoryModels.remove(at: index)
    }
    
    
    
}
