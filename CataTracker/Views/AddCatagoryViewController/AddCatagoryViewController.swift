//
//  AddCatagoryViewController.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/22/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class AddCatagoryViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var catagoryTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var weeklyHours: UITextField!
    private var hourPicker = UIPickerView()
    let hours = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    var doneSaving: (() -> ())?
    var catagoryIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 22)
        titleLabel.textColor = Theme.Accent
        hourPicker.dataSource = self
        hourPicker.delegate = self
        weeklyHours.inputView = hourPicker
        
        if let index = catagoryIndexToEdit{
            let catagory = CataData.catagoryModels[index]
            catagoryTextField.text = catagory.title
            titleLabel.text = "Edit Category"
            if let hour = catagory.targetHours {
                weeklyHours.text = String(describing: hour)
            } else {
                weeklyHours.text = "0"
            }
            saveButton.setTitle("Update", for: .normal)
        }
        
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        self.view.endEditing(true)
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        // Check to see if text field is blank before continuing
        guard catagoryTextField.text != "", let newCatagoryName = catagoryTextField.text else {
            catagoryTextField.layer.borderColor = UIColor.red.cgColor
            catagoryTextField.layer.borderWidth = 2
            catagoryTextField.layer.cornerRadius = 5
            catagoryTextField.placeholder = "Catagory name required"
            catagoryTextField.rightViewMode = .always
            
            
            return
        }
        
        // Update Category
        if let index = catagoryIndexToEdit {
            let hour = Int(weeklyHours.text!)
            CatagoryFunctions.updateCatagory(at: index, title: newCatagoryName, hour: hour ?? 0)
        }
            // Create Category
        else {
            let hour = Int(weeklyHours.text!)
            CatagoryFunctions.createCatagory(catagoryModel: CatagoryModel(title: newCatagoryName, targetHours: hour ?? 0))
        }
        if let doneSaving = doneSaving {
            doneSaving()
        }
        self.view.endEditing(true)
        dismiss(animated: true)
    }
}

extension AddCatagoryViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: hours[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weeklyHours.text = String(describing: hours[row])
    }
    
}
