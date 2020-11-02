//
//  CatagoriesTableViewCell.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/24/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class CatagoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weeklyTarget: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 35)
        weeklyTarget.font = UIFont(name: Theme.mainFontName, size: 15)
        titleLabel.textColor = Theme.backgroundColor
        weeklyTarget.textColor = Theme.backgroundColor
        cardView.backgroundColor = Theme.Accent
        cardView.addShadowAndRoundedCorners()
    }
    
    func setup(catagoryModel: CatagoryModel) {
        titleLabel.text = catagoryModel.title
        if catagoryModel.targetHours > 0 {
            weeklyTarget.text = "Hours per Week: \(String(catagoryModel.targetHours))"
        } else {
            weeklyTarget.text = ""
        }
    }
}


