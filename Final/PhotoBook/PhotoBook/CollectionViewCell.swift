//
//  CollectionViewCell.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 23/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var shotDetailsLabel: UILabel!
 
    var viewModel:CollectionViewCellViewModel?
    
    func setup() {
        viewModel?.setup()
    }
}

extension CollectionViewCell : CollectionViewCellProtocol {
    
    func loadImage(resourceName:String) {
        imageView.image = UIImage(named: resourceName)
    }
    
    func setCaption(captionText:String) {
        captionLabel.text = captionText
    }
    
    func setShotDetails(shotDetailsText:String) {
        shotDetailsLabel.text = shotDetailsText
    }
    
}
