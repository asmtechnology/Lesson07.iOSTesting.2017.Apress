//
//  CollectionViewControllerProtocol.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation

protocol CollectionViewControllerProtocol : class {
    func setNavigationTitle(_ title:String) -> Void
    func setSectionInset(top:Float, left:Float, bottom:Float, right:Float) -> Void
    func setupCollectionViewCellToUseMaxWidth() -> Void
    func reloadCollectionView() -> Void
}
