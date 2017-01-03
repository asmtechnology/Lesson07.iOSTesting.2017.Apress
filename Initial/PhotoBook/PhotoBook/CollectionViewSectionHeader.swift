//
//  CollectionViewSectionHeader.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 23/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import UIKit

class CollectionViewSectionHeader: UICollectionReusableView {
        
    @IBOutlet weak var title: UILabel!
    
    var viewModel:CollectionViewSectionHeaderViewModel?
    
    func setup() {
        viewModel?.setup()
    }
}

extension CollectionViewSectionHeader : CollectionViewSectionHeaderProtocol {
    
    func setHeaderText(text:String) {
        title?.text = text
    }
    
}
