//
//  ActivitiesViewController.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/30/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var catagoryId: UUID!
    var catagoryModel: CatagoryModel?
    var catagoryIndex: Int?
    
    
    fileprivate func updateTableWithActivityData() {
        CatagoryFunctions.readCatagory(by: catagoryId) { [weak self] (model) in
            guard let self = self else {return}
            guard let model = model else {return}
            self.title = model.title
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // declarations
        tableView.dataSource = self
        tableView.delegate = self
        
        // Aesthetics
        updateTableWithActivityData()
        view.backgroundColor = Theme.secondBackgroundColor
        addButton.createFloatingActionButton()
        ActivitiesViewController.makeBottomSpace(tableView: tableView)
    }
    
    @IBAction func addActivity(_ sender: UIButton) {
        let vc = AddActivityViewController.getInstance() as! AddActivityViewController
        vc.catagoryIndex = self.catagoryIndex
        vc.doneSaving = { [weak self] activityModel in
            guard let self = self else {return}
            // Update local data
            self.catagoryModel?.activityModels.append(activityModel)
            SaveLoad.save()
            
            // Insert row
            let row = (self.catagoryModel?.activityModels.count)! - 1
            let indexPath = IndexPath(row: row, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        self.present(vc, animated: true)
        
    }
    
}


extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    // Number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagoryModel!.activityModels.count
    }
    
    // Populating each row with correct Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActivityTableViewCell
        let model = catagoryModel?.activityModels[indexPath.row]
        cell.setup(model: model!)
        
        return cell
    }
    
    // Deleting rows
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            
            let alert = UIAlertController(title: "Delete Activity", message: "Are you sure you want to delete this Activity?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                //Perform delete
                ActivityFunctions.deleteActivity(catagoryIndex: self.catagoryIndex!, activityIndex: indexPath.row)
                self.catagoryModel?.activityModels.remove(at: indexPath.row)
                SaveLoad.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            }))
            
            self.present(alert, animated: true)
        }
        
        delete.image = #imageLiteral(resourceName: "Delete")
        delete.backgroundColor = Theme.tintColor
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // Editing rows
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
            let vc = AddActivityViewController.getInstance() as! AddActivityViewController
            
            // Which Catagory are we on
            vc.catagoryIndex = self.catagoryIndex
            
            // Which Activity are we editing
            vc.activityIndexToEdit = indexPath.row
            vc.activityModelToEdit = self.catagoryModel?.activityModels[indexPath.row]
            
            // Updating the row after save
            vc.doneSaving = {[weak self] activityModel in
                self?.catagoryModel?.activityModels[indexPath.row] = activityModel
                let indexPath = IndexPath(row: indexPath.row, section: 0)
                SaveLoad.save()
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            self.present(vc, animated: true)
            actionPerformed(true)
        }
        edit.image = #imageLiteral(resourceName: "Edit")
        edit.backgroundColor = Theme.blueOne
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
}
