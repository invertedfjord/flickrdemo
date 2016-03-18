//
//  flickrPhoto.swift
//  newflickrapp
//
//  Created by alex berkson on 1/15/16.
//  Copyright © 2016 alex berkson. All rights reserved.
//

import UIKit

class flickrPhoto: NSObject {
    
    let photoID : String
    let farm : String
    let server : String
    let secret : String
    var url : String?
    
    init(photoID: String, farm: String, server: String, secret: String) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }

}
