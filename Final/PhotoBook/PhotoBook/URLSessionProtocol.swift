//
//  URLSessionProtocol.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 05/01/2017.
//  Copyright © 2017 ASM Technology Ltd. All rights reserved.
//

import Foundation

protocol URLSessionProtocol : class {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

extension URLSession : URLSessionProtocol {

}
