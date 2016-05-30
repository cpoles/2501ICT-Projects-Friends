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
        XCTAssertEqual(contact.image!, imageToTest)

    }
    
    // socialMedia property

    func testSocialMedia() {
        let contact = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        let socialMediaToTest = [SocialMediaAccount(identifier: "email", type: "Facebook"), SocialMediaAccount(identifier: "token", type: "Twitter")]
        
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
        let socialMedias = [[SocialMediaAccount(identifier: "email", type: "Facebook"), SocialMediaAccount(identifier: "token", type: "Twitter")], [SocialMediaAccount(identifier: "webaddress", type: "WebPage")], [SocialMediaAccount(identifier: "token", type: "Flickr")], [SocialMediaAccount(identifier: "email", type: "Facebook"), SocialMediaAccount(identifier: "token", type: "Twitter")] ]
        
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
     This function tests whether or not a given array of Contact objects can be converted to
     a JSONObject.
     
     */
    
    func testConvertToPropertyList() {
        var contactList = [Contact]()
        let contact1 = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        contact1.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
        let contact2 = Contact(firstName: "Carlos", lastName: "Antonio", address: "Argentina")
        contact2.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
        let contact3 = Contact(firstName: "Luis", lastName: "Miguel", address: "Uruguay")
        contact3.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
            
        contactList.append(contact1)
        contactList.append(contact2)
        contactList.append(contact3)
        
        // convert Array of Contacts into NSDictionary Format
        
        let contactListAsDic = contactList.map { $0.propertyListRepresentation() }
        
        XCTAssertTrue(NSJSONSerialization.isValidJSONObject(contactListAsDic))
        
    }
    
    /**
     
     This function tests the save data functionality.
     The data is saved into a JSON file.
     
     */
    
    func testWriteToJSONFile() {
        
        var contactList = [Contact]()
        let contact1 = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        contact1.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
        let contact2 = Contact(firstName: "Carlos", lastName: "Antonio", address: "Argentina")
        contact2.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
        let contact3 = Contact(firstName: "Luis", lastName: "Miguel", address: "Uruguay")
        contact3.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
        
        contactList.append(contact1)
        contactList.append(contact2)
        contactList.append(contact3)
        
        // create path from Directory for the class for the converted class into a property list to be saved.
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
        
        // convert ContactList into NSDictionary format
        
        let contactListAsDic = contactList.map { $0.propertyListRepresentation() }
        
        // create NSData Object to write data to file
        
        let data: NSData
        
        try! data = NSJSONSerialization.dataWithJSONObject(contactListAsDic, options: .PrettyPrinted)
        
        // create jSON file
        
        let jsonFile = path.stringByAppendingPathComponent("friendTest.json")
        
        // write data to file
        
        XCTAssertTrue(data.writeToFile(jsonFile, atomically: true))
        
        
    }
    
    func testloadDataFromJSONFile() {
        var contactList = [Contact]()
        let contact1 = Contact(firstName: "Carlos", lastName: "Poles", address: "Brazil")
        contact1.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
        let contact2 = Contact(firstName: "Carlos", lastName: "Antonio", address: "Argentina")
        contact2.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
        let contact3 = Contact(firstName: "Luis", lastName: "Miguel", address: "Uruguay")
        contact3.imageURL = "https://upload.wikimedia.org/wikipedia/en/e/e9/Bond_University_logo.jpg"
        
        contactList.append(contact1)
        contactList.append(contact2)
        contactList.append(contact3)
        
        // create path from Directory for the class for the converted class into a property list to be saved.
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
        
        // convert ContactList into NSDictionary format
        
        let contactListAsDic = contactList.map { $0.propertyListRepresentation() }
        
        // create NSData Object to write data to file
        
        let data: NSData
        
        try! data = NSJSONSerialization.dataWithJSONObject(contactListAsDic, options: .PrettyPrinted)
        
        // create jSON file
        
        let jsonFile = path.stringByAppendingPathComponent("friendTest.json")
        
        // write data to file
    
        data.writeToFile(jsonFile, atomically: true)
        
        
        //build the ContacList from the jSON file
        
        // create NSData object
        
        let jsonData = NSData(contentsOfFile: jsonFile)
        
        // create the array of dictionaries from the jsonData object
        
        let jsonArrayDic: [NSDictionary]
        
        try! jsonArrayDic = NSJSONSerialization.JSONObjectWithData(jsonData!, options: []) as! [NSDictionary]
        
        // create the array of Contact objects parsing a trailing closure to the map function of the jsonArrayDic
        // The closure will build a Contact object for each dictionary inside the jsonArrayDic
        
        let loadedContactList = jsonArrayDic.map { Contact(propertyList: $0) }
        
        XCTAssertNotNil(loadedContactList)
    }

}






















