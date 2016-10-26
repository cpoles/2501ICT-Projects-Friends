//
//  MasterViewController.swift
//  Friends
//
//  Created by Carlos Poles on 17/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, DetailViewControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var contactList = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        // Load contact list
        
        contactList = loadContactList()

    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MasterTableViewCell

        let contact = contactList[(indexPath as NSIndexPath).row]
        cell.labelFullName.text = contact.fullName
        cell.imageContact.image = UIImage(data: contact.image! as Data)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contactList.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("contact deleted.")
            saveContactList()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let contact = contactList[(indexPath as NSIndexPath).row]
                let controller = segue.destination as!  DetailViewController
                controller.detailItem = contact
                controller.delegate = self
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "addNew" {
            let contact = Contact(firstName: "", lastName: "", address: "")
            let socialMedia1 = SocialMediaAccount(identifier: "", type: "Flickr")
            let socialMedia2 = SocialMediaAccount(identifier: "", type: "WebPage")
            contact.socialMedia.append(socialMedia1)
            contact.socialMedia.append(socialMedia2)
            contactList.append(contact)
            let controller = segue.destination as! DetailViewController
            controller.detailItem = contact
            controller.delegate = self
            print("Add new contact")
        }
    }
    
    // MARK: - Data Persistence
    
    func saveContactList() {
        
        // create path from Directory for the class for the converted class into a property list to be saved.
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        
        // convert contact list array into property list format
        
        let contactListConverted = contactList.map { $0.propertyListRepresentation() }
        
        // created NSData object to write data to file
        
        let data: Data
        try! data = JSONSerialization.data(withJSONObject: contactListConverted, options: .prettyPrinted)
        
        // create the json file
        
        let jsonFile = path.appendingPathComponent("friends2016.json")
        
        //write data to file
        
        try? data.write(to: URL(fileURLWithPath: jsonFile), options: [.atomic])
        
        print("contact list saved")
        
    }
    
    func loadContactList() -> [Contact] {
        
        var loadedContactList = [Contact]()
        
        //build the contac list from the jsonFile
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        
        // look for the file and save its path in a string
        
        let jsonFile = path.appendingPathComponent("friends2016.json") as String?
        
        if let file = jsonFile {
            
            // create NSData object
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
            
            // create the array of dictionaries out of the jsonData NSData object
            
            let jsonArrayDic: [NSDictionary]
            
            if let data = jsonData {
                try! jsonArrayDic = JSONSerialization.jsonObject(with: data, options: []) as! [NSDictionary]
                
                // create the array of contact objects parsing a trailing closure to the map function of the jsonArrayDic
                // The closure will build a Contact object for each dictionary inside the jsonArrayDic
                
                let contactListLoaded = jsonArrayDic.map { Contact(propertyList: $0) }
                loadedContactList = contactListLoaded

            }
            
        }
        return loadedContactList
    }
    
    // MARK: - Delegation
    
    // MARK: - DetailViewControllerDelegate
    
    /**
     This function handles the changes ocurred in the contents of the destinationViewController, the Detail View.
     
     - parameters:
     - destinationViewController: DetailViewController
     - returns: Void
     
     */
    
    func destinationViewControllerControllerContentChanged(_ dvc: DetailViewController) {
        
        if let contact = dvc.detailItem {
            print("Got \(contact)")
            // save the friends list and write to the json file
            
            dismiss(animated: true, completion: nil)
        }
        saveContactList()
        self.tableView.reloadData()
        
    }
    
}

