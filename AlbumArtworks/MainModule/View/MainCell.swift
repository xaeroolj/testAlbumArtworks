//
//  MainCell.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 07.12.2020.
//

import UIKit

class MainCell: UICollectionViewCell {

    // MARK: - Public Properties
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Placeholder"
        label.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            label.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
            label.layer.borderColor = UIColor.label.cgColor
            label.textColor = UIColor.label
        } else {
            label.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            label.layer.borderColor = UIColor.black.cgColor
            label.textColor = .black
        }
        label.layer.borderWidth = 0.0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5

        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    lazy var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appleSJM")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var backView: UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            view.layer.borderColor = UIColor.label.cgColor
        } else {
            view.backgroundColor = .white
            view.layer.borderColor = UIColor.black.cgColor
        }
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addViews()
    }

    // MARK: - Private Methods
    private func addViews() {

        addSubview(backView)
        backView.addSubview(nameLabel)
        backView.addSubview(albumImage)
        backView.bringSubviewToFront(nameLabel)

        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
            albumImage.topAnchor.constraint(equalTo: topAnchor),
            albumImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            albumImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
