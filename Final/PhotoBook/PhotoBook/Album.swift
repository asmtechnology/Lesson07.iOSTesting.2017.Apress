//
//  Album.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 25/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation

class Album: NSObject {
    
    var serviceController = ServiceController()
    
    var cities:[City]?
    
    override init() {
        super.init()
        
        if cities == nil {
            cities = [City]()
        }
    }
    
    func load(urlString:String?,
              success:@escaping (Void) -> Void,
              failure:@escaping (NSError) -> Void) -> Void {
        
        serviceController.fetchFromURL(urlString: urlString,
                                       success: { (receivedData) in
                                        
                                        guard let array = try? JSONSerialization.jsonObject(with: receivedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray else {
                                            
                                            failure(NSError(domain: "PhotoBook.Album", code:200, userInfo: nil))
                                            return
                                        }
                                        
                                        for item in array! {
                                            guard let dictionary = item as? [String : AnyObject] else {
                                                continue
                                            }
                                            
                                            if let city = City(dictionary) {
                                                self.cities?.append(city)
                                            }
                                        }
                                        
                                        success()
                                        
        },
                                       failure: { (error) in
                                        failure(error)
        })
        
    }
}
