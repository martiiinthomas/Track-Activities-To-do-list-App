//
//  FirstViewController.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/21/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit

class CatagoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    var catagoryIndexToEdit: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        SaveLoad.load()
        CatagoryFunctions.readCatagories(completion: ) { [weak self] in
            DateFunctions.deleteDateOverHundred()
            self?.tableView.reloadData()
        }
        
        view.backgroundColor = Theme.backgroundColor
        addButton.createFloatingActionButton()
        CatagoriesViewController.makeBottomSpace(tableView: tableView)
        CatagoriesViewController.navBarFont(ViewController: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddCatagorySegue" {
            let popup = segue.destination as! AddCatagoryViewController
            popup.catagoryIndexToEdit = self.catagoryIndexToEdit
            popup.doneSaving = { [weak self] in
                guard let self = self else {return}
                SaveLoad.save()
                if popup.catagoryIndexToEdit != nil {
                    self.tableView.reloadData()
                } else {
                    let row = (CataData.catagoryModels.count) - 1
                    let indexPath = IndexPath(row: row, section: 0)
                    self.tableView.insertRows(at: [indexPath], with: .automatic)
                }
                
            }
            catagoryIndexToEdit = nil
        }
    }
}

extension CatagoriesViewController: UITableViewDataSource, UITableViewDelegate {
    // Number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CataData.catagoryModels.count
    }
    
    // Populating each row with correct Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CatagoriesTableViewCell
        cell.setup(catagoryModel: CataData.catagoryModels[indexPath.row])
        return cell
    }
    
    // Setting row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    // Deleting rows
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            
            let alert = UIAlertController(title: "Delete Category", message: "Are you sure you want to delete this category?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                //Perform delete
                CatagoryFunctions.deleteCatagory(index: indexPath.row)
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
            self.catagoryIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "toAddCatagorySegue", sender: nil)
            actionPerformed(true)
        }
        edit.image = #imageLiteral(resourceName: "Edit")
        edit.backgroundColor = Theme.blueOne
        
        let setLog = UIContextualAction(style: .normal, title: "Log") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
            let vc = LogHoursViewController.getInstance() as! LogHoursViewController
            vc.catagoryModel = CataData.catagoryModels[indexPath.row]
            vc.catagoryIndex = indexPath.row
            self.present(vc, animated: true)
            actionPerformed(true)
        }
        setLog.image = #imageLiteral(resourceName: "Clock")
        setLog.backgroundColor = Theme.greenOne
        return UISwipeActionsConfiguration(actions: [setLog ,edit])
    }
    
    // Selecting row -> Activity View
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let catagory = CataData.catagoryModels[indexPath.row]
        
        let vc = ActivitiesViewController.getInstance() as! ActivitiesViewController
        vc.catagoryId = catagory.id
        vc.catagoryModel = catagory
        vc.catagoryIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
