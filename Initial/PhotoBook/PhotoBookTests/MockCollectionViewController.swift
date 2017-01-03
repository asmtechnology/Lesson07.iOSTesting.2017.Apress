//
//  MockCollectionViewController.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import UIKit
import XCTest

class MockCollectionViewController : CollectionViewControllerProtocol {
    
    var expectationForSetNavigationTitle:XCTestExpectation?
    var expectationForSetSectionInset:XCTestExpectation?
    var expectationForSetupCollectionViewCellToUseMaxWidth:XCTestExpectation?
    
    func setNavigationTitle(_ title:String) -> Void {
        expectationForSetNavigationTitle?.fulfill()
    }
    
    func setSectionInset(top:Float, left:Float, bottom:Float, right:Float) -> Void {
        expectationForSetSectionInset?.fulfill()
    }
    
    func setupCollectionViewCellToUseMaxWidth() -> Void {
        expectationForSetupCollectionViewCellToUseMaxWidth?.fulfill()
    }
    
}
