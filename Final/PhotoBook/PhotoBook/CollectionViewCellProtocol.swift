//
//  CollectionViewCellProtocol.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewCellProtocol : class {
    func setCaption(captionText:String)
    func setShotDetails(shotDetailsText:String)
    func updateImage(image:UIImage?)
}
