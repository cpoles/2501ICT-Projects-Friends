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
    func nextItemFor(viewController: FullPhotoViewController)
    func previousItemFor(viewController: FullPhotoViewController)
}

class FullPhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
