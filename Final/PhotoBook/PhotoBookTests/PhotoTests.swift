//
//  PhotoTests.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import XCTest

class PhotoTests: XCTestCase {
    
    var invalidPhotoDictionary1: [String : AnyObject]?
    var invalidPhotoDictionary2: [String : AnyObject]?
    var invalidPhotoDictionary3: [String : AnyObject]?
    var invalidPhotoDictionary4: [String : AnyObject]?
    var invalidPhotoDictionary5: [String : AnyObject]?
    
    var validPhotoDictionary1: [String : AnyObject]?
    
    let imageNameKey = "imageName"
    let apertureKey = "aperture"
    let shutterSpeedKey = "shutterSpeed"
    let isoKey = "iso"
    let commentKey = "comment"
    
    override func setUp() {
        super.setUp()

        validPhotoDictionary1 = [String : AnyObject]()
        validPhotoDictionary1![imageNameKey] = "1" as AnyObject
        validPhotoDictionary1![apertureKey] = "f2.0" as AnyObject
        validPhotoDictionary1![shutterSpeedKey] = "1/250" as AnyObject
        validPhotoDictionary1![isoKey] = "100" as AnyObject
        validPhotoDictionary1![commentKey] = "Test photo" as AnyObject
        
        invalidPhotoDictionary1 = [String : AnyObject]()
        invalidPhotoDictionary1![apertureKey] = "f2.0" as AnyObject
        invalidPhotoDictionary1![shutterSpeedKey] = "1/250" as AnyObject
        invalidPhotoDictionary1![isoKey] = "100" as AnyObject
        invalidPhotoDictionary1![commentKey] = "Test photo" as AnyObject
        
        invalidPhotoDictionary2 = [String : AnyObject]()
        invalidPhotoDictionary2![imageNameKey] = "1" as AnyObject
        invalidPhotoDictionary2![shutterSpeedKey] = "1/250" as AnyObject
        invalidPhotoDictionary2![isoKey] = "100" as AnyObject
        invalidPhotoDictionary2![commentKey] = "Test photo" as AnyObject
        
        invalidPhotoDictionary3 = [String : AnyObject]()
        invalidPhotoDictionary3![imageNameKey] = "1" as AnyObject
        invalidPhotoDictionary3![apertureKey] = "f2.0" as AnyObject
        invalidPhotoDictionary3![isoKey] = "100" as AnyObject
        invalidPhotoDictionary3![commentKey] = "Test photo" as AnyObject
        
        invalidPhotoDictionary4 = [String : AnyObject]()
        invalidPhotoDictionary4![imageNameKey] = "1" as AnyObject
        invalidPhotoDictionary4![apertureKey] = "f2.0" as AnyObject
        invalidPhotoDictionary4![shutterSpeedKey] = "1/250" as AnyObject
        invalidPhotoDictionary4![commentKey] = "Test photo" as AnyObject

        invalidPhotoDictionary5 = [String : AnyObject]()
        invalidPhotoDictionary5![imageNameKey] = "1" as AnyObject
        invalidPhotoDictionary5![apertureKey] = "f2.0" as AnyObject
        invalidPhotoDictionary5![shutterSpeedKey] = "1/250" as AnyObject
        invalidPhotoDictionary5![isoKey] = "100" as AnyObject
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_NilDictionary_DoesNotCreateInstance() {
        let photo = Photo(nil)
        XCTAssertNil(photo)
    }
    
    func testInit_DictionaryMissingImagenameKey_DoesNotCreateInstance() {
        let photo = Photo(invalidPhotoDictionary1)
        XCTAssertNil(photo)
    }
    
    func testInit_DictionaryMissingApertureKey_DoesNotCreateInstance() {
        let photo = Photo(invalidPhotoDictionary2)
        XCTAssertNil(photo)
    }
    
    func testInit_DictionaryMissingShutterspeedKey_DoesNotCreateInstance() {
        let photo = Photo(invalidPhotoDictionary3)
        XCTAssertNil(photo)
    }

    func testInit_DictionaryMissingISOKey_DoesNotCreateInstance() {
        let photo = Photo(invalidPhotoDictionary4)
        XCTAssertNil(photo)
    }
    
    func testInit_DictionaryMissingCommentsKey_DoesNotCreateInstance() {
        let photo = Photo(invalidPhotoDictionary5)
        XCTAssertNil(photo)
    }

    func testInit_ValidDictionary_CreateInstance() {
        let photo = Photo(validPhotoDictionary1)
        XCTAssertNotNil(photo)
    }
    
    func testInit_ValidDictionary_CopiesImagename() {
        let photo = Photo(validPhotoDictionary1)
        XCTAssertEqual(photo!.imageName!, validPhotoDictionary1?[imageNameKey] as! String)
    }

    func testInit_ValidDictionary_CopiesAperture() {
        let photo = Photo(validPhotoDictionary1)
        XCTAssertEqual(photo!.aperture!, validPhotoDictionary1?[apertureKey] as! String)
    }

    func testInit_ValidDictionary_CopiesShutterspeed() {
        let photo = Photo(validPhotoDictionary1)
        XCTAssertEqual(photo!.shutterSpeed!, validPhotoDictionary1?[shutterSpeedKey] as! String)
    }

    func testInit_ValidDictionary_CopiesISO() {
        let photo = Photo(validPhotoDictionary1)
        XCTAssertEqual(photo!.iso!, validPhotoDictionary1?[isoKey] as! String)
    }

    func testInit_ValidDictionary_CopiesComment() {
        let photo = Photo(validPhotoDictionary1)
        XCTAssertEqual(photo!.comments!, validPhotoDictionary1?[commentKey] as! String)
    }
    
    func testInit_ValidDictionary_downloadedImage_IsNil() {
        
        let mockServiceController = MockServiceController()
        mockServiceController.shouldFailOnFetch = true

        let photo = Photo(validPhotoDictionary1)
        photo?.serviceController = mockServiceController
        
        XCTAssertNil(photo?.downloadedImage)
    }
    
    func testInit_ValidDictionary_whenDownloadedImageIsCalled_callsDownloadImage() {
        
        let expectation = self.expectation(description: "Expected downloadImage to be called")
        
        let mockServiceController = MockServiceController()
        mockServiceController.shouldFailOnFetch = true
        
        let photo = MockPhoto(validPhotoDictionary1)
        photo?.downloadImageExpectation = expectation
        photo?.imageName = "11.jpg"
        photo?.baseURL = "http://www.asmtechnology.com/apress2017/"
        photo?.serviceController = mockServiceController
        
        let _ = photo?.downloadedImage
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testBuildImageDownloadURL_nilImageName_returnsNil() {
        let photo = Photo(validPhotoDictionary1)
        photo?.imageName = nil
        XCTAssertNil(photo!.buildImageDownloadURL())
    }
    
    func testBuildImageDownloadURL_validBaseURL_validImageName_returnsCorrectImageURL() {
        let photo = Photo(validPhotoDictionary1)
        photo?.imageName = "11.jpg"
        photo?.baseURL = "http://www.asmtechnology.com/apress2017/"
        
        let expectedURL = "http://www.asmtechnology.com/apress2017/11.jpg"
        XCTAssertEqual(photo!.buildImageDownloadURL(), expectedURL)
    }
    
    func testDownloadImage_validImageURL_callsFromFetchURLonServiceController_withExpectedURL() {
        
        let expectation = self.expectation(description: "Expected fetchURL to be called")
        let expectedURL = "http://www.asmtechnology.com/apress2017/11.jpg"
        
        let mockServiceController = MockServiceController()
        mockServiceController.fetchFromURLExpectation = (expectation, expectedURL)
        
        let photo = Photo(validPhotoDictionary1)
        photo?.imageName = "11.jpg"
        photo?.baseURL = "http://www.asmtechnology.com/apress2017/"
        photo?.serviceController = mockServiceController
        
        photo?.downloadImage()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testDownloadImage_validImageURL_serviceControllerReturnsValidData_updatesImage()  {
        
        let bundle = Bundle(for: type(of:self))
        let filePath = bundle.path(forResource: "bar1", ofType: "jpg")
        let stubResponseData = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        
        let mockServiceController = MockServiceController()
        mockServiceController.shouldFailOnFetch = false
        mockServiceController.dataToReturnOnSuccess = stubResponseData
        
        let photo = Photo(validPhotoDictionary1)
        photo?.imageName = "11.jpg"
        photo?.baseURL = "http://www.asmtechnology.com/apress2017/"
        photo?.serviceController = mockServiceController
        
        photo?.downloadImage()
        
        XCTAssertNotNil(photo?.downloadedImage)
    }
    
    
    func testDownloadImage_validImageURL_validListener_calls_didDownloadImage_onListener()  {
        
        let expectation = self.expectation(description: "Expected fetchURL to be called")
        let mockDownloadListener = MockDownloadListener()
        mockDownloadListener.didDownloadImageExpectation = expectation
        
        let bundle = Bundle(for: type(of:self))
        let filePath = bundle.path(forResource: "bar1", ofType: "jpg")
        let stubResponseData = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        
        let mockServiceController = MockServiceController()
        mockServiceController.shouldFailOnFetch = false
        mockServiceController.dataToReturnOnSuccess = stubResponseData
        
        let photo = Photo(validPhotoDictionary1)
        photo?.imageName = "11.jpg"
        photo?.baseURL = "http://www.asmtechnology.com/apress2017/"
        photo?.serviceController = mockServiceController
        photo?.listener = mockDownloadListener
        
        photo?.downloadImage()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
