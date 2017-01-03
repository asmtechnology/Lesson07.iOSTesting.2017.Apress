//
//  UICollectionViewStub.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 27/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import UIKit

class UICollectionViewStub: UICollectionView {

    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        return CollectionViewCell()
    }
    
    override func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionReusableView {
        return CollectionViewSectionHeader()
    }

}
