//
//  SocialMediaAccount.swift
//  Friends
//
//  Created by Carlos Poles on 17/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import Foundation

class SocialMediaAccount : Equatable, PropertyListable {
    
    
    // MARK: - Properties
    
    dynamic var identifier: String
    var type: String
    
    // MARK: - Initialisation
    
    init(identifier: String, type: String) {
        self.identifier = identifier
        self.type = type
    }
    
    func propertyListRepresentation() -> NSDictionary {
              
        let typeString = self.type
        let propertyList: NSDictionary = [
            
            "identifier" : identifier,
            "type" : typeString
            
        ]
        
        return propertyList
    }
    
    convenience init(propertyList: NSDictionary) {
        let identifier = (propertyList.objectForKey("identifier") as! String)
        let type = (propertyList.objectForKey("type") as! String)
        self.init(identifier: identifier, type: type)
        
    }

}

func ==<T: PropertyListable>(lhs: T, rhs: T) -> Bool {
    return lhs.propertyListRepresentation() == rhs.propertyListRepresentation()
}


func ==<T: SocialMediaAccount>(lhs: T, rhs: T) -> Bool {
    
    return lhs.identifier == rhs.identifier && lhs.type == lhs.type
}