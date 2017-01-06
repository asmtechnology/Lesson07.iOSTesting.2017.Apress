//
//  MockServiceController.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 05/01/2017.
//  Copyright © 2017 ASM Technology Ltd. All rights reserved.
//

import Foundation
import XCTest

class MockServiceController : ServiceController {
    
    var fetchFromURLExpectation:(XCTestExpectation, expectedURLString:String)?
    var shouldFailOnFetch:Bool = false
    var dataToReturnOnSuccess:Data?
    
    override func fetchFromURL(urlString: String?, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void) {
        
        if let (expectation, expectedValue) = self.fetchFromURLExpectation {
            if urlString?.compare(expectedValue) == .orderedSame {
                expectation.fulfill()
            }
        }

        if shouldFailOnFetch == true {
            failure(NSError(domain: "ServiceController", code:102, userInfo: nil))
            return
        }
        
        if let dataToReturnOnSuccess = dataToReturnOnSuccess {
            success(dataToReturnOnSuccess)
            return
        }
        
        super.fetchFromURL(urlString: urlString, success: success, failure: failure)
    }
}
