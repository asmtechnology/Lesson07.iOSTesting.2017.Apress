//
//  MockCollectionViewModel.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 27/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation
import XCTest

class MockCollectionViewModel : CollectionViewModel {
    
    var performInitialViewSetupExpectation:XCTestExpectation?
    var numberOfSectionsExpectation:XCTestExpectation?
    var numberOfItemsInSectionExpectation:(XCTestExpectation, expectedSectionIndex:Int)?
    var cellViewModelExpectation:(XCTestExpectation, expectedIndexPath:IndexPath)?
    var headerViewModelExpectation:(XCTestExpectation, expectedIndexPath:IndexPath)?
    
    override func performInitialViewSetup() {
        performInitialViewSetupExpectation?.fulfill()
    }
    
    override func numberOfSections() -> Int {
        numberOfSectionsExpectation?.fulfill()
        return 0
    }
    
    override func numberOfItemsInSection(_ section: Int) -> Int {
        if let (expectation, expectedValue) = self.numberOfItemsInSectionExpectation {
            if section == expectedValue {
                expectation.fulfill()
            }
        }
        
        return 0
    }
    
    override func cellViewModel(indexPath:IndexPath) -> CollectionViewCellViewModel? {

        if let (expectation, expectedValue) = self.cellViewModelExpectation {
            if indexPath == expectedValue {
                expectation.fulfill()
            }
        }
        
        return nil
    }
    
    override func headerViewModel(indexPath:IndexPath) -> CollectionViewSectionHeaderViewModel? {
        
        if let (expectation, expectedValue) = self.headerViewModelExpectation {
            if indexPath == expectedValue {
                expectation.fulfill()
            }
        }
        

        return nil
    }
    
}
