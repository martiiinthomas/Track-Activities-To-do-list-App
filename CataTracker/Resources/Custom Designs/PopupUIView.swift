//
//  PopupUIView.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/22/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class PopupUIView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 10
        
        backgroundColor = Theme.backgroundColor
    }
}

