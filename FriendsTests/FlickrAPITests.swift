//
//  FlickrAPITests.swift
//  Friends
//
//  Created by Carlos Poles on 30/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import XCTest
@testable import Friends

class FlickrAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        FlickrAPIKey = "dc7f9d5d95a8e7dc3209a35d0fa24e20"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLatestPhotos() {
        let latestPhotos = latestFlickrPhotos()
        XCTAssertNotNil(latestPhotos)
        XCTAssertEqual(latestPhotos?.count, FlickrDefaultMaximumResults)
    }
    
    func testPhotos() {
        let photos = photosForUser("strictfunctor")
        XCTAssertNotNil(photos)
        XCTAssert(photos!.count > 0 )
    }
    
    func testPhotoImage() {
        let photos = photosForUser("strictfunctor")
        XCTAssertNotNil(photos)
        XCTAssert(photos!.count > 0 )
        let photo = photos?.first!
        let photoURLString = urlString(photo!)
        XCTAssertNotNil(photoURLString)
        let url = URL(string: photoURLString!)
        XCTAssertNotNil(url)
        let photoData = try? Data(contentsOf: url!)
        XCTAssertNotNil(photoData)
        let image = UIImage(data: photoData!)
        XCTAssertNotNil(image)
        
    }

    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
