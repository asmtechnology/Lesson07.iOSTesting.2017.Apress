//
//  MockCollectionViewCell.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation
import XCTest

class MockCollectionViewCell : CollectionViewCellProtocol {
    
    var expectationForLoadImage:(XCTestExpectation, String?)?
    var expectationForSetCaption:(XCTestExpectation, String?)?
    var expectationForSetupShotDetails:(XCTestExpectation, String?)?
    
    func setCaption(captionText:String) {
        guard let (expectation, expectedValue) = self.expectationForSetCaption else {
            return
        }
        
        if let expectedValue = expectedValue {
            if (captionText.compare(expectedValue) != .orderedSame) {
                return
            }
        }
        
        expectation.fulfill()
    }
    
    func setShotDetails(shotDetailsText:String) {
        guard let (expectation, expectedValue) = self.expectationForSetupShotDetails else {
            return
        }
        
        if let expectedValue = expectedValue {
            if (shotDetailsText.compare(expectedValue) != .orderedSame) {
                return
            }
        }
        
        expectation.fulfill()
    }
    
    func updateImage(image: UIImage?) {
        
    }
}
