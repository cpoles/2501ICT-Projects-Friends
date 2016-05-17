//
//  SocialMediaAccount.swift
//  Friends
//
//  Created by Carlos Poles on 17/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import Foundation

class SocialMediaAccount : Equatable {
    
    
    // MARK: - Properties
    
    var identifier: String
    var type: SocialMediaType
    
    // MARK: - Initialisation
    
    init(identifier: String, type: SocialMediaType) {
        self.identifier = identifier
        self.type = type
    }
    
    func socialMediaAccountToPList() -> NSDictionary {
        
        let typeString = self.type.returnString()
        
        let propertyList: NSDictionary = [
            
            "identifier" : identifier,
            "type" : typeString
            
        ]
        
        return propertyList
    }
    
}


func ==(lhs: SocialMediaAccount, rhs: SocialMediaAccount) -> Bool {
    
    return lhs.identifier == rhs.identifier && lhs.type == lhs.type
}