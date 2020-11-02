//
//  UIViewControllerExtensions.swift
//  CataTracker
//
//  Created by Martin Thomas on 7/29/19.
//  Copyright © 2019 Martin Thomas. All rights reserved.
//

import UIKit


extension UIViewController{
    
    /**
     Just returns the initial view controller on a storyboard
     */
    static func getInstance() -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
    
    /**
     This is to make sure the table view can scroll further down
     */
    static func makeBottomSpace(tableView: UITableView) {
        let bottomView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 83))
        bottomView.backgroundColor = .clear
        tableView.tableFooterView = bottomView
    }
    
    /**
     This sets the font to the text on every nav bar
     */
    static func navBarFont(ViewController: UIViewController) {
        ViewController.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2588235294, green: 0.2745098039, blue: 0.2862745098, alpha: 1),
             NSAttributedString.Key.font: UIFont(name: Theme.mainFontName, size: 21)!]
    }
}
