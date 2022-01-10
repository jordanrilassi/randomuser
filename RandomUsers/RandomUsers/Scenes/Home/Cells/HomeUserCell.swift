//
//  HomeUserCell.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation
import UIKit

final class HomeUserCell: UICollectionViewCell {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        thumbnailView = UIImageView()
        thumbnailView?.tintColor = .gray
        thumbnailView?.contentMode = .scaleAspectFit

        nameLabel = UILabel()

        stackView = UIStackView(frame: CGRect(x: 10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height))
        stackView?.axis = .horizontal
        stackView?.alignment = .fill
        stackView?.distribution = .fill
        stackView?.spacing = 10
        stackView?.addArrangedSubview(thumbnailView!)
        stackView?.addArrangedSubview(nameLabel!)
        stackView?.addArrangedSubview(UIView())
        
        addSubview(stackView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var stackView: UIStackView?
    var thumbnailView: UIImageView?
    var nameLabel: UILabel?
    
    func setupView(with userViewModel: UserViewModel) {
        thumbnailView?.image = UIImage(systemName: "person.circle")

        if let url = URL(string: userViewModel.picture.thumbnail) {
            thumbnailView?.load(url: url)
        }
        
        nameLabel?.text = userViewModel.fullname
    }
}
