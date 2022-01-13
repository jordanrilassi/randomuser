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
        thumbnailView?.image = UIImage(systemName: "person.circle")
        thumbnailView?.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        thumbnailView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLabel = UILabel()
        countryLabel = UILabel()
        countryLabel?.font = .systemFont(ofSize: 12)
        countryLabel?.textColor = .gray
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.addArrangedSubview(nameLabel!)
        labelsStackView.addArrangedSubview(countryLabel!)
        labelsStackView.alignment = .fill
        labelsStackView.distribution = .fillProportionally
        labelsStackView.spacing = -5

        stackView = UIStackView(frame: CGRect(x: 10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height))
        stackView?.axis = .horizontal
        stackView?.alignment = .fill
        stackView?.distribution = .fillProportionally
        stackView?.spacing = 10
        stackView?.addArrangedSubview(thumbnailView!)
        stackView?.addArrangedSubview(labelsStackView)
        stackView?.addArrangedSubview(UIView())
        
        addSubview(stackView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var stackView: UIStackView?
    var thumbnailView: UIImageView?
    var nameLabel: UILabel?
    var countryLabel: UILabel?
    
    func setupView(with userViewModel: UserViewModel) {
        if let url = URL(string: userViewModel.picture.thumbnail) {
            thumbnailView?.load(url: url) { [weak self] in
                self?.thumbnailView?.roundedCorner()
            }
        }
        
        nameLabel?.text = userViewModel.fullname
        countryLabel?.text = userViewModel.country
        countryLabel?.sizeToFit()
    }
}
