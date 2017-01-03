//
//  CityTests.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import XCTest

class CityTests: XCTestCase {
    
    var photoArrayWithNoElements: [[String : AnyObject] ]?
    var photoArrayWithOneElement: [[String : AnyObject] ]?
    
    var invalidCityDictionary1: [String : AnyObject]?
    var invalidCityDictionary2: [String : AnyObject]?
    var validCityDictionary1: [String : AnyObject]?
    var validCityDictionary2: [String : AnyObject]?
    
    let cityKey = "city"
    let photosKey = "photos"
    
    let imageNameKey = "imageName"
    let apertureKey = "aperture"
    let shutterSpeedKey = "shutterSpeed"
    let isoKey = "iso"
    let commentKey = "comment"
    
    override func setUp() {
        super.setUp()

        photoArrayWithNoElements = [[String : AnyObject]]()
        photoArrayWithOneElement = [[String : AnyObject]]()
        
        var photoDictionary = [String : AnyObject]()
        photoDictionary[imageNameKey] = "1" as AnyObject
        photoDictionary[apertureKey] = "f2.0" as AnyObject
        photoDictionary[shutterSpeedKey] = "1/250" as AnyObject
        photoDictionary[isoKey] = "100" as AnyObject
        photoDictionary[commentKey] = "Test photo" as AnyObject
        photoArrayWithOneElement?.append(photoDictionary)
        
        invalidCityDictionary1 = [String : AnyObject]()
        invalidCityDictionary1![photosKey] = photoArrayWithNoElements as AnyObject
        
        invalidCityDictionary2 = [String : AnyObject]()
        invalidCityDictionary2![cityKey] = "London" as AnyObject
        
        validCityDictionary1 = [String : AnyObject]()
        validCityDictionary1![cityKey] = "London" as AnyObject
        validCityDictionary1![photosKey] = photoArrayWithNoElements as AnyObject
        
        validCityDictionary2 = [String : AnyObject]()
        validCityDictionary2![cityKey] = "London" as AnyObject
        validCityDictionary2![photosKey] = photoArrayWithOneElement as AnyObject

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_NilDictionary_DoesNotCreateInstance() {
        let city = City(nil)
        XCTAssertNil(city)
    }
    
    func testInit_DictionaryMissingCityKey_DoesNotCreateInstance() {
        let city = City(invalidCityDictionary1)
        XCTAssertNil(city)
    }
    
    func testInit_DictionaryMissingPhotoKey_DoesNotCreateInstance() {
        let city = City(invalidCityDictionary2)
        XCTAssertNil(city)
    }

    
    func testInit_ValidDictionary_ZeroPhotos_CreatesInstance() {
        let city = City(validCityDictionary1)
        XCTAssertNotNil(city)
    }
    
    func testInit_ValidDictionary_ZeroElementsInPhotosArray_CopiesCityName() {
        let city = City(validCityDictionary1)
        let expectedCityName = validCityDictionary1?[cityKey] as? String
        
        XCTAssertEqual(city?.cityName, expectedCityName)
    }

    func testInit_ValidDictionary_ZeroElementsInPhotosArray_PhotosArrayHasZeroElements() {
        let city = City(validCityDictionary1)
        XCTAssertEqual(city?.photos?.count, 0)
    }

    func testInit_ValidDictionary_OneElementInPhotosArray_CopiesCityName() {
        let city = City(validCityDictionary2)
        let expectedCityName = validCityDictionary2?[cityKey] as? String
        
        XCTAssertEqual(city?.cityName, expectedCityName)
    }
    
    func testInit_ValidDictionary_OneElementInPhotosArray_PhotosArrayHasOneElement() {
        let city = City(validCityDictionary2)
        XCTAssertEqual(city?.photos?.count, 1)
    }
    
}
