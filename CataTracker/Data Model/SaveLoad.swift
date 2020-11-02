//
//  SaveLoad.swift
//  CataTracker
//
//  Created by Martin Thomas on 8/5/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import Foundation

class SaveLoad {
    
    /**
     This allows to save the existing state of the Data
     */
    static func save() {
        let savedCatagory = CataData.catagoryModels
        UserDefaults.standard.set(try? PropertyListEncoder().encode(savedCatagory), forKey: "targetSaved")
        
    }
    
    /**
     This allows to load the existing state of the Data
     */
    static func load() {
        if let savedData = UserDefaults.standard.value(forKey:"targetSaved") as? Data {
            let savedCatagories = try? PropertyListDecoder().decode(Array<CatagoryModel>.self, from: savedData)
            CataData.catagoryModels = savedCatagories!
        }
    }
}
