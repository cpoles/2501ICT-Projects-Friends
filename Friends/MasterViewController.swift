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
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        // Load contact list
        
        contactList = loadContactList()!

    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MasterTableViewCell

        let contact = contactList[indexPath.row]
        cell.labelFullName.text = contact.fullName
        cell.imageContact.image = UIImage(data: contact.image!)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            contactList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            print("contact deleted.")
            saveContactList()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let contact = contactList[indexPath.row]
                let controller = segue.destinationViewController as!  DetailViewController
                controller.detailItem = contact
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "addNew" {
            let contact = Contact(firstName: "", lastName: "", address: "")
            let socialMedia1 = SocialMediaAccount(identifier: "", type: "Flickr")
            let socialMedia2 = SocialMediaAccount(identifier: "", type: "WebPage")
            contact.socialMedia.append(socialMedia1)
            contact.socialMedia.append(socialMedia2)
            let controller = segue.destinationViewController as! DetailViewController
            controller.detailItem = contact
            controller.delegate = self
            print("Add new contact")
        }
    }
    
    // MARK: - Data Persistence
    
    func saveContactList() {
        
        // create path from Directory for the class for the converted class into a property list to be saved.
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
        
        // convert contact list array into property list format
        
        let contactListConverted = contactList.map { $0.propertyListRepresentation() }
        
        // created NSData object to write data to file
        
        let data: NSData
        try! data = NSJSONSerialization.dataWithJSONObject(contactListConverted, options: .PrettyPrinted)
        
        // create the json file
        
        let jsonFile = path.stringByAppendingPathComponent("friends.json")
        
        //write data to file
        
        data.writeToFile(jsonFile, atomically: true)
        
        print("contact list saved")
        
    }
    
    func loadContactList() -> [Contact]? {
        
        var loadedContactList = [Contact]()
        
        //build the contac list from the jsonFile
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
        
        // look for the file and save its path in a string
        
        let jsonFile = path.stringByAppendingPathComponent("friends.json") as String?
        
        if let file = jsonFile {
            
            // create NSData object
            let jsonData = NSData(contentsOfFile: file)
            
            // create the array of dictionaries out of the jsonData NSData object
            
            let jsonArrayDic: [NSDictionary]
            
            if let data = jsonData {
                try! jsonArrayDic = NSJSONSerialization.JSONObjectWithData(data, options: []) as! [NSDictionary]
                
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
    
    func destinationViewControllerControllerContentChanged(dvc: DetailViewController) {
        
        if let contact = dvc.detailItem {
            print("Got \(contact)")
            
            contactList.append(contact as! Contact)
            // save the photo collection and write to the json file
            saveContactList()
            
        }
        dismissViewControllerAnimated(true, completion: nil)
        tableView.reloadData()
        
    }
    
}

