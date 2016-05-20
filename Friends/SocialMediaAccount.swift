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
    
    var identifier: String
    var type: SocialMediaType
    
    // MARK: - Initialisation
    
    init(identifier: String, type: SocialMediaType) {
        self.identifier = identifier
        self.type = type
    }
    
    func propertyListRepresentation() -> NSDictionary {
              
        let typeString = self.type.returnString()
        
        let propertyList: NSDictionary = [
            
            "identifier" : identifier,
            "type" : typeString
            
        ]
        
        return propertyList
    }
    
}

func ==<T: PropertyListable>(lhs: T, rhs: T) -> Bool {
    return lhs.propertyListRepresentation() == rhs.propertyListRepresentation()
}


func ==<T: SocialMediaAccount>(lhs: T, rhs: T) -> Bool {
    
    return lhs.identifier == rhs.identifier && lhs.type == lhs.type
}