//
//  LogHoursViewController.swift
//  CataTrack
//
//  Created by Martin Thomas on 8/13/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class LogHoursViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var hoursTextField: UITextField!
    
    // Picker View
    private var hourPicker = UIPickerView()
    let hours = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    var catagoryIndex: Int!
    var catagoryModel: CatagoryModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hourPicker.dataSource = self
        hourPicker.delegate = self
        hoursTextField.inputView = hourPicker
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        // Check to see if text field is blank before continuing
        guard hoursTextField.text != "", let newHour = hoursTextField.text else {
            hoursTextField.layer.borderColor = UIColor.red.cgColor
            hoursTextField.layer.borderWidth = 2
            hoursTextField.layer.cornerRadius = 5
            hoursTextField.rightViewMode = .always
            return
        }
        
        // Update a Log
        if alreadyExists(datePicker.date){
            let dayIndex = findDayIndex(datePicker.date)
            let newHours = Int(newHour)
            DateFunctions.updateDate(catagoryIndex: catagoryIndex, dateIndex: dayIndex, newHours: newHours!)
            print("Updated existing date model \(datePicker.date) and \(newHours!)")
        }
            // Create a Log
        else {
            let newHours = Int(newHour)
            DateFunctions.createDate(catagoryIndex: catagoryIndex, using: DateModel(day: datePicker.date, hours: newHours!))
            print("Created new date model \(datePicker.date) and \(newHours!)")
        }
        
        SaveLoad.save()
        dismiss(animated: true)
    }
    
    // Check to see if a log already exists
    func alreadyExists(_ date: Date) -> Bool {
        if catagoryModel.dateModels.contains(where: { $0.day.mediumDate() == date.mediumDate()}){
            return true
        }
        return false
    }
    
    // Return index of existing log (Must declare alreadyExists before this)
    func findDayIndex(_ date: Date) -> Int {
        for (index, i) in catagoryModel!.dateModels.enumerated() {
            if i.day.mediumDate() == date.mediumDate() {
                return index
            }
        }
        return 0
    }
}

extension LogHoursViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        hoursTextField.text = String(describing: hours[row])
    }
    
}

