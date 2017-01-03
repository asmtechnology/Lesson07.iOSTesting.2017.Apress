//
//  CollectionViewCellTests.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 27/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import XCTest

class CollectionViewCellTests: XCTestCase {
    
    private var validPhoto:Photo?
    
    let imageNameKey = "imageName"
    let apertureKey = "aperture"
    let shutterSpeedKey = "shutterSpeed"
    let isoKey = "iso"
    let commentKey = "comment"
    
    override func setUp() {
        super.setUp()

        var validPhotoDictionary1: [String : AnyObject]?
        validPhotoDictionary1 = [String : AnyObject]()
        validPhotoDictionary1![imageNameKey] = "1" as AnyObject
        validPhotoDictionary1![apertureKey] = "f2.0" as AnyObject
        validPhotoDictionary1![shutterSpeedKey] = "1/250" as AnyObject
        validPhotoDictionary1![isoKey] = "100" as AnyObject
        validPhotoDictionary1![commentKey] = "Test photo" as AnyObject
        
        validPhoto = Photo(validPhotoDictionary1)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetup_ValidViewModel_Calls_Setup_OnViewModel() {
        
        let expectation = self.expectation(description: "expected setup() to be called")
        
        let collectionViewCell = CollectionViewCell()
        collectionViewCell.imageView = UIImageViewStub()
        collectionViewCell.captionLabel = UILabelStub()
        collectionViewCell.shotDetailsLabel = UILabelStub()
        
        let viewModel = MockCollectionViewCellViewModel(model:validPhoto)
        viewModel!.setupExpectation = expectation
        
        collectionViewCell.viewModel = viewModel
        
        collectionViewCell.setup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
