//
//  AppUIButton.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/22/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class AppUIButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = Theme.tintColor
        layer.cornerRadius = frame.height / 2
        setTitleColor(UIColor.white, for: .normal)
    }
    
}
