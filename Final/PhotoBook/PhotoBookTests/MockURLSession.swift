//
//  MockURLSession.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 05/01/2017.
//  Copyright © 2017 ASM Technology Ltd. All rights reserved.
//

import Foundation
import XCTest

class MockURLSession : URLSessionProtocol {
    
    var dataTaskExpectation:(XCTestExpectation, expectedURL:URL)?
    var dataTaskToReturn:MockURLSessionDataTask?
    
    init() {
        self.dataTaskToReturn = MockURLSessionDataTask()
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        if let (expectation, expectedValue) = self.dataTaskExpectation {
            if expectedValue.absoluteString.compare(url.absoluteString) == .orderedSame {
                expectation.fulfill()
            }
        }
        
        self.dataTaskToReturn?.completionHandler = completionHandler
        return self.dataTaskToReturn!
    }
        
}
