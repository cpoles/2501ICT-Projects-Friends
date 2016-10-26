//
//  WebViewController.swift
//  Friends
//
//  Created by Carlos Poles on 30/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtWebAddress: UITextField!
   
    @IBOutlet weak var webView: UIWebView!
    
    var webAddress: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // set this viewController as delegate of the textfield
        txtWebAddress.delegate = self
        txtWebAddress.text = webAddress
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let validation = validateURLByString(txtWebAddress.text)
        if validation {
            let url = URL(string: txtWebAddress.text!)
            let request = URLRequest(url: url!)
            
            // load the page in the webView
            webView.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - Delegation
    // UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if !checkEmptynessFor(txtWebAddress) {
            // if not empty, check the string for a valid URL
            let validation = validateURLByString(txtWebAddress.text)
            if validation {
                let url = URL(string: txtWebAddress.text!)
                let request = URLRequest(url: url!)
                
                // load the page in the webView
                webView.loadRequest(request)
            } else {
                // display an alert asking for a valid URL.
                
                let alert = UIAlertController.init(title: "Invalid URL", message: "Enter a valid URL.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        
        txtWebAddress.resignFirstResponder()
        return true
        
    }
    
    // MARK - Methods
    
    /**
     This method checks whether a text field is empty and shows a message if the string is empty.
     - parameters:
     - (textField UITextField)
     - returns: Bool
     */
    func checkEmptynessFor(_ textField: UITextField) -> Bool {
        
        if let text = textField.text {
            if text.isEmpty {
                let alert = UIAlertController.init(title: "URL Field Empty", message: "Please Enter a URL.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                return true
            }
        }
        return false
    }
    
    /**
     This method checks if an URL is valid. You can use this method to check whether or not the string in the textField is valid or not.
     - parameters:
     - (string String)
     - returns: Bool
     */
    
    func validateURLByString(_ string: String?) -> Bool {
        
        if let urlString = string {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }

   
}
