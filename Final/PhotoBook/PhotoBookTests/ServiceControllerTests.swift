//
//  ServiceControllerTests.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 05/01/2017.
//  Copyright © 2017 ASM Technology Ltd. All rights reserved.
//

import XCTest

class ServiceControllerTests: XCTestCase {
    
    let invalidURL:String = ""
    let validAlbumListURL:String = "http://www.asmtechnology.com/apress2017/albumlist.json"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testfetchFromURL_invalidSession_fails_WithErrorCode100() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 100")
        
        let serviceController = ServiceController()
        serviceController.session = nil
        
        serviceController.fetchFromURL(urlString: validAlbumListURL,
                                       success: { (data) in
                                        // do nothing
        },
                                       failure:{ (error) in
                                        if error.code == 100 {
                                            expectation.fulfill()
                                        }
        })
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testfetchFromURL_nilURL_fails_WithErrorCode101() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 101")
        
        let serviceController = ServiceController()
        
        serviceController.fetchFromURL(urlString: nil,
                                       success: { (data) in
                                        // do nothing
        },
                                       failure:{ (error) in
                                        if error.code == 101 {
                                            expectation.fulfill()
                                        }
        })
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    
    func testfetchFromURL_invalidURL_fails_WithErrorCode101() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 101")
        
        let serviceController = ServiceController()
        
        serviceController.fetchFromURL(urlString: invalidURL,
                                       success: { (data) in
                                        // do nothing
        },
                                       failure:{ (error) in
                                        if error.code == 101 {
                                            expectation.fulfill()
                                        }
        })
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testfetchFromURL_validURL_callsDataTask_onURLSession_withTheSameURL() {
        
        guard let expectedURL = URL(string: validAlbumListURL) else {
            return
        }
        
        let expectation = self.expectation(description: "Expected dataTask to be called on URLSession")
        
        let mockURLSession = MockURLSession()
        mockURLSession.dataTaskExpectation = (expectation, expectedURL)
        
        let serviceController = ServiceController()
        serviceController.session = mockURLSession
        
        
        serviceController.fetchFromURL(urlString: validAlbumListURL,
                                       success: { (data) in
                                        // do nothing
        },
                                       failure:{ (error) in
                                        // do nothing
        })
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    
    func testfetchFromURL_validURL_validDataTask_callsResume_onDataTask() {
        
        let expectation = self.expectation(description: "Expected dataTask block to be called on URLSession")
    
        let mockURLSession = MockURLSession()
        mockURLSession.dataTaskToReturn?.resumeExpectation = expectation
        
        let serviceController = ServiceController()
        serviceController.session = mockURLSession
        
        serviceController.fetchFromURL(urlString: validAlbumListURL,
                                       success: { (data) in
                                        // do nothing
        },
                                       failure:{ (error) in
                                        // do nothing
        })
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
}
