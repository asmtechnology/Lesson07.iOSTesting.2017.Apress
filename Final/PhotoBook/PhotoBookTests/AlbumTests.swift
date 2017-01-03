//
//  AlbumTests.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 25/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import XCTest

class AlbumTests: XCTestCase {
    
    var emptyAlbumPlistFile: String?
    var invalidAlbumPlistFile: String?
    var invalidAlbumPlistFile2: String?
    var validAlbumPlistFile: String?
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of:self))
        emptyAlbumPlistFile = bundle.path(forResource: "EmptyAlbum", ofType: "plist")
        invalidAlbumPlistFile = bundle.path(forResource: "InvalidAlbum", ofType: "plist")
        invalidAlbumPlistFile2 = bundle.path(forResource: "InvalidAlbum2", ofType: "plist")
        validAlbumPlistFile = bundle.path(forResource: "ValidAlbum", ofType: "plist")
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
    
    func testLoad_NilFilePath_DoesNotUpdateCitiesArray() {
        let album = Album()
        album.load(filePath: nil)
        XCTAssertEqual(album.cities?.count, 0)
    }

    func testLoad_ValidFilePathWithNoCities_DoesNotUpdateCitiesArray() {
        let album = Album()
        album.load(filePath: emptyAlbumPlistFile)
        XCTAssertEqual(album.cities?.count, 0)
    }
    
    func testLoad_ValidFilePath_InvalidRootElementType_DoesNotUpdateCitiesArray() {
        let album = Album()
        album.load(filePath: invalidAlbumPlistFile)
        XCTAssertEqual(album.cities?.count, 0)
    }

    func testLoad_ValidFilePath_ValidRootElementType_InvalidChildElementType_DoesNotUpdateCitiesArray() {
        let album = Album()
        album.load(filePath: invalidAlbumPlistFile2)
        XCTAssertEqual(album.cities?.count, 0)
    }
    
    func testLoad_ValidFile_AddsExpectedNumberOfEntriestoCitiesArray() {
        let album = Album()
        album.load(filePath: validAlbumPlistFile)
        XCTAssertEqual(album.cities?.count, 6)
    }
    
}
