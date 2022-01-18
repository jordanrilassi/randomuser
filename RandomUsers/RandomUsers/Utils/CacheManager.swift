//
//  CacheManager.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 18/01/2022.
//

import UIKit

class CacheManager {
    static let shared = CacheManager()
    
    var nsCache = NSCache<NSString, UIImage>()
    
    func saveImage(image: UIImage, key: String) {
        nsCache.setObject(image, forKey: NSString(string: key))
    }
    
    func getImage(key: String) -> UIImage? {
        nsCache.object(forKey: NSString(string: key))
    }
}
