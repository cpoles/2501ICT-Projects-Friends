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
    var currentIndexPath = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPhotoInBackground()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFullPhoto" {
            let destinationViewController = segue.destination as! FullPhotoViewController
            let indexPaths = self.collectionView?.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as IndexPath
            currentIndexPath = indexPath
            destinationViewController.photo  = photoCollection[(indexPath as NSIndexPath).row]
            destinationViewController.delegate = self
            print("Show Detail")
        }
    }
 
    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.photoCollection.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
    
        // Configure the cell
        let picture = photoCollection[(indexPath as NSIndexPath).row]
        let photoURLString = urlString(picture, format: .Small)
        let url = URL(string: photoURLString!)
        let photoData = try? Data(contentsOf: url!)
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
        let queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.low)
        
        // closure to be run in the background on the secondary queue
        let backgroundDownload = {
                FlickrAPIKey = "dc7f9d5d95a8e7dc3209a35d0fa24e20"
                let user = "strictfunctor"
                guard let photos = photosForUser(user)
                    else {
                        print("Could not download photo for \(user)")
                        return
                    }
                let mainQueue = DispatchQueue.main
                // dispatch items assincronously.
                mainQueue.async {
                     self.photoCollection = photos
                    self.collectionView?.reloadData()
                }
            }
            queue.async(execute: backgroundDownload)
    }


    // MARK: - FullPhotoViewControllerDelegate
    
    func nextItemFor(_ viewController: FullPhotoViewController) {
        
        let row = (currentIndexPath as NSIndexPath).row
        let nextRow: Int
        if row == photoCollection.count - 1 { nextRow = 0 }
        else { nextRow = row + 1 }
        let indexPath = IndexPath(row: nextRow, section: (currentIndexPath as NSIndexPath).section)
        currentIndexPath = indexPath
        viewController.photo = photoCollection[nextRow]
        
    }
    
    func previousItemFor(_ viewController: FullPhotoViewController) {
        let row = (currentIndexPath as NSIndexPath).row
        let previousRow: Int
        if row == 0 { previousRow = photoCollection.count - 1 }
        else { previousRow = row - 1 }
        let indexPath = IndexPath(row: previousRow, section: (currentIndexPath as NSIndexPath).section)
        currentIndexPath = indexPath
        viewController.photo = photoCollection[previousRow]
    }

}
