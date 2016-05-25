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
    
    @IBOutlet weak var txtWebPage: UITableViewCell!
    
    @IBOutlet weak var textImageURL: UITextField!
    
    @IBOutlet weak var imageContactPhoto: UIImageView!
    

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem as! Contact? {
            txtFirstName.text = detail.firstName
            txtLastName.text = detail.lastName
            txtAddress.text = detail.address
            txtSocialMedia.text = detail.socialMedia[0].identifier
            txtSocialMedia.text = detail.socialMedia[1].identifier
            if let imageURL = detail.imageURL {
                textImageURL.text = imageURL
                imageContactPhoto.image = UIImage(data: detail.image!)
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

