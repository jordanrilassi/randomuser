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
    var nameLabel: UILabel?
    
    private func setupViews() {
        nameLabel = UILabel()
        nameLabel?.text = userViewModel?.fullname
        
        stackView = UIStackView(frame: self.bounds)
        stackView?.axis = .horizontal
        stackView?.alignment = .fill
        stackView?.distribution = .fill
        stackView?.addArrangedSubview(nameLabel!)
        
        addSubview(stackView!)
    }
    
    
}
