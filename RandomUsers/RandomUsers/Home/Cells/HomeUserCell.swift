//
//  HomeUserCell.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation
import UIKit

final class HomeUserCell: UICollectionViewCell {
    var userViewModel: UserViewModel? {
        didSet {
            setupViews()
        }
    }
    
    var stackView: UIStackView?
    var thumbnailView: UIImageView?
    var nameLabel: UILabel?
    
    private func setupViews() {
        guard let userViewModel = userViewModel else { return }

        thumbnailView = UIImageView()
        thumbnailView?.contentMode = .scaleAspectFit
        if let url = URL(string: userViewModel.picture.thumbnail) {
            thumbnailView?.load(url: url)
        }
        
        nameLabel = UILabel()
        nameLabel?.text = userViewModel.fullname
        
        stackView = UIStackView(frame: self.bounds)
        stackView?.axis = .horizontal
        stackView?.alignment = .fill
        stackView?.distribution = .fillProportionally
        stackView?.addArrangedSubview(thumbnailView!)
        stackView?.addArrangedSubview(nameLabel!)
        
        addSubview(stackView!)
    }
    
    
}
