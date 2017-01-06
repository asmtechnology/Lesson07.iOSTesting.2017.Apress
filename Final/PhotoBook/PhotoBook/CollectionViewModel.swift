//
//  CollectionViewModel.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation

class CollectionViewModel : NSObject {
    
    var photoAlbum:Album?
    
    weak var view:CollectionViewControllerProtocol?
    
    init(view:CollectionViewControllerProtocol) {
        super.init()
        self.view = view
        
        if photoAlbum == nil {
            photoAlbum = Album()
        }
        
//        let path = Bundle.main.path(forResource: "Albums", ofType: "plist")
//        photoAlbum?.load(filePath:path)
    }
    
    func performInitialViewSetup() {
        view?.setNavigationTitle("Photo Album")
        view?.setSectionInset(top: 20, left: 0, bottom: 0, right: 0)
        view?.setupCollectionViewCellToUseMaxWidth()
    }
    
    func numberOfSections() -> Int {
        guard let photoAlbum = photoAlbum,
            let cities = photoAlbum.cities else {
                return 0
        }
        
        return cities.count
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        guard let photoAlbum = photoAlbum,
            let cities = photoAlbum.cities else {
                return 0
        }
        
        if ((section < 0) || (section >= cities.count)) {
            return 0
        }
        
        guard let photos = cities[section].photos else {
            return 0
        }
        
        return photos.count
    }
    
    func cellViewModel(indexPath:IndexPath) -> CollectionViewCellViewModel? {
        
        guard let photoAlbum = photoAlbum,
            let cities = photoAlbum.cities else {
                return nil
        }
        
        if ((indexPath.section < 0) || (indexPath.section >= cities.count)) {
            return nil
        }
        
        guard let photos = cities[indexPath.section].photos else {
            return nil
        }
        
        if ((indexPath.row < 0) || (indexPath.row >= photos.count)) {
            return nil
        }
        
        return CollectionViewCellViewModel(model:photos[indexPath.row])
    }
    
    func headerViewModel(indexPath:IndexPath) -> CollectionViewSectionHeaderViewModel? {
        guard let photoAlbum = photoAlbum,
            let cities = photoAlbum.cities else {
                return nil
        }
        
        if ((indexPath.section < 0) || (indexPath.section >= cities.count)) {
            return nil
        }
        
        return CollectionViewSectionHeaderViewModel(model:cities[indexPath.section].cityName)
    }
}
