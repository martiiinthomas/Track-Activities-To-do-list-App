//
//  ActivityFunctions.swift
//  CataTracker
//
//  Created by Martin Thomas on 8/1/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class ActivityFunctions {
    
    /**
     Create an Activity
     */
    static func createActivity(catagoryIndex: Int, using activityModel: ActivityModel) {
        CataData.catagoryModels[catagoryIndex].activityModels.append(activityModel)
    }
    
    /**
     Delete an Activity
     */
    static func deleteActivity(catagoryIndex: Int, activityIndex: Int) {
        CataData.catagoryModels[catagoryIndex].activityModels.remove(at: activityIndex)
    }
    
    /**
     Update an Activity
     */
    static func updateActivity(catagoryIndex: Int, activityIndex: Int, activityModel: ActivityModel) {
        CataData.catagoryModels[catagoryIndex].activityModels[activityIndex] = activityModel
    }
    
}
