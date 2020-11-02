//
//  DateExtensions.swift
//  CataTracker
//
//  Created by Martin Thomas on 8/13/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import Foundation

extension Date{
    /**
     This is to add days selected day
     */
    func add(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day , value: days, to: Date())!
    }
    
    /**
     This returns the Medium String format of a day
     */
    func mediumDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
    
    /**
     This returns true or false whether a day is in between two other days
     */
    func isBetween(startDate:Date, endDate:Date)->Bool
    {
        return (startDate.compare(self) == .orderedAscending) && (endDate.compare(self) == .orderedDescending) || (startDate.compare(self) == .orderedDescending) && (endDate.compare(self) == .orderedAscending)
    }
}
