//
//  SecondViewController.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/21/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit
import Charts
import Photos

class ReportViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var sortBy: UITextField!
    
    // Selecting a sort by option
    var updateStatus = "Today"
    let todayStatus = "Today"
    let pastWeekStatus = "PastWeek"
    let pastMonthStatus = "PastMonth"
    let betweenDatesStatus = "BetweenDates"
    let statusOptions = ["Today", "PastWeek", "PastMonth", "BetweenDates"]
    private var statusPicker = UIPickerView()
    
    // Holding data of hors and selected time periods
    var hourSum = 0
    var startDate: Date?
    var endDate: Date?
    
    // Pie Chart Entries
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.backgroundColor
        cardView.addShadowAndRoundedCorners()
        statusPicker.dataSource = self
        statusPicker.delegate = self
        sortBy.inputView = statusPicker
        
        
        updateEntries(status: updateStatus)
        updateChartData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if statusLabel.text == todayStatus || statusLabel.text == pastWeekStatus || statusLabel.text == pastMonthStatus {
            statusLabel.text = updateStatus
            updateEntries(status: updateStatus)
        }
        updateChartData()
    }
    
    // Saving to Gallery
    fileprivate func savingPhoto() {
        UIImageWriteToSavedPhotosAlbum(self.pieChart.getChartImage(transparent: false)!, nil, nil, nil)
        let alert = UIAlertController(title: "Reports Saved", message: "Report was successfully saved to Gallery", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    // Checking Authorization before saving to Gallery
    @IBAction func saveToGallery(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .notDetermined:
                if status == PHAuthorizationStatus.authorized{
                    self.savingPhoto()
                }
            case .restricted:
                let alert = UIAlertController(title: "Photo Library Restricted", message: "Photo Library access is restricted and cannot be accessed.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default )
                alert.addAction(okAction)
                self.present(alert, animated: true)
            case .denied:
                let alert = UIAlertController(title: "Photo Library Access Denied ", message: "Photo Library access was previously denied. Please update your Settings if you wish to change this.", preferredStyle: .alert)
                let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (action) in
                    DispatchQueue.main.async {
                        let url = URL(string: UIApplication.openSettingsURLString)!
                        UIApplication.shared.open(url, options: [:])
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
                alert.addAction(goToSettingsAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            case .authorized:
                self.savingPhoto()
                
            @unknown default:
                print("Apple has added more settings to PHAuthorizationStatus")
            }
        }
        
    }
    
    
    
    // Adding data into Chart Data
    func updateEntries(status: String) {
        numberOfDownloadsDataEntries = []
        pieChart.highlightValues([])
        switch status {
        case todayStatus:
            for i in CataData.catagoryModels {
                for j in i.dateModels {
                    if j.day.mediumDate() == Date().mediumDate() && j.hours > 0 {
                        let entry = PieChartDataEntry(value: Double(j.hours))
                        entry.label = i.title
                        numberOfDownloadsDataEntries.append(entry)
                    }
                }
            }
            
        case pastWeekStatus:
            for i in CataData.catagoryModels {
                for j in i.dateModels {
                    if j.day.isBetween(startDate: Date().add(days: -7), endDate: Date()) && j.hours > 0 {
                        hourSum = hourSum + j.hours
                    }
                }
                if hourSum > 0 {
                    let entry = PieChartDataEntry(value: Double(hourSum))
                    entry.label = i.title
                    numberOfDownloadsDataEntries.append(entry)
                    hourSum = 0
                }
            }
            
        case pastMonthStatus:
            for i in CataData.catagoryModels {
                for j in i.dateModels {
                    if j.day.isBetween(startDate: Date().add(days: -31), endDate: Date()) && j.hours > 0 {
                        hourSum = hourSum + j.hours
                    }
                }
                if hourSum > 0 {
                    let entry = PieChartDataEntry(value: Double(hourSum))
                    entry.label = i.title
                    numberOfDownloadsDataEntries.append(entry)
                    hourSum = 0
                }
            }
            
        case betweenDatesStatus:
            let vc = TimePeriodSelectorViewController.getInstance() as! TimePeriodSelectorViewController
            vc.doneSaving = { [weak self] firstDate, secondDate in
                guard let self = self else {return}
                self.statusLabel.text = "\(String(firstDate.mediumDate())) - \(String(secondDate.mediumDate()))"
                self.startDate = firstDate
                self.endDate = secondDate
                for i in CataData.catagoryModels {
                    for j in i.dateModels {
                        if j.day.isBetween(startDate: self.startDate!, endDate: self.endDate!) && j.hours > 0 {
                            self.hourSum = self.hourSum + j.hours
                        }
                    }
                    if self.hourSum > 0 {
                        let entry = PieChartDataEntry(value: Double(self.hourSum))
                        entry.label = i.title
                        self.numberOfDownloadsDataEntries.append(entry)
                        self.hourSum = 0
                    }
                }
                DispatchQueue.main.async {
                    self.updateChartData()
                }
            }
            self.present(vc, animated: true)
            
        default:
            for i in CataData.catagoryModels {
                for j in i.dateModels {
                    if j.day.mediumDate() == Date().mediumDate() && j.hours > 0 {
                        let entry = PieChartDataEntry(value: Double(j.hours))
                        entry.label = i.title
                        numberOfDownloadsDataEntries.append(entry)
                    }
                }
            }
        }
    }
    
    // Displaying Chart Data
    func updateChartData() {
        
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = PieChartColors.colors()
        chartData.setValueTextColor(.black)
        
        pieChart.data = chartData
        pieChart.animate(xAxisDuration: 1, easingOption: .easeOutBack)
    }
    
}


extension ReportViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: statusOptions[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusLabel.text = String(describing: statusOptions[row])
        updateStatus = String(describing: statusOptions[row])
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.view.endEditing(true)
            self.updateEntries(status: self.updateStatus)
            self.updateChartData()
        })
    }
    
}
