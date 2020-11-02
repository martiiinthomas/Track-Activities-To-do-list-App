//
//  AddActivityViewController.swift
//  CataTracker
//
//  Created by Martin Thomas on 8/2/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var saveButton: AppUIButton!
    
    
    // For Saving
    var doneSaving: ((ActivityModel) -> ())?
    var catagoryIndex: Int!
    
    // For Editing
    var activityIndexToEdit: Int?
    var activityModelToEdit: ActivityModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Aesthetics
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 22)
        titleLabel.textColor = Theme.Accent
        
        // Populating Card
        if let activityModel = activityModelToEdit {
            titleLabel.text = "Edit Activity"
            titleTextField.text = activityModel.title
            subtitleTextField.text = activityModel.subtitle
            saveButton.setTitle("Update", for: .normal)
        }
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        // Check to see if text field is blank before continuing
        guard titleTextField.text != "", let newActivityTitle = titleTextField.text else {
            titleTextField.layer.borderColor = UIColor.red.cgColor
            titleTextField.layer.borderWidth = 2
            titleTextField.layer.cornerRadius = 5
            titleTextField.placeholder = "Activity name required"
            titleTextField.rightViewMode = .always
            return
        }
        
        let activityModel = ActivityModel(title: newActivityTitle, subtitle: subtitleTextField.text ?? "")
        
        
        if activityModelToEdit != nil {
            // Update Activity
            ActivityFunctions.updateActivity(catagoryIndex: catagoryIndex, activityIndex: activityIndexToEdit!, activityModel: activityModel)
            if let doneSaving = doneSaving {
                doneSaving(activityModel)
            }
        } else {
            // Save Activity
            ActivityFunctions.createActivity(catagoryIndex: catagoryIndex, using: activityModel)
            if let doneSaving = doneSaving {
                doneSaving(activityModel)
            }
        }
        
        
        dismiss(animated: true)
    }
    
}
