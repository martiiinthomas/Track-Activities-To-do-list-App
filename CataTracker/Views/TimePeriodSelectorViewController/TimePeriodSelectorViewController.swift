//
//  TimePeriodSelectorViewController.swift
//  CataTrack
//
//  Created by Martin Thomas on 8/14/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class TimePeriodSelectorViewController: UIViewController {
    
    private var firstDatePicker: UIDatePicker?
    private var secondDatePicker: UIDatePicker?
    @IBOutlet weak var firstDateTextField: UITextField!
    @IBOutlet weak var secondDateTextField: UITextField!
    
    // Data to pass back
    var startDate: Date?
    var endDate: Date?
    var doneSaving: ((Date, Date) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configuring Date Pickers
        firstDatePicker = UIDatePicker()
        secondDatePicker = UIDatePicker()
        firstDatePicker?.datePickerMode = .date
        secondDatePicker?.datePickerMode = .date
        firstDatePicker?.addTarget(self, action: #selector(TimePeriodSelectorViewController.firstDateChanged(datePicker:)), for: .valueChanged)
        secondDatePicker?.addTarget(self, action: #selector(TimePeriodSelectorViewController.secondDateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TimePeriodSelectorViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        firstDateTextField.inputView = firstDatePicker
        secondDateTextField.inputView = secondDatePicker
    }
    
    
    @objc func firstDateChanged(datePicker: UIDatePicker) {
        firstDateTextField.text = datePicker.date.mediumDate()
        startDate = datePicker.date
        view.endEditing(true)
    }
    
    @objc func secondDateChanged(datePicker: UIDatePicker) {
        secondDateTextField.text = datePicker.date.mediumDate()
        endDate = datePicker.date
        view.endEditing(true)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard firstDateTextField.text != "", let firstDate = startDate else {
            firstDateTextField.layer.borderColor = UIColor.red.cgColor
            firstDateTextField.layer.borderWidth = 2
            firstDateTextField.layer.cornerRadius = 5
            firstDateTextField.rightViewMode = .always
            return
        }
        
        guard secondDateTextField.text != "", let secondDate = endDate else {
            secondDateTextField.layer.borderColor = UIColor.red.cgColor
            secondDateTextField.layer.borderWidth = 2
            secondDateTextField.layer.cornerRadius = 5
            secondDateTextField.rightViewMode = .always
            return
        }
        
        if let doneSaving = doneSaving {
            doneSaving(firstDate, secondDate)
        }
        dismiss(animated: true)
        
    }
    
}
