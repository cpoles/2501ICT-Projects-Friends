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
        
        let contact1 = Contact(firstName: "Lisa", lastName: "Simpson", address: "Brazil")
        let contact1Flicker = SocialMediaAccount(identifier: "hhduhd", type: .Flickr)
        let contact1WebPage = SocialMediaAccount(identifier: "webapage nothing", type: .WebPage)
        
        contact1.imageURL = "http://www.simpsoncrazy.com/content/pictures/lisa/LisaSimpson10.gif"
        contact1.socialMedia.append(contact1Flicker)
        contact1.socialMedia.append(contact1WebPage)
        
        
        let contact2 = Contact(firstName: "Homer", lastName: "Simpson", address: "Argentina")
        contact2.imageURL = "http://www.simpsoncrazy.com/content/pictures/homer/homer-doh.png"
        let contact3 = Contact(firstName: "Bart", lastName: "Simpson", address: "Uruguay")
        contact3.imageURL = "http://www.simpsoncrazy.com/content/pictures/bart/BartSimpson13.gif"
        
        contactList.append(contact1)
        contactList.append(contact2)
        contactList.append(contact3)


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

        let contact = contactList[indexPath.row] as! Contact
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
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let contact = contactList[indexPath.row] as! Contact
                let controller = segue.destinationViewController as!  DetailViewController
                controller.detailItem = contact
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "addNew" {
            let contact = Contact(firstName: "", lastName: "", address: "")
            let socialMedia1 = SocialMediaAccount(identifier: "", type: .Flickr)
            let socialMedia2 = SocialMediaAccount(identifier: "", type: .WebPage)
            contact.socialMedia.append(socialMedia1)
            contact.socialMedia.append(socialMedia2)
            let controller = segue.destinationViewController as! DetailViewController
            controller.detailItem = contact
            // controller.delegate =
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
        
    }
    
    // MARK: - Delegation
    
    // MARK: - DetailViewControllerDelegate
    
    func destinationViewControllerControllerContentChanged(dvc: DetailViewController) {
        
        if let contact = dvc.detailItem {
            print("Got \(contact)")
            
            // save the photo collection and write to the json file
            saveContactList()
            
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        tableView.reloadData()
        
    }
    
}

