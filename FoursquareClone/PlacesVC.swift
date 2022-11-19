//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Ali serkan Boyracı  on 1.11.2022.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var placeNameArray = [String]() // to take only name and Id from parse
    var placeIdArray = [String]()
    var selectedPlaceId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to add right top button.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        // to add left top custom button
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonclicked))
        
        // to set tableviewdelegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromParse()
        
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                if objects != nil {
                    
                    self.placeNameArray.removeAll(keepingCapacity: false) // to away duplications
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String  { //to give us from parse
                            if let placeId = object.objectId  {
                                self.placeNameArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                        
                    }
                    
                    self.tableView.reloadData() // to reload
                    
                }
                
                
                
            }
        }
        
        
    }
    
    @objc func addButtonClicked() {
        
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        //Segue
    }
    
    @objc func logoutButtonclicked() {
        
        PFUser.logOutInBackground { (error) in // to logout from parse, we do it with completion block, beacuse if we have error, we can see the error message.
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else { // if we have not any error, means that we logout from parse. And we want to go back
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
                
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //before segue what will we do.
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC // first we have to save detailsVC as destination
            destinationVC.chosenPlaceId = selectedPlaceId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //after tapping row at tableview, what will we do.
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    
    
    // to set tableviewdelegate and data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = placeNameArray[indexPath.row]
        cell.contentConfiguration  = content
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func makeAlert(titleInput: String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }


}
