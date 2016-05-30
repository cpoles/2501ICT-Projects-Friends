//
//  FlickrCollectionViewController.swift
//  Friends
//
//  Created by Carlos Poles on 30/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit


class FlickrCollectionViewController: UICollectionViewController {
    


    
    var photoCollection = [FlickrPhoto]()

    override func viewDidLoad() {
        FlickrAPIKey = "dc7f9d5d95a8e7dc3209a35d0fa24e20"
        super.viewDidLoad()
        
        let user = "strictfunctor"
        guard let photos = photosForUser(user)
             else {
                print("Could not download photo for \(user)")
                return
        }
        photoCollection = photos
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
