//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 1.11.2022.
//

import UIKit
import Parse

class PlacesVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to add right top button.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        // to add left top custom button
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonclicked))
    }
    
    @objc func addButtonClicked() {
        //Segue
    }
    
    @objc func logoutButtonclicked() {
        
        PFUser.logOutInBackground { (error) in // to logout from parse, we do it with completion block, beacuse if we have error, we can see the error message.
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else { // if we have not any error, means that we logout from parse. And we want to go back
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
                
            }
        }
        
    }
    

}
