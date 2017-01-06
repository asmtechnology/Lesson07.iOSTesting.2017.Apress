//
//  DownloadListenerProtocol.swift
//  PhotoBook
//
//  Created by Abhishek Mishra on 06/01/2017.
//  Copyright © 2017 ASM Technology Ltd. All rights reserved.
//

import Foundation

protocol DownloadListenerProtocol : class {
    func didDownloadImage() -> Void
}
