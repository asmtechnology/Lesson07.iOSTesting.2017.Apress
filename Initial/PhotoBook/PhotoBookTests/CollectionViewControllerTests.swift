//
//  CollectionViewControllerTests.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 27/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import XCTest

class CollectionViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewDidLoad_Calls_PerformInitialSetup_OnViewModel() {
        
        let expectation = self.expectation(description: "expected performInitialViewSetup() to be called")
        
        let collectionViewController = CollectionViewController()
        
        let viewModel = MockCollectionViewModel(view:collectionViewController)
        viewModel.performInitialViewSetupExpectation = expectation
        
        collectionViewController.viewModel = viewModel
        
        collectionViewController.viewDidLoad()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testNumberOfSections_ValidViewModel_Calls_NumberOfSections_OnViewModel() {
        
        let expectation = self.expectation(description: "expected numberOfSections() to be called")
        
        let collectionViewController = CollectionViewController()
        collectionViewController.view = UICollectionViewStub()
        
        let viewModel = MockCollectionViewModel(view:collectionViewController)
        viewModel.numberOfSectionsExpectation = expectation
        
        collectionViewController.viewModel = viewModel
        
        let _ = collectionViewController.numberOfSections(in: collectionViewController.view as! UICollectionView)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testNumberOfItemsInSection_ValidViewModel_Calls_NumberOfItemsInSection_OnViewModel() {
        
        let expectation = self.expectation(description: "expected numberOfItemsInSection() to be called")
        
        let collectionViewController = CollectionViewController()
        
        let stubCollectionView = UICollectionViewStub()
        collectionViewController.view = stubCollectionView
        
        let viewModel = MockCollectionViewModel(view:collectionViewController)
        viewModel.numberOfItemsInSectionExpectation = (expectation, 1)
        
        collectionViewController.viewModel = viewModel
        
        let _ = collectionViewController.collectionView(stubCollectionView, numberOfItemsInSection: 1)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    
    func testCellForItem_ValidViewModel_Calls_CellViewModel_OnViewModel() {
        
        let expectation = self.expectation(description: "expected cellViewModel() to be called")
        
        let stubCollectionView = UICollectionViewStub()
        
        let collectionViewController = CollectionViewController()
        collectionViewController.view = stubCollectionView
        
        let viewModel = MockCollectionViewModel(view:collectionViewController)
        viewModel.cellViewModelExpectation = (expectation, IndexPath(item: 0, section: 0))
        
        collectionViewController.viewModel = viewModel
        
        let _ = collectionViewController.collectionView(stubCollectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testViewForSupplementaryElementOfKind_ValidViewModel_Calls_HeaderViewModel_OnViewModel() {
        
        let expectation = self.expectation(description: "expected headerViewModel() to be called")
        
        let collectionViewController = CollectionViewController()
        
        let stubCollectionView = UICollectionViewStub()
        collectionViewController.view = stubCollectionView
        
        let viewModel = MockCollectionViewModel(view:collectionViewController)
        viewModel.headerViewModelExpectation = (expectation, IndexPath(item: 0, section: 0))
        
        collectionViewController.viewModel = viewModel
        
        let _ = collectionViewController.collectionView(stubCollectionView, viewForSupplementaryElementOfKind: "Any", at: IndexPath(item: 0, section: 0))
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
