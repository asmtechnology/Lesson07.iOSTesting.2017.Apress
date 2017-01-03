//
//  CollectionViewSectionHeaderViewModel.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation

class CollectionViewSectionHeaderViewModel : NSObject {
    
    var sectionTitle:String?
    var collectionViewSectionHeader:CollectionViewSectionHeaderProtocol?
    
    init?(model:String?) {
        
        guard let model = model else {
            return nil
        }
        
        super.init()
        self.sectionTitle = model
    }
    
    func setView(_ view:CollectionViewSectionHeaderProtocol) {
        self.collectionViewSectionHeader = view
    }
    
    func setup() {
        
        guard let collectionViewSectionHeader = collectionViewSectionHeader ,
            let sectionTitle = sectionTitle else {
                return
        }
        
        collectionViewSectionHeader.setHeaderText(text: sectionTitle)
    }
    
}

