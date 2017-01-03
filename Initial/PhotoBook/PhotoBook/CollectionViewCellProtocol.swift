//
//  CollectionViewCellProtocol.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation

protocol CollectionViewCellProtocol : class {
    func loadImage(resourceName:String)
    func setCaption(captionText:String)
    func setShotDetails(shotDetailsText:String)
}
