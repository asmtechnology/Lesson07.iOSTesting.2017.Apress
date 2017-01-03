//
//  CollectionViewModelTests.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import XCTest

class CollectionViewModelTests: XCTestCase {
    
    fileprivate var mockCollectionViewController:MockCollectionViewController?
    
    override func setUp() {
        super.setUp()
        mockCollectionViewController = MockCollectionViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}

// MARK: initialization tests
extension CollectionViewModelTests {

    func testInit_ValidView_InstantiatesObject() {
        let viewModel = CollectionViewModel(view:mockCollectionViewController!)
        XCTAssertNotNil(viewModel)
    }

    func testInit_ValidView_CopiesViewToIvar() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        if let lhs = mockCollectionViewController, let rhs = viewModel.view as? MockCollectionViewController {
            XCTAssertTrue(lhs === rhs)
        }
    }
    
    func testInit_ValidView_AlbumIVarIsNotNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        XCTAssertNotNil(viewModel.photoAlbum)
    }
    
}

// MARK: performInitialViewSetup tests
extension CollectionViewModelTests {

    func testPerformInitialViewSetup_Calls_SetNavigationTitle_OnCollectionViewController() {
        let expectation = self.expectation(description: "expected setNavigationTitle() to be called")
        mockCollectionViewController!.expectationForSetNavigationTitle = expectation
        
        let viewModel = CollectionViewModel(view:mockCollectionViewController!)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)

    }
    
    
    func testPerformInitialViewSetup_Calls_SetSectionInset_OnCollectionViewController() {
        let expectation = self.expectation(description: "expected setSectionInset() to be called")
        mockCollectionViewController!.expectationForSetSectionInset = expectation
        
        let viewModel = CollectionViewModel(view:mockCollectionViewController!)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testPerformInitialViewSetup_Calls_SetupCollectionViewCellToUseMaxWidth_OnCollectionViewController() {
        let expectation = self.expectation(description: "expected setupCollectionViewCellToUseMaxWidth() to be called")
        mockCollectionViewController!.expectationForSetupCollectionViewCellToUseMaxWidth = expectation
        
        let viewModel = CollectionViewModel(view:mockCollectionViewController!)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}


// MARK: numberOfSections  tests
extension CollectionViewModelTests {
    
    func testNumberOfSections_ValidViewModelWithAlbum_ReturnsNumberOfCitiesInAlbum() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        XCTAssertEqual(viewModel.numberOfSections(), viewModel.photoAlbum!.cities!.count)
    }
    
    func testNumberOfSections_ValidViewModelNilAlbum_ReturnsZero() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        viewModel.photoAlbum = nil
        
        XCTAssertEqual(viewModel.numberOfSections(), 0)
    }
    
}


// MARK: numberOfItemsInSection tests
extension CollectionViewModelTests {

    func testNumberOfItemsInSection_ValidViewModelNilAlbum_ReturnsZero() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        viewModel.photoAlbum = nil
        
        XCTAssertEqual(viewModel.numberOfItemsInSection(0), 0)
    }
    
    func testNumberOfItemsInSection_ValidViewModelNilCities_ReturnsZero() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        viewModel.photoAlbum!.cities = nil
        
        XCTAssertEqual(viewModel.numberOfItemsInSection(0), 0)
    }
    
    func testNumberOfItemsInSection_NegtiveSectionIndex_ReturnsZero() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)

        XCTAssertEqual(viewModel.numberOfItemsInSection(-1), 0)
    }
    
    func testNumberOfItemsInSection_OutOfBoundsSectionIndex_ReturnsZero() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertEqual(viewModel.numberOfItemsInSection(1000), 0)
    }
    
    func testNumberOfItemsInSection_ValidSectionIndex_ReturnsExpectedValue() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertEqual(viewModel.numberOfItemsInSection(0), viewModel.photoAlbum!.cities![0].photos!.count)
    }
    
}



// MARK: cellViewModel tests
extension CollectionViewModelTests {
    
    func testCellViewModel_ValidViewModelNilAlbum_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        viewModel.photoAlbum = nil
        
        XCTAssertNil(viewModel.cellViewModel(indexPath:IndexPath(row: 0, section: 0)))
    }
    
    func testCellViewModel_ValidViewModelNilCities_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        viewModel.photoAlbum!.cities = nil
        
        XCTAssertNil(viewModel.cellViewModel(indexPath:IndexPath(row: 0, section: 0)))
    }
    
    func testCellViewModel_ValidViewModelNilPhotos_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        viewModel.photoAlbum!.cities![0].photos = nil
        
        XCTAssertNil(viewModel.cellViewModel(indexPath:IndexPath(row: 0, section: 0)))
    }
    
    func testCellViewModel_NegtiveRowIndex_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertNil(viewModel.cellViewModel(indexPath:IndexPath(row: -1, section: 0)))
    }
    
    func testCellViewModel_NegtiveSectionIndex_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertNil(viewModel.cellViewModel(indexPath:IndexPath(row: 0, section: -1)))
    }
    
    func testCellViewModel_OutOfBoundsRowIndex_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertNil(viewModel.cellViewModel(indexPath:IndexPath(row: 1000, section: 0)))
    }
    
    func testCellViewModel_OutOfBoundsSectionIndex_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertNil(viewModel.cellViewModel(indexPath:IndexPath(row: 0, section: 1000)))
    }
    
    func testCellViewModel_ValidSectionIndex_DoesNotReturnNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertNotNil(viewModel.cellViewModel(indexPath:IndexPath(row: 0, section: 0)))
    }
    
    func testCellViewModel_ValidSectionIndex_ReturnsViewModelWithExpectedModelObject() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        let rowIndex = 0
        let sectionIndex = 0
        
        let cellViewModel = viewModel.cellViewModel(indexPath:IndexPath(row: rowIndex, section: sectionIndex))
        
        let expectedModelObject = viewModel.photoAlbum!.cities![sectionIndex].photos![rowIndex]
        
        XCTAssertEqual(cellViewModel!.photo, expectedModelObject)
    }
    
}


// MARK: headerViewModel tests
extension CollectionViewModelTests {
    
    func testHeaderViewModel_ValidViewModelNilAlbum_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        viewModel.photoAlbum = nil
        
        XCTAssertNil(viewModel.headerViewModel(indexPath:IndexPath(row: 0, section: 0)))
    }
    
    func testHeaderViewModel_ValidViewModelNilCities_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        viewModel.photoAlbum!.cities = nil
        
        XCTAssertNil(viewModel.headerViewModel(indexPath:IndexPath(row: 0, section: 0)))
    }
    
    func testHeaderViewModel_NegtiveSectionIndex_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertNil(viewModel.headerViewModel(indexPath:IndexPath(row: 0, section: -1)))
    }
    
    func testHeaderViewModel_OutOfBoundsSectionIndex_ReturnsNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertNil(viewModel.headerViewModel(indexPath:IndexPath(row: 0, section: 1000)))
    }
    
    func testHeaderViewModel_ValidSectionIndex_DoesNotReturnNil() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        XCTAssertNotNil(viewModel.headerViewModel(indexPath:IndexPath(row: 0, section: 0)))
    }
    
    func testHeaderViewModel_ValidSectionIndex_ReturnsViewModelWithExpectedSectionTitle() {
        let viewModel =  CollectionViewModel(view:mockCollectionViewController!)
        
        let rowIndex = 0
        let sectionIndex = 0
        
        let headerViewModel = viewModel.headerViewModel(indexPath:IndexPath(row: rowIndex, section: sectionIndex))
        
        let expectedSectionTitle = viewModel.photoAlbum!.cities![sectionIndex].cityName!
        
        XCTAssertEqual(headerViewModel!.sectionTitle, expectedSectionTitle)
        
    }
    
}
