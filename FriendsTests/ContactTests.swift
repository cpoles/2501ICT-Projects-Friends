//
//  ContactTests.swift
//  Friends
//
//  Created by Carlos Poles on 17/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import XCTest
@testable import Friends

class ContactTests: XCTestCase {
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Contact Class Tests
    
    // firstName property
    
    func testFirstName() {
        let firstNameToTest = "Carlos"
        let contact = Contact(firstName: firstNameToTest, lastName: "Poles", address: "Brazil")
        XCTAssertNotNil(firstNameToTest)
        XCTAssertEqual(contact.firstName, firstNameToTest)
        
    }
    
    // lastName property
    
    func testLastName() {
        let lastNameToTest = "Poles"
        let contact = Contact(firstName: "Carlos", lastName: lastNameToTest, address: "Brazil")
        XCTAssertNotNil(lastNameToTest)
        XCTAssertEqual(contact.lastName, lastNameToTest)
    }
    
    // address property
    
    func testAddress() {
        let addressToTest = "Brazil"
        let contact = Contact(firstName: "Carlos", lastName: "Poles", address: addressToTest)
        XCTAssertNotNil(addressToTest)
        XCTAssertEqual(contact.address, addressToTest)
    }
    
    // fullName property
    
    func testFullName() {
        let firstNameToTest = "Carlos"
        let lastNameToTest = "Poles"
        let contact = Contact(firstName: firstNameToTest, lastName: lastNameToTest, address: "Brazil")
        XCTAssertNotNil(firstNameToTest)
        XCTAssertNotNil(lastNameToTest)
        let fullNameToTest = firstNameToTest + " " + lastNameToTest
        XCTAssertEqual(contact.fullName, fullNameToTest)
        
    }
    
    // imageURL property
    
    func testImageURL() {
        let contact = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        let imageURLToTest = "http://stuffpoint.com/cats/image/41633-cats-cute-cat.jpg"
        XCTAssertNotNil(imageURLToTest)
        contact.imageURL = imageURLToTest
        XCTAssertEqual(contact.imageURL, imageURLToTest)
    }
    
    // image property
    
    func testImageData() {
        let contact = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        let imageURLToTest = "http://stuffpoint.com/cats/image/41633-cats-cute-cat.jpg"
        XCTAssertNotNil(imageURLToTest)
        contact.imageURL = imageURLToTest
        
        let imageToTest = contact.image
        XCTAssertNotNil(imageToTest)
        XCTAssertEqual(contact.image, imageToTest)

    }
    
    // socialMedia property

    func testSocialMedia() {
        let contact = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        let socialMediaToTest = [SocialMediaAccount(identifier: "email", type: .Facebook), SocialMediaAccount(identifier: "token", type: .Twitter)]
        
        XCTAssertNotNil(socialMediaToTest)
        contact.socialMedia = socialMediaToTest
        XCTAssertEqual(contact.socialMedia, socialMediaToTest)
        
    }
    
    // MARK: - properties Setters and Getters
    
    func testSettersAndGetters() {
        let firstNames = ["Carlos", "Antonio", "Marco", "Theodore"]
        let lastNames = ["Poles", "Brown", "Wilson", "White"]
        let addresses = ["Brazil", "Italy", "Germany", "Australia"]
        let imageURLs = ["http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg", "http://stuffpoint.com/cartoons/image/187936-cartoons-pluto.jpg", "http://stuffpoint.com/cartoons/image/174883-cartoons-cartoons.jpg", "http://stuffpoint.com/cats/image/41633-cats-cute-cat.jpg" ]
        let socialMedias = [[SocialMediaAccount(identifier: "email", type: .Facebook), SocialMediaAccount(identifier: "token", type: .Twitter)], [SocialMediaAccount(identifier: "email", type: .Weibo)], [SocialMediaAccount(identifier: "token", type: .Flickr)], [SocialMediaAccount(identifier: "email", type: .Facebook), SocialMediaAccount(identifier: "token", type: .Twitter)] ]
        
        let contact = Contact(firstName: "", lastName: "", address: "")
        
        for firstName in firstNames {
            contact.firstName = firstName
            
            for lastName in lastNames {
                contact.lastName = lastName
                
                for address in addresses {
                    contact.address = address
                    
                    for imageURL in imageURLs {
                        contact.imageURL = imageURL
                        
                        for socialMedia in socialMedias {
                            contact.socialMedia = socialMedia
                            
                            XCTAssertEqual(contact.firstName, firstName)
                            XCTAssertEqual(contact.lastName, lastName)
                            XCTAssertEqual(contact.address, address)
                            XCTAssertEqual(contact.imageURL, imageURL)
                            XCTAssertEqual(contact.socialMedia, socialMedia)
                            
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    
    
    // MARK: - Persistence Tests
    
    /**
     This function tests whether or not a given array of Photo objects can be converted to
     a JSONObject.
     
     */
    
//    var contactList = [Contact]()
//    let contact1 = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
//    contact1.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
//    let contact2 = Contact(firstName: ", lastName: <#T##String#>, address: <#T##String#>)
//        
//        contactList.append(contact1)
}






















