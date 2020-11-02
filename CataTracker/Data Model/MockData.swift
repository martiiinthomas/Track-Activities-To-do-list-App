//
//  MockData.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/28/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import Foundation

class MockData {
    static func createMockCatagoryData() -> [CatagoryModel] {
        var mockCatagories = [CatagoryModel]()
        mockCatagories.append(CatagoryModel(title: "Gym", activityModels: createMockActivityGym(), dateModels: createMockDatesGym(), targetHours: 8))
        mockCatagories.append(CatagoryModel(title: "Yoga", activityModels: createMockActivityYoga(), dateModels: createMockDatesYoga(),targetHours: 7))
        mockCatagories.append(CatagoryModel(title: "Coding", activityModels: createMockActivityCoding(), dateModels: createMockDatesCoding(),targetHours: 5))
        mockCatagories.append(CatagoryModel(title: "Study", activityModels: createMockActivityStudy(), dateModels: createMockDatesStudy(),targetHours: 6))
        return mockCatagories
    }
    
    static func createMockActivityGym() -> [ActivityModel] {
        var mockActivities = [ActivityModel]()
        mockActivities.append(ActivityModel(title: "Bicep Curls", subtitle: "3 sets"))
        mockActivities.append(ActivityModel(title: "Pull-ups", subtitle: "3 sets"))
        mockActivities.append(ActivityModel(title: "Dips", subtitle: "2 sets"))
        mockActivities.append(ActivityModel(title: "Bench Press", subtitle: "3 sets (start with a plate)"))
        mockActivities.append(ActivityModel(title: "Deadlift", subtitle: "3 sets (warm-up first)"))
        return mockActivities
    }
    
    static func createMockActivityYoga() -> [ActivityModel] {
        var mockActivities = [ActivityModel]()
        mockActivities.append(ActivityModel(title: "Chair Pose", subtitle: "15 seconds"))
        mockActivities.append(ActivityModel(title: "Boat Pose", subtitle: "10-15 seconds"))
        mockActivities.append(ActivityModel(title: "Downward Facing Dog", subtitle: ""))
        mockActivities.append(ActivityModel(title: "Low Lunge", subtitle: "Make sure to switch legs"))
        mockActivities.append(ActivityModel(title: "Bridge Pose", subtitle: "30 seconds"))
        mockActivities.append(ActivityModel(title: "Warrior II", subtitle: "15 seconds (switch sides)"))
        mockActivities.append(ActivityModel(title: "Half Pidgeon Pose", subtitle: "1-2 minutes (switch legs)"))
        return mockActivities
    }
    
    static func createMockActivityCoding() -> [ActivityModel] {
        var mockActivities = [ActivityModel]()
        mockActivities.append(ActivityModel(title: "Swift", subtitle: "Mon, Tue, Fri"))
        mockActivities.append(ActivityModel(title: "Python", subtitle: "Wed, Thur"))
        mockActivities.append(ActivityModel(title: "Java", subtitle: "Sat, Sun"))
        return mockActivities
    }
    
    static func createMockActivityStudy() -> [ActivityModel] {
        var mockActivities = [ActivityModel]()
        mockActivities.append(ActivityModel(title: "Math Exam", subtitle: "Fri"))
        mockActivities.append(ActivityModel(title: "English Reading", subtitle: "50 pages / day"))
        return mockActivities
    }
    
    static func createMockDatesGym() -> [DateModel] {
        var mockDates = [DateModel]()
        mockDates.append(DateModel(day: Date(), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -1), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -2), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -3), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -4), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -10), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -11), hours: 3))
        mockDates.append(DateModel(day: Date().add(days: -13), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -16), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -23), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -24), hours: 2))
        return mockDates
    }
    
    static func createMockDatesYoga() -> [DateModel] {
        var mockDates = [DateModel]()
        mockDates.append(DateModel(day: Date(), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -1), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -2), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -3), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -4), hours: 0))
        mockDates.append(DateModel(day: Date().add(days: -10), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -12), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -14), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -17), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -24), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -25), hours: 1))
        return mockDates
    }
    
    static func createMockDatesCoding() -> [DateModel] {
        var mockDates = [DateModel]()
        mockDates.append(DateModel(day: Date(), hours: 3))
        mockDates.append(DateModel(day: Date().add(days: -5), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -7), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -9), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -12), hours: 3))
        mockDates.append(DateModel(day: Date().add(days: -15), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -16), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -17), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -26), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -27), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -28), hours: 3))
        return mockDates
    }
    
    static func createMockDatesStudy() -> [DateModel] {
        var mockDates = [DateModel]()
        mockDates.append(DateModel(day: Date(), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -3), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -10), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -11), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -12), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -13), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -14), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -25), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -26), hours: 1))
        mockDates.append(DateModel(day: Date().add(days: -27), hours: 2))
        mockDates.append(DateModel(day: Date().add(days: -28), hours: 2))
        return mockDates
    }
}
