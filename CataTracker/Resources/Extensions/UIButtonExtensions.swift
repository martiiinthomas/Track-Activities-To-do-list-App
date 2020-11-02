//
//  UIButtonExtensions.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/29/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

extension UIButton {
    
    // Gives the round red look for the main action button
    func createFloatingActionButton() {
        backgroundColor = Theme.tintColor
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}
