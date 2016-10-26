//
//  Contact.swift
//  Friends
//
//  Created by Carlos Poles on 17/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import Foundation

/**
 
 PropertyListable protocol requires the adoption of the propertyListRepresentation function.
 
 ### Required Functions
 func propertyListRepresentation() -> NSDictionary
 
 */

protocol PropertyListable {
    func propertyListRepresentation() -> NSDictionary
}


class Contact : NSObject {
    
    // MARK: - Properties
    
   dynamic var address: String
   dynamic var firstName: String
   dynamic var imageURL: String?
   dynamic var lastName: String
    
   dynamic var image: Data? {
        
        if let imageAddress = imageURL {
            return (try! Data(contentsOf: URL(string: imageAddress)!))
        } else {
            return nil
        }
    }
    
   dynamic var fullName: String {
        
        return firstName + " " + lastName
    }
    
    var socialMedia = [SocialMediaAccount]()
    
    // MARK: - Initialisation
    
    init(firstName: String, lastName: String, address: String) {
        self.address = address
        self.firstName = firstName
        self.lastName = lastName
    }
}

/**
 The PropertyKey Struct holds the keys that will be used on the
 Dictionary returned by propertyListRepresentation().
 The struct properties are downcasted to NSSTring to
 conform to isValidJSon so that the Dictionary is
 serializable to json format.
 
 */

struct PropertyKey {
    
    static let firstNameKey = "firstName" as NSString
    static let lastNameKey = "lastName" as NSString
    static let addressKey = "address" as NSString
    static let socialMediaKey = "socialMedia" as NSString
    static let imageURLKey = "imageURL" as NSString
    
}


extension Contact : PropertyListable {
    
    // MARK: - Methods
    
    /**
     - parameters:
     - none
     - The propertyListRepresentation function converts the photo object to NSDictionary format so that the Photo object can be represented as a JSON object and written to a json file.
     - returns: NSDictionary
     */
    
    func propertyListRepresentation() -> NSDictionary {
        
        let socialMediaConverted = socialMedia.map { $0.propertyListRepresentation() }
        var propertyList = NSDictionary()
        
        if let imageAddress = imageURL {
            propertyList = [
                PropertyKey.firstNameKey : firstName,
                PropertyKey.lastNameKey : lastName,
                PropertyKey.addressKey : address,
                PropertyKey.socialMediaKey : socialMediaConverted,
                PropertyKey.imageURLKey : imageAddress
            ]
        } else {
            propertyList = [
                PropertyKey.firstNameKey : firstName,
                PropertyKey.lastNameKey : lastName,
                PropertyKey.addressKey : address,
                PropertyKey.socialMediaKey : socialMediaConverted
            ]
        }
        return propertyList
    }
    
    
    // MARK - Initialisation
    
    convenience init(propertyList: NSDictionary) {
        let firstName = (propertyList.object(forKey: PropertyKey.firstNameKey) as! String)
        let lastName = (propertyList.object(forKey: PropertyKey.lastNameKey) as! String)
        let address = (propertyList.object(forKey: PropertyKey.addressKey) as! String)
        let imageURL = (propertyList.object(forKey: PropertyKey.imageURLKey) as! String?)
        let socialMedia = (propertyList.object(forKey: PropertyKey.socialMediaKey) as! [NSDictionary])
        let socialArray = socialMedia.map { SocialMediaAccount(propertyList: $0) }
        self.init(firstName: firstName, lastName: lastName, address: address)
        if let url = imageURL {
            self.imageURL = url
        }
        self.socialMedia = socialArray
    }
    
    
}
