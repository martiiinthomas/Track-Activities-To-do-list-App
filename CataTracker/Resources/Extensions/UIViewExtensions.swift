//
//  UIViewExtensions.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/29/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

extension UIView {
    
    // Gives the rounded corners of every row view
    func addShadowAndRoundedCorners() {
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 10
    }
}
