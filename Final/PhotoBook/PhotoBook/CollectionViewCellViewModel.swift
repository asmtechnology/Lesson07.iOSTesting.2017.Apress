//
//  CollectionViewCellViewModel.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 26/12/2016.
//  Copyright © 2016 ASM Technology Ltd. All rights reserved.
//

import Foundation

class CollectionViewCellViewModel : NSObject {
    
    weak var photo:Photo?
    var collectionViewCell:CollectionViewCellProtocol?
    
    init?(model:Photo?) {
        
        guard let model = model else {
            return nil
        }
        
        super.init()
        self.photo = model
        photo?.listener = self
    }
    
    func setView(_ view:CollectionViewCellProtocol) {
        self.collectionViewCell = view
    }
    
    func setup() {
        
        guard let collectionViewCell = collectionViewCell ,
            let photo = photo,
            let aperture = photo.aperture,
            let shutterSpeed = photo.shutterSpeed,
            let iso = photo.iso,
            let comments = photo.comments else {
                return
        }
        
        collectionViewCell.updateImage(image: photo.downloadedImage)
        collectionViewCell.setCaption(captionText: comments)
        collectionViewCell.setShotDetails(shotDetailsText: "\(aperture), \(shutterSpeed), ISO \(iso)")
    }
    
}


extension CollectionViewCellViewModel : DownloadListenerProtocol {
    func didDownloadImage() -> Void {
        DispatchQueue.main.async {
            self.collectionViewCell?.updateImage(image: self.photo?.downloadedImage)
        }
    }
}
