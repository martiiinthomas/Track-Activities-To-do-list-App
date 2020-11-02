//
//  ActivityTableViewCell.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/30/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.addShadowAndRoundedCorners()
        titleLabel.font = UIFont(name: Theme.bodyFontNameDemiBold, size: 20)
        subtitleLabel.font = UIFont(name: Theme.bodyFontName, size: 17)
    }
    
    func setup(model: ActivityModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
}
