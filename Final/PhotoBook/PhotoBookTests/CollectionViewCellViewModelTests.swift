//
//  CollectionViewCellViewModelTests.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import XCTest

class CollectionViewCellViewModelTests: XCTestCase {
    
    fileprivate var validPhoto:Photo?
    fileprivate var mockCollectionViewCell:MockCollectionViewCell?
    
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
        
        mockCollectionViewCell = MockCollectionViewCell()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}


// MARK: initialization tests
extension CollectionViewCellViewModelTests {
    
    func testInit_NilModel_DoesNotInstantiateObject() {
        let viewModel = CollectionViewCellViewModel(model:nil)
        XCTAssertNil(viewModel)
    }
    
    func testInit_ValidModel_InstantiatesObject() {
        let viewModel = CollectionViewCellViewModel(model:validPhoto)
        XCTAssertNotNil(viewModel)
    }
    
    func testInit_ValidModel_CopiesModelToIvar() {
        let viewModel =  CollectionViewCellViewModel(model:validPhoto)
        XCTAssertTrue(validPhoto === viewModel!.photo!)
    }
    
}


// MARK: setView tests
extension CollectionViewCellViewModelTests {
    
    func testSetView_ValidView_CopiesViewToIvar() {
        let viewModel =  CollectionViewCellViewModel(model:validPhoto)
        viewModel?.setView(mockCollectionViewCell!)
        
        if let lhs = mockCollectionViewCell, let rhs = viewModel?.collectionViewCell as? MockCollectionViewCell {
            XCTAssertTrue(lhs === rhs)
        }
    }

}


// MARK: setup tests
extension CollectionViewCellViewModelTests {

    
    func testSetup_ValidPhoto_Calls_SetCaption_WithExpectedText() {
        
        let expectation = self.expectation(description: "expected setCaption() to be called")
        mockCollectionViewCell?.expectationForSetCaption = (expectation, validPhoto!.comments!)
        
        let viewModel =  CollectionViewCellViewModel(model:validPhoto)
        viewModel?.setView(mockCollectionViewCell!)
        
        viewModel?.setup()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSetup_ValidPhoto_Calls_SetShotDetails_WithExpectedText() {
        
        let expectation = self.expectation(description: "expected setShotDetails() to be called")
        let expectedShotDetailsString = "\(validPhoto!.aperture!), \(validPhoto!.shutterSpeed!), ISO \(validPhoto!.iso!)"
        mockCollectionViewCell?.expectationForSetupShotDetails = (expectation, expectedShotDetailsString)
        
        let viewModel =  CollectionViewCellViewModel(model:validPhoto)
        viewModel?.setView(mockCollectionViewCell!)
        
        viewModel?.setup()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
