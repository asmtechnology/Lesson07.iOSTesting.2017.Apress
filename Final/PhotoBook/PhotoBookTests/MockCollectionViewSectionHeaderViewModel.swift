//
//  MockCollectionViewSectionHeaderViewModel.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 27/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation
import XCTest

class MockCollectionViewSectionHeaderViewModel : CollectionViewSectionHeaderViewModel {
    
    var setupExpectation:XCTestExpectation?
    
    override func setup() {
        
        setupExpectation?.fulfill()
    }
    
}
