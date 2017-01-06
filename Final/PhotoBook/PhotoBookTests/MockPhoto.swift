//
//  MockPhoto.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 06/01/2017.
//  Copyright © 2017 ASM Technology Ltd. All rights reserved.
//

import Foundation
import XCTest

class MockPhoto : Photo {
    
    var downloadImageExpectation: XCTestExpectation?
    
    override func downloadImage() -> Void {
        downloadImageExpectation?.fulfill()
        super.downloadImage()
    }
    
}
