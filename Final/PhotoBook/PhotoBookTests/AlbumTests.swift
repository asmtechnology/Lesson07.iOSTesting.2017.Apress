//
//  AlbumTests.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 25/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import XCTest

class AlbumTests: XCTestCase {
    
    let invalidURL:String = ""
    let validAlbumListURL:String = "http://www.asmtechnology.com/apress2017/albumlist.json"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_CityArrayIsNotNil() {
        let album = Album()
        XCTAssertNotNil(album.cities)
    }
 
    func testInit_CityArrayIsEmpty() {
        let album = Album()
        XCTAssertEqual(album.cities?.count, 0)
    }
    
    func testLoad_nilURL_fails_withErrorCode101() {
        
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 101")
        
        let album = Album()
        album.load(urlString: nil, success: { (Void) in
            // do nothing
        }, failure: { (error) in
            if error.code == 101 {
                expectation.fulfill()
            }
        })
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLoad_invalidURL_fails_withErrorCode101() {
        
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 101")
        
        let album = Album()
        album.load(urlString: invalidURL, success: { (Void) in
            // do nothing
        }, failure: { (error) in
            if error.code == 101 {
                expectation.fulfill()
            }
        })
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testLoad_validURL_callsFromFetchURLonServiceController_withExpectedURL() {
        
        let expectation = self.expectation(description: "Expected fetchURL to be called")
        
        let mockServiceController = MockServiceController()
        mockServiceController.fetchFromURLExpectation = (expectation, validAlbumListURL)
        
        let album = Album()
        album.serviceController = mockServiceController
        
        album.load(urlString: validAlbumListURL, success: { (Void) in
            // do nothing
        }, failure: { (error) in
            // do nothing
        })
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLoad_validURL_failsWhenServiceControllerFails() {
        let expectation = self.expectation(description: "Expected fetchURL to be called")
        
        let mockServiceController = MockServiceController()
        mockServiceController.shouldFailOnFetch = true
        
        let album = Album()
        album.serviceController = mockServiceController
        
        album.load(urlString: validAlbumListURL, success: { (Void) in
            // do nothing
        }, failure: { (error) in
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLoad_onServiceControllerFailure_doesNotUpdateCityArray() {

        let mockServiceController = MockServiceController()
        mockServiceController.shouldFailOnFetch = true
        
        let album = Album()
        album.serviceController = mockServiceController
        
        album.load(urlString: validAlbumListURL, success: { (Void) in
            // do nothing
        }, failure: { (error) in
            // do nothing
        })
        
        XCTAssertEqual(album.cities?.count, 0)
        
    }
    
    func testLoad_validURL_serviceControllerReturnsValidData_citiesArrayHasExpectedCount() {

        let bundle = Bundle(for: type(of:self))
        let filePath = bundle.path(forResource: "ValidAlbumList", ofType: "json")
        let stubResponseData = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        
        let mockServiceController = MockServiceController()
        mockServiceController.shouldFailOnFetch = false
        mockServiceController.dataToReturnOnSuccess = stubResponseData
        
        let album = Album()
        album.serviceController = mockServiceController
        
        album.load(urlString: validAlbumListURL, success: { (Void) in
            // do nothing
        }, failure: { (error) in
           // do nothing
        })
        
        XCTAssertEqual(album.cities?.count, 6)
    }
}
