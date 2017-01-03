//
//  City.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 25/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation

class City: NSObject {
    
    var cityName:String?
    var photos:[Photo]?
    
    let cityKey = "city"
    let photosKey = "photos"
    
    init?(_ dictionary:[String:AnyObject]?) {
        guard let dictionary = dictionary,
            let cityName = dictionary[cityKey] as? String,
            let array = dictionary[photosKey] as? [AnyObject] else {
                return nil
        }
        
        super.init()
        
        self.cityName = cityName
        self.photos = [Photo]()
        
        for item in array {
            guard let dictionary = item as? [String : AnyObject] else {
                continue
            }
            
            if let photo = Photo(dictionary) {
                photos?.append(photo)
            }
        }
    }
    
}
