//
//  MockDownloadListener.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 06/01/2017.
//  Copyright © 2017 ASM Technology Ltd. All rights reserved.
//

import Foundation
import XCTest

class MockDownloadListener : DownloadListenerProtocol {
    
    var didDownloadImageExpectation:XCTestExpectation?
    
    func didDownloadImage() -> Void {
        didDownloadImageExpectation?.fulfill()
    }
}
