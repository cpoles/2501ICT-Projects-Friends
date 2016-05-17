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
    
    // Test Contact firstName property
    
    func testFirstName() {
        let firstNameToTest = "Carlos"
        let contact = Contact(firstName: firstNameToTest, lastName: "Poles", address: "Brazil")
        XCTAssertNotNil(firstNameToTest)
        XCTAssertEqual(contact.firstName, firstNameToTest)
        
    }
    
    func testLastName() {
        let lastNameToTest = "Poles"
        let contact = Contact(firstName: "Carlos", lastName: lastNameToTest, address: "Brazil")
        XCTAssertNotNil(lastNameToTest)
        XCTAssertEqual(contact.lastName, lastNameToTest)
    }
    
    func testAddress() {
        let addressToTest = "Brazil"
        let contact = Contact(firstName: "Carlos", lastName: "Poles", address: addressToTest)
        XCTAssertNotNil(addressToTest)
        XCTAssertEqual(contact.address, addressToTest)
    }
    
    func testFullName() {
        let firstNameToTest = "Carlos"
        let lastNameToTest = "Poles"
        let contact = Contact(firstName: firstNameToTest, lastName: lastNameToTest, address: "Brazil")
        XCTAssertNotNil(firstNameToTest)
        XCTAssertNotNil(lastNameToTest)
        let fullNameToTest = firstNameToTest + " " + lastNameToTest
        XCTAssertEqual(contact.fullName, fullNameToTest)
        
    }
    
    func testImageURL() {
        let contact = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        let imageURLToTest = "http://stuffpoint.com/cats/image/41633-cats-cute-cat.jpg"
        XCTAssertNotNil(imageURLToTest)
        contact.imageURL = imageURLToTest
        XCTAssertEqual(contact.imageURL, imageURLToTest)
    }
    
    func testImageData() {
        let contact = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        let imageURLToTest = "http://stuffpoint.com/cats/image/41633-cats-cute-cat.jpg"
        XCTAssertNotNil(imageURLToTest)
        contact.imageURL = imageURLToTest
        
        let imageToTest = contact.image
        XCTAssertNotNil(imageToTest)
        XCTAssertEqual(contact.image, imageToTest)

    }
    
    func testSocialMedia() {
        let contact = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        let socialMediaToTest = [SocialMediaAccount(identifier: "email", type: .Facebook), SocialMediaAccount(identifier: "token", type: .Twitter)]
        
        XCTAssertNotNil(socialMediaToTest)
        
        contact.socialMedia = socialMediaToTest
        
        XCTAssertEqual(contact.socialMedia, socialMediaToTest)
        
    }
    
    
    
}






















