//
//  ActivityModel.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/28/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import Foundation

struct ActivityModel: Codable {
    let id: String!
    var title: String!
    var subtitle = ""
    
    init(title: String  , subtitle: String) {
        id = UUID().uuidString
        self.title = title
        self .subtitle = subtitle
    }
}

extension ActivityModel: Comparable {
    static func < (lhs: ActivityModel, rhs: ActivityModel) -> Bool {
        return lhs.title < rhs.title
    }
    
    static func == (lhs: ActivityModel, rhs: ActivityModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
