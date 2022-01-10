//
//  ActivityIndicatorCell.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 10/01/2022.
//

import UIKit

final class ActivityIndicatorCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.contentView.center
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.isHidden = false
    }
}
