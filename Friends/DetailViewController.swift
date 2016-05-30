//
//  DetailViewController.swift
//  Friends
//
//  Created by Carlos Poles on 17/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit
import MapKit


/**
 This protocol allows for the delegate to update and edit the details of the contact
 */

protocol DetailViewControllerDelegate {
    func destinationViewControllerControllerContentChanged(dvc: DetailViewController)
}

class DetailViewController: UITableViewController, UITextFieldDelegate {

    // MARK: Properties
    
    @IBOutlet weak var txtFirstName: UITextField!

    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var txtSocialMedia: UITextField!
    
    @IBOutlet weak var textWebPage: UITextField!
    
    @IBOutlet weak var labelSocialMedia: UILabel!
    
    
    @IBOutlet weak var textImageURL: UITextField!
    
    @IBOutlet weak var imageContactPhoto: UIImageView!
    
    @IBOutlet weak var labelWebPage: UILabel!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    var contact: Contact?
    
    var delegate: DetailViewControllerDelegate?
    
    override func viewWillAppear(animated: Bool) {
//      let nc = NSNotificationCenter.defaultCenter()
//        nc.addObserver(self, selector: #selector(DetailViewController.aboutToResign), name: Resign, object: nil)
//        
//        contact = self.detailItem as? Contact
//        
//        contact?.addObserver(self, forKeyPath: "firstName", options: .New, context: nil)
//        contact?.addObserver(self, forKeyPath: "lastName", options: .New, context: nil)
//        contact?.addObserver(self, forKeyPath: "address", options: .New, context: nil)
//        contact?.addObserver(self, forKeyPath: "imageURL", options: .New, context: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textImageURL.delegate = self
        textWebPage.delegate = self
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtAddress.delegate = self
        txtSocialMedia.delegate = self 
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        contact?.firstName = txtFirstName.text!
        contact?.lastName = txtLastName.text!
        contact?.address = txtAddress.text!
        contact?.socialMedia[0].identifier = txtSocialMedia.text!
        contact?.socialMedia[1].identifier = textWebPage.text!
        contact?.imageURL = textImageURL.text!
        self.detailItem = contact
        delegate?.destinationViewControllerControllerContentChanged(self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            let controller = segue.destinationViewController as! MapViewController
            controller.locationString = txtAddress.text
        } else if segue.identifier == "showWebPage" {
            let controller = segue.destinationViewController as! WebViewController
            controller.webAddress = textWebPage.text
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.

            contact = self.detailItem as! Contact?
            
            if let firstName = self.txtFirstName, let lastName = self.txtLastName, let address = self.txtAddress, let socialMedia = self.txtSocialMedia, let webPage = self.textWebPage, let imageURLText = self.textImageURL, let lblSocialMedia = self.labelSocialMedia
            {
                firstName.text = contact!.firstName
                lastName.text = contact!.lastName
                address.text = contact!.address
                socialMedia.text = contact!.socialMedia[0].identifier
                lblSocialMedia.text = contact!.socialMedia[0].type
                webPage.text = contact!.socialMedia[1].identifier
                if let imageURL = contact!.imageURL {
                    imageURLText.text = imageURL
                    imageContactPhoto.image = UIImage(data: contact!.image!)
                }
                
            }
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        
        textWebPage.resignFirstResponder()
        textImageURL.resignFirstResponder()
        txtSocialMedia.resignFirstResponder()
        txtAddress.resignFirstResponder()
        txtLastName.resignFirstResponder()
        txtFirstName.resignFirstResponder()
        return true
    }

    
    
    // MARK: - Methods
    
    
    
    
//    func aboutToResign() {
//        print("About to Resign")
//    }
//    
//    func firstNameChanged() {
//        print("First Name has been changed to \(contact?.firstName)")
//    }
//    
//    func lastNameChanged() {
//        print("Last Name has been changed to \(contact?.lastName)")
//    }
//    
//    func imageURLChanged() {
//        print("Image URL has been changed to \(contact?.imageURL)")
//    }
//    
//    func addressChanged() {
//        print("Address has been changed to \(contact?.address)")
//    }
   
    
    
    
     // MARK: - KVO
    
//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        
//        guard keyPath == "firstName" else {
//            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
//            return
//        }
//        print(change!)
//        firstNameChanged()
//        
//        guard keyPath == "lastName" else {
//            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
//            return
//        }
//        print(change!)
//        lastNameChanged()
//        
//        guard keyPath == "address" else {
//            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
//            return
//        }
//        print(change!)
//        addressChanged()
//        
//        guard keyPath == "imageURL" else {
//            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
//            return
//        }
//        print(change!)
//        imageURLChanged()
//        
//    }

}

