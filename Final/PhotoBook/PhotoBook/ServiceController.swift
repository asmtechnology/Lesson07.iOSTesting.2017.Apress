//
//  ServiceController.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 03/01/2017.
//  Copyright © 2017 ASM Technology Ltd. All rights reserved.
//

import Foundation

class ServiceController : NSObject {
 
    var session:URLSessionProtocol?
    private var dataTask:URLSessionDataTask?
    
    override init() {
        super.init()
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func fetchFromURL(urlString:String?,
              success:@escaping (Data) -> Void,
              failure:@escaping (NSError) -> Void) -> Void {
        
        guard let session = session else {
            failure(NSError(domain: "ServiceController", code:100, userInfo: nil))
            return
        }
        
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                failure(NSError(domain: "ServiceController", code:101, userInfo: nil))
                return
        }
        
        dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error {
                failure(error as NSError)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                let data = data {
                if response.statusCode == 200 {
                    success(data)
                    return
                }
            }
            
            failure(NSError(domain: "ServiceController", code:102, userInfo: nil))
            return
        })
        
        dataTask?.resume()
    }
    
}
