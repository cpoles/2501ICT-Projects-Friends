//
//  FullPhotoViewController.swift
//  Friends
//
//  Created by Carlos Poles on 31/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

/**
 This protocol allows for the delegate to move through the photoCollection displayed in the FullPhotoView
 */

protocol FullPhotoViewControllerDelegate {
    func nextItemFor(_ viewController: FullPhotoViewController)
    func previousItemFor(_ viewController: FullPhotoViewController)
}

class FullPhotoViewController: UIViewController {
    
    
    @IBOutlet weak var imageFullPhoto: UIImageView!
    
    // MARK - Properties
    
    var delegate: FullPhotoViewControllerDelegate?
    
    var photo: FlickrPhoto?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     The configureView() function retrieves the detailItem sent by the sourceViewController, casts it down to a Photo object, checks for the imageData and sets the image property of the UIImageView to display the corresponding photo.
     
     */
    
    func configureView() {
        if let photoItem = self.photo {
            
            let photoURLString = urlString(photoItem, format: .Small)
            if let url = URL(string: photoURLString!) {
                if let photoData = try? Data(contentsOf: url) {
                    if let image = UIImage(data: photoData) {
                        imageFullPhoto.image = image
                    }
                }
                self.title = photoItem.title
            }
            print("Photo is not nil")
        } else {
            print("photo is nil")
        }
    }
    
    
    // MARK: - Actions
    
    /**
     swipeRight action calls the delegate to execute the move to the previous item of the photoCollection
     - parameters:
     - (sender: UISwipeGestureRecognizer)
     
     */

    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        delegate?.previousItemFor(self)
    }
   
    
    /**
     swipeLeft action calls the delegate to execute the move to the next item of the photoCollection
     - parameters:
     - (sender: UISwipeGestureRecognizer)
     
     */
  
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        delegate?.nextItemFor(self)
    }
    
    
    
}
