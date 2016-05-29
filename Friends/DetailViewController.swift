//
//  DetailViewController.swift
//  Friends
//
//  Created by Carlos Poles on 17/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit


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
    
    var delegate: DetailViewControllerDelegate?
    
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
        
        if let firstName = txtFirstName.text,
            let lastName = txtLastName.text,
            let address = txtAddress.text {
                let contact = Contact(firstName: firstName, lastName: lastName, address: address)
                if let imageURL = textImageURL.text {
                    contact.imageURL = imageURL
                  if let socialMedia = txtSocialMedia.text {
                    let flicker = SocialMediaAccount(identifier: socialMedia, type: .Flickr)
                    contact.socialMedia.append(flicker)
                        if let webPage = textWebPage.text {
                            let web = SocialMediaAccount(identifier: webPage, type: .WebPage)
                            contact.socialMedia.append(web)
                            self.detailItem = contact
                            delegate?.destinationViewControllerControllerContentChanged(self)
                    }
                }
            }
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        
        if let detail = self.detailItem as! Contact? {
            let contact = detail
            
            if let firstName = self.txtFirstName, let lastName = self.txtLastName, let address = self.txtAddress, let socialMedia = self.txtSocialMedia, let webPage = self.textWebPage, let imageURLText = self.textImageURL, let lblSocialMedia = self.labelSocialMedia
            {
                firstName.text = contact.firstName
                lastName.text = contact.lastName
                address.text = contact.address
                socialMedia.text = contact.socialMedia[0].identifier
                lblSocialMedia.text = contact.socialMedia[0].type.returnString() as String
                webPage.text = contact.socialMedia[1].identifier
                if let imageURL = contact.imageURL {
                    imageURLText.text = imageURL
                    imageContactPhoto.image = UIImage(data: contact.image!)
                }
                
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


}

