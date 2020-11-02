//
//  CatagoryModel.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/28/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

struct CatagoryModel: Codable {
    let id: UUID
    var title: String!
    var activityModels = [ActivityModel]()
    var targetHours: Int!
    var dateModels = [DateModel]() {
        didSet{
            dateModels = dateModels.sorted(by: <)
        }
    }
    
    init(title: String, activityModels: [ActivityModel]? = nil, dateModels: [DateModel]? = nil) {
        id = UUID()
        self.title = title
        self.targetHours = 0
        
        if let activityModels = activityModels{
            self.activityModels = activityModels
        }
        
        if let dateModels = dateModels {
            self.dateModels = dateModels
        }
    }
    
    init(title: String, activityModels: [ActivityModel]? = nil, dateModels: [DateModel]? = nil, targetHours: Int) {
        id = UUID()
        self.title = title
        self.targetHours = targetHours
        
        if let activityModels = activityModels{
            self.activityModels = activityModels
        }
        
        if let dateModels = dateModels {
            self.dateModels = dateModels
        }
    }
}
