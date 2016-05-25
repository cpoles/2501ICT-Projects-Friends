//
//  DetailViewController.swift
//  Friends
//
//  Created by Carlos Poles on 17/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

  
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

