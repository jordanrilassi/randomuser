//
//  UIImageView+Extension.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 10/01/2022.
//

import UIKit

extension UIImageView {
    func load(url: URL, completion: (() -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        guard let completion = completion else { return }
                        completion()
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
