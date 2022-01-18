//
//  UIImageView+Extension.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 10/01/2022.
//

import UIKit

extension UIImageView {
    private func executeCompletion(completion: (() -> Void)? = nil) {
        guard let completion = completion else { return }
        completion()
    }
    
    func load(urlString: String, completion: (() -> Void)? = nil) {
        if let image = CacheManager.shared.getImage(key: urlString) {
                self.image = image
                executeCompletion(completion: completion)
        } else {
            guard let url = URL(string: urlString) else {
                executeCompletion(completion: completion)
                return
            }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            CacheManager.shared.saveImage(image: image, key: urlString)
                            self?.executeCompletion(completion: completion)
                        }
                    }
                }
            }
        }
    }
    
    func roundedCorner() {
        self.layer.cornerRadius = bounds.width / 2
        self.clipsToBounds = true
    }
}
