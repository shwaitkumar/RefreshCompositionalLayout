//
//  SimpleCollectionViewCell.swift
//  RefreshCompositionalLayout
//
//  Created by WorksDelight on 07/06/23.
//

import UIKit

class SimpleCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "simple-cell-item-cell-reuse-identifier"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure(_ text: String) {
        label.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
    
        label.text = nil
    }
    
    private func configure() {
        contentView.backgroundColor = .lightGray
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(label)

        setConstraints()
    }

    private func setConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
