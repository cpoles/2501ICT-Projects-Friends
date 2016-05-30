//
//  FlickrCollectionViewController.swift
//  Friends
//
//  Created by Carlos Poles on 30/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit


class FlickrCollectionViewController: UICollectionViewController, FullPhotoViewControllerDelegate {
    

    var photoCollection = [FlickrPhoto]()
    var currentIndexPath = NSIndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPhotoInBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFullPhoto" {
            let destinationViewController = segue.destinationViewController as! FullPhotoViewController
            let indexPaths = self.collectionView?.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            currentIndexPath = indexPath
            destinationViewController.photo  = photoCollection[indexPath.row]
            destinationViewController.delegate = self
            print("Show Detail")
        }
    }
 
    // MARK: UICollectionViewDataSource


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.photoCollection.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
    
        // Configure the cell
        let picture = photoCollection[indexPath.row]
        let photoURLString = urlString(picture, format: .Small)
        let url = NSURL(string: photoURLString!)
        let photoData = NSData(contentsOfURL: url!)
        if let image = UIImage(data: photoData!) {
            cell.imageCell.image = image
        }
        return cell
    }
    
    // MARK: - Methods
    
    /**
     This function allows control back to the user, while downloading the photos on the background.
     
     parameters: (_:Photo)
     - returns: - Void
     
     
     */
    
    func loadPhotoInBackground() {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        
        // closure to be run in the background on the secondary queue
        let backgroundDownload = {
                FlickrAPIKey = "dc7f9d5d95a8e7dc3209a35d0fa24e20"
                let user = "strictfunctor"
                guard let photos = photosForUser(user)
                    else {
                        print("Could not download photo for \(user)")
                        return
                    }
                let mainQueue = dispatch_get_main_queue()
                // dispatch items assincronously.
                dispatch_async(mainQueue) {
                     self.photoCollection = photos
                    self.collectionView?.reloadData()
                }
            }
            dispatch_async(queue, backgroundDownload)
    }


    // MARK: - FullPhotoViewControllerDelegate
    
    func nextItemFor(viewController: FullPhotoViewController) {
        
        let row = currentIndexPath.row
        let nextRow: Int
        if row == photoCollection.count - 1 { nextRow = 0 }
        else { nextRow = row + 1 }
        let indexPath = NSIndexPath(forRow: nextRow, inSection: currentIndexPath.section)
        currentIndexPath = indexPath
        viewController.photo = photoCollection[nextRow]
        
    }
    
    func previousItemFor(viewController: FullPhotoViewController) {
        let row = currentIndexPath.row
        let previousRow: Int
        if row == 0 { previousRow = photoCollection.count - 1 }
        else { previousRow = row - 1 }
        let indexPath = NSIndexPath(forRow: previousRow, inSection: currentIndexPath.section)
        currentIndexPath = indexPath
        viewController.photo = photoCollection[previousRow]
    }

}
