//
//  DateModel.swift
//  CataTracker
//
//  Created by Martin Thomas on 8/13/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import Foundation

struct DateModel: Codable {
    var day = Date()
    var hours: Int!
    
    init(day: Date, hours: Int) {
        self.day = day
        self.hours = hours
    }
}

extension DateModel: Comparable {
    static func < (lhs: DateModel, rhs: DateModel) -> Bool {
        return lhs.day < rhs.day
    }
    
    static func == (lhs: DateModel, rhs: DateModel) -> Bool {
        return lhs.day == rhs.day
    }
}
