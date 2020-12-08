//
//  DetailView.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 07.12.2020.
//

import UIKit

final class DetailView: UIView {

    // MARK: - Public Properties
    lazy var albumName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = self.labelColor
        label.numberOfLines = 0
        label.text = "name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    lazy var albumPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = self.labelColor
        label.numberOfLines = 0
        label.text = "price"
        label.translatesAutoresizingMaskIntoConstraints = false
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
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.hidesWhenStopped = true
        view.startAnimating()
        view.color = labelColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Private Properties
    private var bgColor: UIColor!
    private var labelColor: UIColor!

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Public Methods

    public func setInitUI(_ album: AlbumDetailModelProtocol) {

        let albumString = NSLocalizedString(LocStrings.Detail.album, comment: "")
        let priceString = NSLocalizedString(LocStrings.Detail.price, comment: "")
        let notSetString = NSLocalizedString(LocStrings.Detail.notSetString, comment: "")

        albumName.attributedText = String.atributedLblString(lhs: albumString,
                                                             rhs: album.albumName,
                                                             sizeMultiplayer: 1.3)
        if let price = album.collectionPrice {
            albumPrice.attributedText = String.atributedLblString(lhs: priceString,
                                                                  rhs: "\(price)",
                                                                  sizeMultiplayer: 1.3)
        } else {
            albumPrice.attributedText = String.atributedLblString(lhs: priceString,
                                                                  rhs: notSetString,
                                                                  sizeMultiplayer: 1.3)
        }
    }
    // MARK: - Private Methods
    private func setupView() {
        if #available(iOS 13.0, *) {
            bgColor = .systemBackground
            labelColor = .label
        } else {
            bgColor = .white
            labelColor = .black
        }

        backgroundColor = bgColor
        addViews()
    }

    private func addViews() {

        addSubview(albumName)
        addSubview(albumImage)
        addSubview(albumPrice)
        addSubview(activityIndicator)
        addSubview(tableView)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            albumImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            albumImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            albumImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1/4),
            albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor),

            albumName.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 4),
            albumName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            albumName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            albumPrice.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 4),
            albumPrice.leadingAnchor.constraint(equalTo: albumName.leadingAnchor),
            albumPrice.trailingAnchor.constraint(equalTo: albumName.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: albumPrice.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
