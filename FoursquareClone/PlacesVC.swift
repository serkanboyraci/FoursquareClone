//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 1.11.2022.
//

import UIKit

class PlacesVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked() {
        //Segue
    }
    

}
